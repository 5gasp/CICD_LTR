# Availability and continuity packet loss

## 1. Test Goals

This test is designed to assess the availability and continuity of a service when packet loss is changed.

## 2. Test Description

Validate by changing the packet loss of the NIC through tc rules.

## 3. Inputs

Environment Variables that must be specified:
- `availability_and_continuity_packet_loss_NEFURL`

Example:
- 'export availability_and_continuity_packet_loss_NEFURL=http://10.10.10.20:8888'

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Availability And Continuity Packet Loss                                       
==============================================================================
Testing for UE6                                                       | PASS |
------------------------------------------------------------------------------
Uninstalling requirements                                             | PASS |
------------------------------------------------------------------------------
Availability And Continuity Packet Loss                               | PASS |
2 tests, 2 passed, 0 failed
==============================================================================
Output:  .\availability_and_continuity_packet_loss\output.xml
Log:     .\availability_and_continuity_packet_loss\log.html
Report:  .\availability_and_continuity_packet_loss\report.html
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