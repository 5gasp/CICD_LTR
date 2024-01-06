#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2023-12-31 17:02:22
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2024-01-05 19:49:20

export nef_qos_subscription_test_reporting_api_ip=10.255.28.173
export nef_qos_subscription_test_reporting_api_port=3000
export nef_qos_subscription_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/def1145G7
export nef_qos_subscription_test_monitoring_payload='{"ipv4Addr":"10.0.0.0","ipv6Addr":"0:0:0:0:0:0:0:0","macAddr":"22-00-00-00-00-00","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}'
python3 -m robot .

#nef_qos_subscription_test_monitoring_payload:
#"
#{
#  "ipv4Addr": "10.0.0.0",
#  "ipv6Addr": "0:0:0:0:0:0:0:0",
#  "macAddr": "22-00-00-00-00-00",
#  "notificationDestination": "http://127.0.0.1/callback",
#  "snssai": {
#    "sst": 1,
#    "sd": "000001"
#  },
#  "dnn": "province1.mnc01.mcc202.gprs",
#  "qosReference": 9,
#  "altQoSReferences": [
#    0
#  ],
#  "usageThreshold": {
#    "duration": 0,
#    "totalVolume": 0,
#    "downlinkVolume": 0,
#    "uplinkVolume": 0
#  },
#  "qosMonInfo": {
#    "reqQosMonParams": [
#      "DOWNLINK"
#    ],
#    "repFreqs": [
#      "EVENT_TRIGGERED"
#    ],
#    "latThreshDl": 0,
#    "latThreshUl": 0,
#    "latThreshRp": 0,
#    "waitTime": 0,
#    "repPeriod": 0
#  }
#}
#"