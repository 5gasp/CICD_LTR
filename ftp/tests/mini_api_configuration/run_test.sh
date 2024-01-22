#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 14:49:12

export mini_api_configuration_api_ip=10.255.28.230
export mini_api_configuration_api_port=3001
export mini_api_configuration_configuration_payload='{"variables":{"NEF_IP":"10.255.28.236","NEF_PORT":8888,"NEF_LOGIN_USERNAME":"admin@my-email.com","NEF_LOGIN_PASSWORD":"pass","SUBS_MONITORING_TYPE":"LOCATION_REPORTING", "SUBS_EXTERNAL_ID": "123456789@domain.com", "SUBS_CALLBACK_URL":"https://webhook.site/43d72330-0f8e-4a52-af1c-65c77d9aafd0","SUBS_MONITORING_EXPIRE_TIME":"2024-03-09T13:18:19.495000+00:00","UE1_NAME":"My UE","UE1_DESCRIPTION":"My UE Description","UE1_IPV4":"10.10.10.10","UE1_IPV6":"0:0:0:0:0:0:0:0","UE1_MAC_ADDRESS":"22-00-00-00-00-02","UE1_SUPI":"202010000000001"}}'

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
