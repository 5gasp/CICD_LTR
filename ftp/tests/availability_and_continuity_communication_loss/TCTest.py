#!/usr/bin/env python
import subprocess
import os

def process_command(command):
    result = subprocess.call(command, shell=True)
    return result

# --------------------------- INSTALL REQUIREMENTS -------------------------- #
def install_requirements():
    curr_dir = os.path.dirname(os.path.realpath(__file__))

    # Install requirements
    requirements_file_path = os.path.join(curr_dir, "", "requirements.txt")
    ret_code = process_command(
        f"python -m pip install -r {requirements_file_path}"
    )
    if ret_code != 0:
        return "Error: Couldn't install the requirements"
    print("Requirements installed")

    return "Success: Requirements installed"


install_requirements()
# ----------------------- END OF INSTALL REQUIREMENTS ----------------------- #

import requests
import socket
import dns.resolver
import logging
import time

def getAuthBearer(username: str, password: str, nef_url: str) -> str:
    print("Nef url still at "+nef_url)
    headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    data = {
        "grant_type": "",
        "username": "admin@my-email.com",
        "password": "pass",
        "scope": "",
        "client_id": "",
        "client_secret": ""
    }
    logging.info(nef_url.rstrip("/")+"/api/v1/login/access-token")
    response = requests.post(nef_url.rstrip("/")+"/api/v1/login/access-token", headers=headers, data=data)

    if response.status_code == 200:
        logging.info("Got bearer successfully!")
        # Do something with the response data
        data = response.json()
        logging.info(data)
        return data["access_token"]
    else:
        # Handle the error
        logging.error("Request failed with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        return None

def getIP():

    # Set the hostname that you want to look up
    hostname = "cameraaistr.fidegad.external.ip"

    try:
        # Use the socket module to get the IP address of the pod's default DNS server
        dns_server = socket.gethostbyname("kube-dns.kube-system.svc.cluster.local")
    except:
        return "127.0.0.1"
    # Use the dns.resolver module to perform the nslookup using the pod's default DNS server
    resolver = dns.resolver.Resolver(configure=False)
    resolver.nameservers = [dns_server]
    result = resolver.resolve(hostname)

    # Print the IP addresses returned by the nslookup
    for ip in result:
        return ip

def createNEFMonitoringSubscription(bearer, nef_url, externalId):
    streaming_server_ip_address = getIP()
    print("Streaming Server IP address by kubernetes: " + str(streaming_server_ip_address))
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + bearer
    }
    data = {
        "externalId": externalId,
        "notificationDestination": "http://" + str(streaming_server_ip_address) + ":85/handover_event_hook",
        "monitoringType": "LOCATION_REPORTING",
        "maximumNumberOfReports": 1000,
        "monitorExpireTime": "2025-02-12T09:06:50.811Z",
        "maximumDetectionTime": 1000,
        "reachabilityType": "DATA"
    }

    response = requests.post(
        nef_url.rstrip('/') + "/nef/api/v1/3gpp-monitoring-event/v1/myNetapp/subscriptions"
        , headers=headers
        , json=data
    )

    if response.status_code == 201:
        logging.info("Subscription succeeded with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        # Do something with the response data
        data = response.json()
        logging.info(data)
        return True
    else:
        # Handle the error
        logging.error("Subscription request failed with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        return False

def startMovingUE(bearer, nef_url, supi):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + bearer
    }
    data = {
        "supi": supi
    }

    response = requests.post(
        nef_url.rstrip('/') + "/api/v1/ue_movement/start-loop"
        , headers=headers
        , json=data
    )

    if response.status_code == 200:
        logging.info("Start looping of UE with SUPI "+supi+ " succeded with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        # Do something with the response data
        data = response.json()
        logging.info(data)
        return True
    else:
        # Handle the error
        logging.info(
            "Start looping of UE with SUPI " + supi + " failed with status code:" + str(response.status_code) + response.content.decode(
                'utf-8'))
        return False

def stopMovingUE(bearer, nef_url, supi):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + bearer
    }
    data = {
        "supi": supi
    }

    response = requests.post(
        nef_url.rstrip('/') + "/api/v1/ue_movement/stop-loop"
        , headers=headers
        , json=data
    )

    if response.status_code == 200:
        logging.info("Stop looping of UE with SUPI "+supi+ " succeeded with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        # Do something with the response data
        data = response.json()
        logging.info(data)
        return True
    else:
        # Handle the error
        logging.info("Stop looping of UE with SUPI " + supi + " failed with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        return False

def deleteNEFMonitoringSubscription(bearer, nef_url, externalId):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + bearer
    }
    response = requests.get(
        nef_url.rstrip('/') + "/nef/api/v1/3gpp-monitoring-event/v1/myNetapp/subscriptions"
        , headers=headers
    )

    if 200 <= response.status_code < 300:
        logging.info("Get Subscription succeeded with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        if len(response.content) > 0:
            # Do something with the response data
            data = response.json()
            for row in data:
                if row["externalId"] == externalId:
                    delete_response = requests.delete(row["link"], headers=headers)
                    if delete_response.status_code == 200:
                        logging.info("Deletion of  Subscription request of " + row["externalId"] + " succeeded with status code: " + str(
                            delete_response.status_code) + delete_response.content.decode('utf-8'))
                    else:
                        logging.error("Deletion of Subscription request of " + row["externalId"] + " failed with status code: " + str(
                            delete_response.status_code) + delete_response.content.decode('utf-8'))
                        return False
            logging.info(data)
        else:
            logging.info("No active subscriptions found")
        return True
    else:
        # Handle the error
        logging.error("Subscription deletion request failed with status code:" + str(response.status_code) + response.content.decode('utf-8'))
        return False

def iterateForAUE(nef_url: str, ue: str, timeforacircle: str)-> str :
    try:
        bearer = getAuthBearer("admin@my-email.com", "pass", nef_url)
        if bearer is not None:
            stopMovingUE(bearer, nef_url, "202010000000004")
            stopMovingUE(bearer, nef_url, "202010000000005")
            stopMovingUE(bearer, nef_url, "202010000000006")
            stopMovingUE(bearer, nef_url, "202010000000007")
            stopMovingUE(bearer, nef_url, "202010000000008")
    except ConnectionError:
        logging.error("Connection with NEF failed!")
        return -1
    except:
        logging.error("Communication with NEF failed!")
        return -1

    try:
        bearer = getAuthBearer("admin@my-email.com", "pass", nef_url)
        if bearer is not None:
            createNEFMonitoringSubscription(bearer, nef_url, "1000" + ue + "@domain.com")
            startMovingUE(bearer, nef_url, "20201000000000" + ue)
            time.sleep(int(timeforacircle) * 2)
            stopMovingUE(bearer, nef_url, "20201000000000" + ue)
            deleteNEFMonitoringSubscription(bearer, nef_url, "1000" + ue + "@domain.com")
            return "Success"
    except ConnectionError:
        logging.error("Connection with NEF failed!")
    except:
        logging.error("Communication with NEF failed!")
    return -1

# -------------------------- UNINSTALL REQUIREMENTS ------------------------- #
def uninstall_requirements():
    curr_dir = os.path.dirname(os.path.realpath(__file__))

    # Install requirements
    requirements_file_path = os.path.join(curr_dir, "", "requirements.txt")
    ret_code = process_command(
        f"python -m pip uninstall -r {requirements_file_path} -y"
    )
    if ret_code != 0:
        return "Error: Couldn't uninstall the requirements"
    print("Requirements uninstalled")

    return "Success: Requirements uninstalled"
# ---------------------- END OF UNINSTALL REQUIREMENTS ---------------------- #

# Set up the logger
# logger = logging.getLogger(__name__)
# logger.setLevel(logging.INFO)
logger = logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

if __name__ == '__main__':
    nef_url = "http://10.10.10.20:8888"
    iterateForAUE(nef_url, "8", "33")

