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
import logging
import time

def getAuthBearer(username: str, password: str, nef_url: str) -> str:
    print("Nef url still at "+nef_url)
    headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    data = {
        "grant_type": "",
        "username": username,
        "password": password,
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


def iterateForAUE(nef_url: str, nef_username: str, nef_password: str, ue: str, timeforacircle: str, liveness_url: str)-> str :
    try:
        bearer = getAuthBearer(nef_username, nef_password, nef_url)
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
        bearer = getAuthBearer(nef_username, nef_password, nef_url)
        if bearer is not None:
            startMovingUE(bearer, nef_url, "20201000000000" + ue)
            time.sleep(int(timeforacircle) * 2)
            stopMovingUE(bearer, nef_url, "20201000000000" + ue)
            if check_liveness(liveness_url):
                return "Success"
            else:
                return -1
    except ConnectionError:
        logging.error("Connection with NEF failed!")
    except:
        logging.error("Communication with NEF failed!")
    return -1

def check_liveness(url):
    try:
        response = requests.get(url)
        # A status code of 200 means OK, which indicates the page is live.
        if response.status_code == 200:
            print(f"The page at {url} is live. Status Code: {response.status_code}")
            return True
        else:
            print(f"The page at {url} encountered an issue. Status Code: {response.status_code}")
            return False
    except requests.ConnectionError:
        print(f"Failed to connect to {url}")
        return False
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
    nef_username = "admin@my-email.com"
    nef_password = "pass"
    iterateForAUE(nef_url, nef_username, nef_password, "4", "36")

