# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-11 19:24:03
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-12 19:09:56

import paramiko
import os
import socket
import time
import threading
from enum import Enum

# Return Codes:
# 0 - OK
# 1 - Tests Failed - Credentials have been discovered!
# 2 - Impossible to gather the usernames to use in this test
# 3 - Impossible to gather the password to use in this test
# 4 - Impossible to perform the SSH Bruteforce test


class TestStatus(Enum):
    OK = 0
    CREDENTIALS_DISCOVERED = 1
    SSH_SERVER_UNREACHABLE = 2


CURRENT_TEST_STATUS = TestStatus.OK
MAX_CREDENTIALS_PAIRS_TO_TEST = 1500


def is_ssh_open(thread_id, hostname, port, credentials, results):
    global CURRENT_TEST_STATUS
    while True:
        # If the credentials have been discovered
        # (TestStatus.CREDENTIALS_WERE_DISCOVERED), stop the thread and finish
        # the test.
        # Or...
        # If most of the times the test was not able to reach the host
        # (TestStatus.SSH_SERVER_UNREACHABLE), stop the thread and finish
        # the test
        if CURRENT_TEST_STATUS != TestStatus.OK:
            return

        # Check if there are still more credentials to test
        if credentials:
            credential = credentials.pop(0)
            # print(f"Thread {thread_id} will test the credentials " +
            #      f"{credential}.")

            # initialize SSH client
            client = paramiko.SSHClient()
            # add to know hosts
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            while True:
                try:
                    client.connect(
                        hostname=hostname,
                        username=credential[0],
                        password=credential[1],
                        port=port,
                        timeout=2,
                    )
                except socket.timeout:
                    # when host is unreachable
                    print(f"[!] Host: {hostname} is unreachable, timed out.")
                    client.close()
                    results[credential] = "UNREACHABLE"
                    # If there have been more then 40 attempts to discover
                    # the credentials, and at least 50% of them resulted in
                    # the SSH server being unreachable, then stop all threads
                    # and finish the test
                    if len(results) >= 40 and list(results.values())\
                            .count("UNREACHABLE")/len(results) > 0.5:
                        CURRENT_TEST_STATUS = TestStatus.SSH_SERVER_UNREACHABLE
                    break
                except paramiko.AuthenticationException:
                    print("[!] Invalid credentials: " +
                          f"{credential[0]}:{credential[1]}")
                    client.close()
                    results[credential] = "INVALID_CREDENTIALS"
                    break
                except paramiko.ssh_exception.SSHException:
                    print("[*] Quota exceeded, retrying with a delay of 10 " +
                          "seconds...")
                    # sleep for a minute
                    time.sleep(10)
                    return is_ssh_open(thread_id, hostname, port)
                else:
                    client.close()
                    # connection was established successfully
                    print("[+] Found the credentials...")
                    results[credential] = "CREDENTIALS_DISCOVERED"
                    CURRENT_TEST_STATUS = TestStatus.CREDENTIALS_DISCOVERED
                    break
        else:
            break


def ssh_brute_force_test(username, max_pws_to_test, max_users_to_test,
                         target_ip, target_port):
    global CURRENT_TEST_STATUS
    try:
        # If client discloses the username of the VM, it shall be used to
        # perform the SSH Bruteforce test
        usernames = []
        if username != "NONE":
            usernames = [username]
        # Else, the test shall rely on a list of the most used usernames
        else:
            # Verify how many different users shall be used during the test
            if max_users_to_test == "NONE":
                max_users_to_test = -1
            else:
                max_users_to_test = int(max_users_to_test)

            # Load usernames from file
            usernames_list_file_path = None
            if os.getenv("usernames_list_file_path") is not None:
                usernames_list_file_path = os.getenv(
                    "usernames_list_file_path"
                )
            else:
                usernames_list_file_path = os.path.join(
                    "/var", "lib", "jenkins", "test_artifacts",
                    os.getenv("JOB_NAME"), "most-common-usernames.txt"
                )

            # Gather the usernames
            f = open(usernames_list_file_path, 'r')
            line_counter = 0
            for line in f:
                usernames.append(line.strip())
                line_counter += 1
                if line_counter == max_users_to_test:
                    break
            f.close()
    except Exception as e:
        return 2, "Impossible to gather the usernames to use in this test. "\
            f"Exception {e}!"

    try:
        # How many different passwords shall be used during the test?
        if max_pws_to_test == "NONE":
            max_pws_to_test = -1
        else:
            max_pws_to_test = int(max_pws_to_test)

        # Load password from file
        passwords_list_file_path = None
        if os.getenv("passwords_list_file_path") is not None:
            passwords_list_file_path = os.getenv("passwords_list_file_path")
        else:
            passwords_list_file_path = os.path.join(
                "/var", "lib", "jenkins", "test_artifacts",
                os.getenv("JOB_NAME"), "1000-most-common-passwords.txt"
            )

        # Gather passwords
        passwords = []
        f = open(passwords_list_file_path, 'r')
        line_counter = 0
        for line in f:
            passwords.append(line.strip())
            line_counter += 1
            if line_counter == max_pws_to_test:
                break
        f.close()
    except Exception as e:
        return 3, "Impossible to gather the password to use in this test. "\
            f"Exception {e}!"

    # Try to brute force the credentials
    try:
        target_port = int(target_port)
        # results will be stored in this dictionary
        results = {}
        # Trim the maximum number of credentials to be tested to the value of
        # MAX_CREDENTIALS_PAIRS_TO_TEST
        credentials = [
            (username, password)
            for username in usernames
            for password in passwords
        ][:MAX_CREDENTIALS_PAIRS_TO_TEST]

        # Start threads to test the credentials
        threads = []
        for i in range(12):
            t = threading.Thread(target=is_ssh_open, args=(
                i,
                target_ip,
                target_port,
                credentials,
                results,
                )
            )
            t.start()
            threads.append(t)

        for t in threads:
            t.join()

        # Test Outputs
        if CURRENT_TEST_STATUS == TestStatus.SSH_SERVER_UNREACHABLE:
            raise Exception("SSH Server's connection is not stable.")
        if CURRENT_TEST_STATUS == TestStatus.CREDENTIALS_DISCOVERED:
            return 1, "Credentials were discovered!"

        return 0, "Test Successfull. No credentials were discovered!"
    except Exception as e:
        return 4, "Impossible to perform the SSH Bruteforce test. "\
            f"Exception: {e}!"