# SSh Bruteforce

## 1. Test Goals

This test aims to do a bruteforce in SSH Server provided by the VNFs, validating the presence of weak password

## 2. Test Description

This test requires the client to indicate which the host to be target, as well as username and a file containing passwords to be tested against the SSH Server. The test will try to use the different combinations between the user and passwords present on the file, checking for validate combinations. If no combinations are found or a timeout has occured the test will pass. Otherwise, the test will fail and the valid combinations will be showcased to the client.

## 3. Inputs

The SSH Brutefoce Test takes as an input the host that points to SSH Server. Besides this, it takes as input the username to be the tested and a the path to a file containing passwords

Environment Variables that must be specified:
- ssh_bruteforce_user
- ssh_bruteforce_passfile
- ssh_bruteforce_host

Example:
- `export ssh_bruteforce_user=ubuntu`
- `export ssh_bruteforce_passfile=passwords.txt`
- `export ssh_bruteforce_passfile=passwords_2.txt`
- `export ssh_bruteforce_host=10.0.30.108`


## 4. Outputs

### 4.1. Example - Test Failed  Due to an Existent Combination

``` 
→ python -m robot test_ssh_bruteforce.robot 
==============================================================================
Test Ssh Bruteforce                                                           
==============================================================================
Performing ssh bruteforce                                             | FAIL |
Error. Matches were found:
	-> [22][ssh] host: 10.0.30.108   login: ubuntu   password: password
------------------------------------------------------------------------------
Test Ssh Bruteforce                                                   | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/report.html
```

### 4.2. Example - Test Failed Due to Incorrect Input

``` 
→ python -m robot test_ssh_bruteforce.robot 
==============================================================================
Test Ssh Bruteforce                                                           
==============================================================================
Performing ssh bruteforce                                             | FAIL |
An error occured. Exception 
	-> [ERROR] File for passwords not found: password_2.txt
------------------------------------------------------------------------------
Test Ssh Bruteforce                                                   | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/report.html
```


### 4.3. Example - Test Succeeded

``` 
→ python -m robot test_ssl_audit.robot 
==============================================================================
Test Ssh Bruteforce                                                           
==============================================================================
Performing ssh bruteforce                                             | PASS |
No valid password were found: 1 of 1 target completed, 0 valid password found
------------------------------------------------------------------------------
Test Ssh Bruteforce                                                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/report.html
```

### 4.4. Example - Test Succeeded due to a timeout of execution

``` 
→ python -m robot test_ssh_bruteforce.robot
==============================================================================
Test Ssh Bruteforce                                                           
==============================================================================
Performing ssh bruteforce                                             | PASS |
There was a timeout running the test
------------------------------------------------------------------------------
Test Ssh Bruteforce                                                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/output.xml
Log:     /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/log.html
Report:  /Users/dagomes/IT/5gasp/CICD_LTR/ftp/tests/ssh_bruteforce/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

```
hydra
```

### 5.2. Python Requirements

```
robotframework==6.0.2
```
