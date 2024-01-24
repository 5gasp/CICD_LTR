# NEF QoS Subscription Test

## 1. Test Goals

## 2. Test Description

This test will validate that a Network Application is able to subscribe and eventually retrieve information about a QoS compromised event.

## 3. Inputs

Environment Variables that must be specified:
- `nef_qos_subscription_test_reporting_api_ip`
- `nef_qos_subscription_test_reporting_api_port`
- `nef_qos_subscription_test_mini_api_endpoint_to_invoke`
- `nef_qos_subscription_test_monitoring_payload`

Example:
- `export nef_qos_subscription_test_reporting_api_ip=10.255.28.173`
- `export nef_qos_subscription_test_reporting_api_port=3000`
- `export nef_qos_subscription_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G7`
- `export nef_qos_subscription_test_monitoring_payload='{"ipv4Addr":"10.0.0.1","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}'`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Qos Subscription Test
==============================================================================
Nef Qos Subscription Test.Nef Qos Subscription Test
==============================================================================
NEF's QoS Subscription Test                                           ....
MiniAPI endpoint to invoke: http://10.255.28.206:8000/start/Def115G7
.Reporting API IP: 10.255.28.173
.Reporting API Port: 3000
.Monitoring Payload: {"ipv4Addr":"10.0.0.1","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}

NEF's QoS Subscription Test                                           ..
Test Output: (0, 'Test Successful! NApp was able to subscribe a QoS compromised event in the  NEF')

NEF's QoS Subscription Test                                           | PASS |
Test Successful! NApp was able to subscribe a QoS compromised event in the  NEF
------------------------------------------------------------------------------
Nef Qos Subscription Test.Nef Qos Subscription Test                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Qos Subscription Test                                             | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Qos Subscription Test
==============================================================================
Nef Qos Subscription Test.Nef Qos Subscription Test
==============================================================================
NEF's QoS Subscription Test                                           ....
MiniAPI endpoint to invoke: http://10.255.28.206:8000/start/Def115G7
.Reporting API IP: 10.255.28.173
.Reporting API Port: 3001
.Monitoring Payload: {"ipv4Addr":"10.0.0.1","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}

NEF's QoS Subscription Test                                           ..
Test Output: (2, '"QoS Subscription Done"')

NEF's QoS Subscription Test                                           | FAIL |
"QoS Subscription Done"
------------------------------------------------------------------------------
Nef Qos Subscription Test.Nef Qos Subscription Test                   | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Qos Subscription Test                                             | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_qos_subscription_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```