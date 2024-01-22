import requests
import time
import subprocess

def getAuthBearer(username: str, password: str) -> str:
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
    response = requests.post(
        "http://10.10.10.20:8888/api/v1/login/access-token", headers=headers, data=data
    )

    if response.status_code == 200:
        # Do something with the response data
        data = response.json()
        print(data)
        return data["access_token"]
    else:
        # Handle the error
        # print("Request failed with status code:", response.status_code, response.content)
        return None

def createGet(bearer, supi):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer "+bearer
    }

    response = requests.get(
        "http://10.10.10.20:8888/api/v1/UEs/" + supi + "/serving_cell"
        , headers=headers
    )
    if response.status_code == 200:
        # Do something with the response data
        data = response.json()
#        print(data)
        return data
    else:
        # Handle the error
        # print("Request failed with status code:", response.status_code, response.content)
        return None


def createNEFQoSSubscription(bearer):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer "+bearer
    }
    data = {
        "ipv4Addr": "10.0.0.3",
        "notificationDestination": "http://10.10.10.20:5000/",
        "snssai": {"sst": 1, "sd": "000001" },
        "dnn": "province1.mnc01.mcc202.gprs",
        "qosReference": 9,
        "altQoSReferences": [0],
        "usageThreshold": {
            "duration": 0,
            "totalVolume": 0,
            "downlinkVolume": 0,
            "uplinkVolume": 0
        },
        "qosMonInfo": {
            "reqQosMonParams": [
                "DOWNLINK"
            ],
            "repFreqs": [
                "EVENT_TRIGGERED"
            ],
            "latThreshDl": 0,
            "latThreshUl": 0,
            "latThreshRp": 0,
            "waitTime": 0,
            "repPeriod": 0
        }
    }
    response = requests.post(
        "http://10.10.10.20:8888/nef/api/v1/3gpp-as-session-with-qos/v1/myNetapp/subscriptions"
        , headers=headers
        , json=data
    )

    if response.status_code == 200:
        # Do something with the response data
        data = response.json()
        print(data)
    else:
        # Handle the error
        # print("Request failed with status code:", response.status_code, response.content)
        return None

def createNEFMonitoringSubscription(bearer):
    headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer "+bearer
    }
    data = {
        "externalId": "10001@domain.com",
        "notificationDestination": "http://10.10.10.20:5000/",
        "monitoringType": "LOCATION_REPORTING",
        "maximumNumberOfReports": 10000,
        "monitorExpireTime": "2025-02-12T09:06:50.811Z",
        "maximumDetectionTime": 1,
        "reachabilityType": "DATA"
    }

    response = requests.post(
        "http://10.10.10.20:8888/nef/api/v1/3gpp-monitoring-event/v1/myNetapp/subscriptions"
        , headers=headers
        , json=data
    )

    if response.status_code == 200:
        # Do something with the response data
        data = response.json()
        print(data)
    else:
        # Handle the error
        # print("Request failed with status code:", response.status_code, response.content)
        return None


bearer=getAuthBearer("admin@my-email.com", "pass")
print("Got bearer "+bearer )
# if bearer is not None:
#     # createNEFSubscription(bearer)
#     # createNEFMonitoringSubscription(bearer)
#     supi="202010000000001"
#     throttling=0
#     subprocess.call(["/home/localadmin/limit_tc_stop.sh"])
#     while True:
#         data=createGet(bearer, supi)
#         if data is not None and data["S-PCI"] is not None and data["S-PCI"]==3:
#             print("In cell 3")
#             if throttling!=1:
#                 subprocess.call(["/home/localadmin/limit_tc_start.sh"])
#                 throttling=1
#                 print("Throttling started")
#         else:
#             print("out in cell 3")
#             if throttling==1:
#                 subprocess.call(["/home/localadmin/limit_tc_stop.sh"])
#                 print("Throttling stopped")
#                 throttling=0
#         time.sleep(1)

