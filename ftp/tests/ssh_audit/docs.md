# SSH Audit

## 1. Test Goals

This test aims to perform a security assessment of SSH servers in VNFs. It checks the configuration of the SSH server and provides a report of potential security issues and vulnerabilities.

## 2. Test Description

This test only requires the VNF's host and port where the SSH Server is located. Based on that, the SSH Audit Test verifies any there present any vulnerabilities, being those separated in warnings and fails. If there is any fail or warning, the SSH Audit test will fail,  given that 5GASP's security considerations were not taken into account by the Network Application Developer. Furthermore it indicates what were the vulnerabilities found.

## 3. Inputs

The Ssh Port Security Test takes as an input the host and, optionally, the port where the SSH Server is located.
If no SSH Port is specified, the default 22 SSH Port is used.

Environment Variables that must be specified:
- ssh_audit_ssh_host
- ssh_audit_ssh_port (optional)

## 4. Outputs

### 4.1. Example - Test Failed

``` 
→ python3 -m robot testSshAudit.robot
==============================================================================
testSshAudit
==============================================================================
Performing ssh audit                                                  | FAIL |
The audit has failed:
SSH's Algorithms/Keys Validation Report:
[fail] using weak elliptic curves -> (kex) ecdh-sha2-nistp256
[fail] using weak elliptic curves -> (kex) ecdh-sha2-nistp384
[fail] using weak elliptic curves -> (kex) ecdh-sha2-nistp521
[fail] using weak hashing algorithm -> (key) ssh-rsa (3072-bit)
[fail] using weak elliptic curves -> (key) ecdsa-sha2-nistp256
If you wish to SOLVE THE ENCOUNTERED ISSUES, please visit: https://www.ssh-audit.com/hardening_guides.html
------------------------------------------------------------------------------
testSshAudit                                                          | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/report.html
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
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_audit/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
ssh-audit==2.5.0
```
