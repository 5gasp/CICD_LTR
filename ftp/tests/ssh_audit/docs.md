# Openstack Port Security Test

## 1. Test Goals

This test aims to perform a security assessment of SSH servers in VNFs. It checks the configuration of the SSH server and provides a report of potential security issues and vulnerabilities.

## 2. Test Description

This test only requires the VNF's host and port where the SSH Server is located. Based on that, the SSH Audit Test verifies any there present any vulnerabilities, being those separated in warnings and fails. If there is any fail or warning, the SSH Audit test will fail,  given that 5GASP's security considerations were not taken into account by the Network Application Developer. Furthermore it indicates what were the vulnerabilities found.

## 3. Inputs

The Ssh Port Security Test takes as an input the host and port where the SSH Server is located

## 4. Outputs

### 4.1. Example - Test Failed

``` 
→ python3 -m robot testSshAudit.robot
==============================================================================
testSshAudit                                                                  
==============================================================================
Performing ssh audit                                                  | FAIL |
The audit has failed {'(kex) ecdh-sha2-nistp256': '[fail] using weak elliptic curves', '(kex) ecdh-sha2-nistp384': '[fail] using weak elliptic curves', '(kex) ecdh-sha2-nistp521': '[fail] using weak elliptic curves', '(key) ssh-rsa (3072-bit)': '[fail] using weak hashing algorithm', '(key) ecdsa-sha2-nistp256 ': '[fail] using weak elliptic curves'}
------------------------------------------------------------------------------
testSshAudit                                                          | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/report.html
```

### 4.2. Example - Test Succeeded

``` 
→ python3 -m robot testSshAudit.robot
==============================================================================
testSshAudit                                                                  
==============================================================================
Performing ssh audit                                                  | PASS |
Success
------------------------------------------------------------------------------
testSshAudit                                                          | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh-audit/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
ssh-audit==2.5.0
```
