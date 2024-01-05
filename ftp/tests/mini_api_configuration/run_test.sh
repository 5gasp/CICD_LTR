#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2024-01-05 19:47:09

export mini_api_configuration_api_ip=10.255.28.206
export mini_api_configuration_api_port=8000
export mini_api_configuration_configuration_payload='{"variables":{"NEF_IP":"10.255.28.173","NEF_PORT":8888,"NEF_LOGIN_USERNAME":"admin@my-email.com","NEF_LOGIN_PASSWORD":"pass","SUBS1_MONITORING_TYPE":"LOCATION_REPORTING","SUBS1_CALLBACK_URL":"http://127.0.0.1/callback","SUBS1_MONITORING_EXPIRE_TIME":"2024-03-09T13:18:19.495000+00:00","UE1_NAME":"My UE","UE1_DESCRIPTION":"My UE Description","UE1_IPV4":"10.10.10.10","UE1_IPV6":"0:0:0:0:0:0:0:0","UE1_MAC_ADDRESS":"22-00-00-00-00-02","UE1_SUPI":"202010000000001"}}'
python3 -m robot .

# mini_api_configuration_configuration_payload
#{"variables": {
#    "NEF_IP" : "127.0.0.1",
#    "NEF_PORT" : 8888,
#    "NEF_LOGIN_USERNAME": "admin@my-email.com",
#    "NEF_LOGIN_PASSWORD": "pass",
#    "SUBS1_MONITORING_TYPE": "LOCATION_REPORTING",
#    "SUBS1_CALLBACK_URL": "http://127.0.0.1/callback",
#    "SUBS1_MONITORING_EXPIRE_TIME": "2024-03-09T13:18:19.495000+00:00",
#    "UE1_NAME": "My UE",
#    "UE1_DESCRIPTION": "My UE's Description",
#    "UE1_IPV4": "10.10.10.10",
#    "UE1_IPV6": "0:0:0:0:0:0:0:0",
#    "UE1_MAC_ADDRESS":  "22-00-00-00-00-02",
#    "UE1_SUPI":  "202010000000001"
#}}
