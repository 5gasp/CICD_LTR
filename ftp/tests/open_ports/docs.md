# Open Ports

## 1. Test Goals

This test is designed to identify and evaluate open ports in a Network Application (VM). For this, it uses the Nmap network scanner tool. The primary goal is to ensure the security and integrity of the network by detecting open ports that could potentially be vulnerabilities or entry points for unauthorized access. By systematically scanning and analyzing the network's open ports, this suite plays a critical role in maintaining robust network security. It helps in confirming that only necessary and secure ports are open, and all others are properly closed or shielded, thereby reducing the risk of external attacks and safeguarding sensitive data and services.

## 2. Test Description

Validate if the Network Application’s open ports are the ones required for the normal operation of the Network Application (only applied to Virtual Machines (VMs)) 

## 3. Inputs

Environment Variables that must be specified:
- `open_ports_host`
- `open_ports_expected_open_ports`

Example:
- `export open_ports_host=10.255.28.206`
- `export open_ports_expected_open_ports=22/tcp`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ python3 -m robot .
==============================================================================
Open Ports
==============================================================================
Open Ports.testOpenPorts
==============================================================================
Testing the open ports                                                | PASS |
Success
------------------------------------------------------------------------------
Open Ports.testOpenPorts                                              | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Open Ports                                                            | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/report.html
```

### 4.2. Example - Test Failed

```
➜ python3 -m robot .
==============================================================================
Open Ports
==============================================================================
Open Ports.testOpenPorts
==============================================================================
Testing the open ports                                                | FAIL |
The open ports are not the ones expected
------------------------------------------------------------------------------
Open Ports.testOpenPorts                                              | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Open Ports                                                            | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/open_ports/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, `nmap` must be installed on the CI/CD Agent.
`sudo apt-get install nmap`

### 5.2. Python Requirements

```
robotframework==6.0.2
python3-nmap==1.6.0
```
