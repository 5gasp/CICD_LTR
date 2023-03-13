# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-13 15:34:19
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-13 17:10:10

# Return Codes:
# 0 - Success (PASS)
# 1 - Test Failed due to errors in the authentication process
# 2 - Test Failed due to an exception


import requests
import json

# Constants

ENDPOINTS = {
    "NEF_EMULATOR_REPORTING": {
        "CREATE_REPORT": "/report?filename=test.json",
        "DELETE_REPORT": "/report?filename=test.json",
        "GET_REPORT": "/report?filename=test.json",
    },
    "VNF_USING_NEF": {
        "ESTABLISH_CONNECTION_NEF": "/establish_connection_nef",
        "LOGIN_NEF": "/login",
        "MAKE_SUBSCRIPTION": "/make_subscription"
    }
}


def validate_report(report):
    errors = []

    for request in report["requests"]:
        if request["details"]["endpoint"] == "/api/v1/login/access-token":
            if request["response"]["code"] != 200:
                errors.append("Invalid Login")
        # Other validations...
        # here
    return errors


def test_nef_authentication(vnf_base_api_location,
                            nef_reporting_base_api_location,
                            nef_ip, nef_port, nef_username, nef_password):

    try:
        # 1. Start by deleting previous reports, if there is any
        url = f"{nef_reporting_base_api_location}"\
            f"{ENDPOINTS['NEF_EMULATOR_REPORTING']['DELETE_REPORT']}"
        response = requests.request("DELETE", url)

        print("NEF's Reporting API Response to Report Deletion: " +
              f" {response.text}")
        if response.status_code != 200:
            print("Impossible to delete previous reports from NEF's " +
                  "Reporting API")
            return 2, "Impossible to delete previous reports from NEF's "\
                "Reporting API"

        # 2. Then, create a new report
        url = f"{nef_reporting_base_api_location}"\
            f"{ENDPOINTS['NEF_EMULATOR_REPORTING']['CREATE_REPORT']}"
        response = requests.request("POST", url)

        print("NEF's Reporting API Response to Report Creation: " +
              f"{response.text}")
        if response.status_code != 200:
            print("Impossible to create new report on NEF's Reporting API")
            raise Exception("Impossible to create new report on NEF's " +
                            "Reporting API")

        # 3. Establish connectivity between the VNF Under Test and the NEF
        # Emulator
        url = f"{vnf_base_api_location}"\
            f"{ENDPOINTS['VNF_USING_NEF']['ESTABLISH_CONNECTION_NEF']}"

        payload = json.dumps({
            "nef_ip": nef_ip,
            "nef_port": str(nef_port)
        })
        headers = {'Content-Type': 'application/json'}

        response = requests.request("POST", url, headers=headers, data=payload)

        print("VNF's Response to the request of establishing connectivity " +
              f"with the NEF: {response.text}")
        if response.status_code != 200:
            print("Impossible to establish connectivity between the VNF " +
                  "under test and the NEF")
            raise Exception(
                "Impossible to establish connectivity between the VNF " +
                "under test and the NEF"
            )

        # 4. VNF Under test logs in NEF
        url = f"{vnf_base_api_location}"\
            f"{ENDPOINTS['VNF_USING_NEF']['LOGIN_NEF']}"

        payload = json.dumps({
            "username": nef_username,
            "password": nef_password
        })
        headers = {'Content-Type': 'application/json'}

        response = requests.request("POST", url, headers=headers, data=payload)

        print("VNF's Response to the request of authenticating itself in " +
              f"the NEF: {response.text}")
        if response.status_code != 200 and response.status_code != 201:
            print("Impossible for the VNF under test to loggin in to the NEF")
            raise Exception(
                "Impossible for the VNF under test to loggin in to the NEF"
            )

        # 5. Get NEF's Report
        url = f"{nef_reporting_base_api_location}"\
            f"{ENDPOINTS['NEF_EMULATOR_REPORTING']['GET_REPORT']}"

        response = requests.request("GET", url)

        print("NEF's Obtained Report: ")
        report_json = json.loads(response.text)
        print(json.dumps(report_json, indent=4))

        if response.status_code != 200 and response.status_code != 201:
            print("Impossible to obtain NEF's report")
            raise Exception("Impossible to obtain NEF's report")

        # 6. Validate Report
        errors = validate_report(report_json)

        if len(errors) != 0:
            errors_str = '\n\t- '.join(errors)
            print(f"Test Failed due to the following errors: {errors_str}")
            return 1, f"Test Failed due to the following errors: {errors_str}"

        print("Test Successfull! NetApp was able to authenticate with the NEF")
        return 0, "Test Successfull! NetApp was able to authenticate with "\
            "the NEF"
    except Exception as e:
        return 2, f"Test failed due to an exception. Exception: {e}"


if __name__ == "__main__":
    test_nef_authentication(
        vnf_base_api_location="http://10.0.30.166:8080",
        nef_reporting_base_api_location="http://10.0.30.122:8000",
        nef_ip="10.0.30.122",
        nef_port="8888",
        nef_username="admin@my-email.com",
        nef_password="pass"
    )
