# Openstack Port Security Test

## 1. Test Goals

This test serves to ensure all VNFs deployed in Openstack have port security enabled.
If a VNF's interfaces dotn't have port security enabled, all incoming traffic will be allowed. Thus, the VNF is fully exposed to attacks. With port security enabled, the developer may manage which traffic should be allowed to enter the VNF.

## 2. Test Description

This test requires a json file containing information on all VNFs/NSs deployed in Openstack. Based on such information, the Openstack Port Security Test verifies if there is any interface without port security enabled. If this is the case, the Openstack Port Security Test FAILS, given that 5GASP's security considerations were not taken into account by the Network Application Developer. Furthermore, the Openstack Port Security Test indicates which interfaces were not configured with port security enabled, so as the developer may fix this issue.

## 3. Inputs

The Openstack Port Security Test takes as an input the location of the Json file containing the VNFs/NSs deployment information.

## 4. Outputs

### 4.1. Example - Test Failed

``` 
→ python3 -m robot testOpenstackPortSecurity.robot
==============================================================================
testOpenstackPortSecurity                                                     
==============================================================================
Testing the open ports                                                | FAIL |
NOT all ports have port security enabled! Ports: [{'vnf_instance_id': '2869a444-6ef5-444d-90a2-0593ee091d18', 'interface_id': '43a5c2f1-f7a4-4aa8-84ff-a62bff41d048', 'port_ip': '10.0.30.106', 'port_security': 'false'}, {'vnf_instance_id': '44f1518d-4cac-4bd0-a684-9824151a53fb', 'interface_id': '2dcaf21a-3207-4382-96f1-650dfa5240c0', 'port_ip': '10.0.30.123', 'port_security': 'false'}]
------------------------------------------------------------------------------
testOpenstackPortSecurity                                             | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/report.html
```

### 4.2. Example - Test Succeeded

``` 
→ python3 -m robot testOpenstackPortSecurity.robot
==============================================================================
testOpenstackPortSecurity                                                     
==============================================================================
Testing the port security of VNF interfaces                           | PASS |
Success
------------------------------------------------------------------------------
testOpenstackPortSecurity                                             | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/output.xml
Log:     /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/log.html
Report:  /Users/rdireito/Desktop/UA/5GASP/Code/CICD_LTR/ftp/tests/openstack_port_security/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
```

