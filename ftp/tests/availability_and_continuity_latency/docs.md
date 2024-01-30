# Availability and continuity latency

## 1. Test Goals

This test is designed to assess the availability and continuity of a service when latency is changed.

## 2. Test Description

Validate by changing the latency of the NIC through tc rules.

## 3. Inputs

Environment Variables that must be specified:
- `availability_and_continuity_latency_NEFURL`

Example:
- 'export availability_and_continuity_latency_NEFURL=http://10.10.10.20:8888'

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Availability And Continuity Latency                                           
==============================================================================
Testing for UE5                                                       | PASS |
------------------------------------------------------------------------------
Uninstalling requirements                                             | PASS |
------------------------------------------------------------------------------
Availability And Continuity Latency                                   | PASS |
2 tests, 2 passed, 0 failed
==============================================================================
Output:  D:\Users\yiann\PycharmProjects\moveUETest\availability_and_continuity_latency\output.xml
Log:     D:\Users\yiann\PycharmProjects\moveUETest\availability_and_continuity_latency\log.html
Report:  D:\Users\yiann\PycharmProjects\moveUETest\availability_and_continuity_latency\report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
certifi==2023.11.17
charset-normalizer==3.3.2
dnspython==2.3.0
idna==3.6
requests==2.31.0
urllib3==2.0.7
```