if bearer is not None:
    # createNEFSubscription(bearer)
    # createNEFMonitoringSubscription(bearer)
    # data=createGet(bearer)
    throttling=0
    packet_error_rate=0
    packet_loss=0
    packet_corruption_rate=0
    communication_loss = 0
    # data = createGet(bearer)
    subprocess.call(["sudo","/home/localadmin/limit_tc_stop.sh"])
    subprocess.call(["sudo","/home/localadmin/packet_error_rate_stop.sh"])
    subprocess.call(["sudo","/home/localadmin/packet_loss_stop.sh"])
    subprocess.call(["sudo","/home/localadmin/packet_corruption_stop.sh"])
    subprocess.call(["sudo","/home/localadmin/communication_loss_stop.sh"])
    while True:
        supi = "202010000000004"
        data=createGet(bearer, supi)
        if data is not None and data["S-PCI"] is not None and data["S-PCI"]==8:
            print("UE with supi " + str(supi) + " in cell " + str(data["S-PCI"]))
            if throttling!=1:
                subprocess.call(["sudo","/home/localadmin/limit_tc_start.sh"])
                throttling=1
                print("Throttling started")
        else:
            if throttling==1:
                subprocess.call(["sudo","/home/localadmin/limit_tc_stop.sh"])
                throttling=0
                print("Throttling stopped")
        time.sleep(0.2)

        supi = "202010000000005"
        data=createGet(bearer, supi)
        if data is not None and data["S-PCI"] is not None and data["S-PCI"]==8:
            print("UE with supi " + str(supi) + " in cell " + str(data["S-PCI"]))
            if packet_error_rate!=1:
                subprocess.call(["sudo","/home/localadmin/packet_error_rate_start.sh","5"])
                packet_error_rate=1
                print("Packet error rate 5% started")
        else:
            if packet_error_rate==1:
                subprocess.call(["sudo","/home/localadmin/packet_error_rate_stop.sh"])
                packet_error_rate=0
                print("Packet error rate 5% stopped")
        time.sleep(0.2)

        supi = "202010000000006"
        data=createGet(bearer, supi)
        if data is not None and data["S-PCI"] is not None and data["S-PCI"]==8:
            print("UE with supi " + str(supi) + " in cell " + str(data["S-PCI"]))
            if packet_loss!=1:
                subprocess.call(["sudo","/home/localadmin/packet_loss_start.sh","5"])
                packet_loss=1
                print("Packet loss 5% started")
        else:
            if packet_loss==1:
                subprocess.call(["sudo","/home/localadmin/packet_loss_stop.sh"])
                packet_loss=0
                print("Packet loss 5% stopped")
        time.sleep(0.2)

        supi = "202010000000007"
        data=createGet(bearer, supi)
        if data is not None and data["S-PCI"] is not None and data["S-PCI"]==8:
            print("UE with supi " + str(supi) + " in cell " + str(data["S-PCI"]))
            if packet_corruption_rate!=1:
                subprocess.call(["sudo","/home/localadmin/packet_corruption_start.sh","5"])
                packet_corruption_rate=1
                print("Packet corruption 5% started")
        else:
            if packet_corruption_rate==1:
                subprocess.call(["sudo","/home/localadmin/packet_corruption_stop.sh"])
                packet_corruption_rate=0
                print("Packet corruption 5% stopped")
        time.sleep(0.2)

        supi = "202010000000008"
        data=createGet(bearer, supi)
        if data is not None and data["S-PCI"] is not None and data["S-PCI"]==8:
            print("UE with supi " + str(supi) + " in cell " + str(data["S-PCI"]))
            if communication_loss!=1:
                subprocess.call(["sudo","/home/localadmin/communication_loss_start.sh"])
                communication_loss=1
                print("Communication loss started")
                time.sleep(16)
                print("UE with supi " + supi + " out of cell " + str(data["S-PCI"]))
                subprocess.call(["sudo","/home/localadmin/communication_loss_stop.sh"])
                communication_loss=0
                print("Communication loss stopped")
        time.sleep(0.2)