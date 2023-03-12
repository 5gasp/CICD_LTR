# SSH Brute Force Test

## 1. Test Goals

This test serves to ensure all SSH credentials used in VNFs are not in the collection of the most common credentials for VMs

## 2. Test Description

This test requires allows for the client to point out the username of his/her VNF and test a collection of the most common passwords to verify if his/her VNF is relying on insecure credentials that can easily be discovered. Furthermore, the client may opt to not provide the username of his/her VNF. In this case, a list of the most common usernames will be used. The client will always have to provide the number of passwords that must be tested. Moreover, in the case the client opts not to provide the username of his/her VNF, it will have to also provide the number of usernames that shall be tested. As for the lists of most common usernames and password, these are already onboarded in the CI/CD Agents, and thus our clients won't have to provide them.

The most common passwords file is located at `/var/lib/jenkins/test_artifacts/"$JOB_NAME/most-common-usernames.txt`
The most common usernames file is located at `/var/lib/jenkins/test_artifacts/"$JOB_NAME/most-common-usernames.txt`

Due to resource restrictions, only 1500 credentials can be be tested

## 3. Inputs

The Openstack Port Security Test takes as an input:
- The username of the VNF (optional) - Env: `ssh_brute_force_username`
- The maximum number of usernames to be tested (when the VNF's username is not provided - mandatory) - Env: `ssh_brute_force_max_usernames_to_test`
- The maximum number of passwords to be tested (mandatory) - Env: `ssh_brute_force_max_password_to_test`
- The IP of the targe VNF (mandatory) - Env: `ssh_brute_force_target_ip`
- The Port of the targe VNF where the SSH Server is Running (optional, defautl=22) - Env: `ssh_brute_force_target_port`

### 3.1 When testing locally...

When testing locally, the clients won't have access to the files with the most common usernames and passsword. Thus, this test comprises an `example_artifacts` folder with such files. To use these password/username collections, you must export the following environment variables:

- `usernames_list_file_path`
- `passwords_list_file_path`


Example:
``` bash
export usernames_list_file_path=example_artifacts/top-usernames-shortlist.txt
export passwords_list_file_path=example_artifacts/1000-most-common-passwords.txt 
```

## 4. Outputs

### 4.1. Example - Test was Successull and the client provided the username of the VNF

Envs:
``` bash
ssh_brute_force_username=ubuntu
ssh_brute_force_max_password_to_test=1000
ssh_brute_force_target_ip=10.10.10.148
```

``` 
→ python -m robot ./                             
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | PASS |
Test Successfull. No credentials were discovered!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Ssh Brute Force                                                       | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```

### 4.2. Example - Test Succeeded but no username was provided by the client

Envs:
``` bash
ssh_brute_force_max_password_to_test=100
ssh_brute_force_max_usernames_to_test=10
ssh_brute_force_target_ip=10.0.30.148
```

``` 
→ python -m robot ./                             
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | PASS |
Test Successfull. No credentials were discovered!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Ssh Brute Force                                                       | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```

### 4.3. Example - Test Failed - Credentials were discovered

``` 
→ python -m robot ./                             
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | FAIL |
Credentials were discovered!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Ssh Brute Force                                                       | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```

### 4.4. Example - Test Failed - SSH Connection is not stable

This may happen due to network issues or when the IP address of the VNF was incorrectly provided.

``` 
→ python -m robot ./                             
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | FAIL |
Impossible to perform the SSH Bruteforce test. Exception: SSH Server's connection is not stable.!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Ssh Brute Force                                                       | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```

### 4.5. Example - Test Failed - Impossible to gather the usernames to use in this test.

This may happen due to the most common usernames file not being present in the CI/CD Agent

```
→ python -m robot ./                                                            
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | FAIL |
Impossible to gather the usernames to use in this test. Exception [Errno 2] No such file or directory: 'xyz/top-usernames-shortlist.txt'!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Ssh Brute Force                                                       | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```


### 4.5. Example - Test Failed - Impossible to gather the passwords to use in this test.

This may happen due to the most common passwords file not being present in the CI/CD Agent

```
→ python -m robot ./                                                                
==============================================================================
Ssh Brute Force                                                               
==============================================================================
Ssh Brute Force.testSSHBruteforce                                             
==============================================================================
Brute force SSH Credentials Test                                      | FAIL |
Impossible to gather the password to use in this test. Exception [Errno 2] No such file or directory: 'xyz/1000-most-common-passwords.txt'!
------------------------------------------------------------------------------
Ssh Brute Force.testSSHBruteforce                                     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Ssh Brute Force                                                       | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/ssh_brute_force/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
paramiko==3.1.0
```

