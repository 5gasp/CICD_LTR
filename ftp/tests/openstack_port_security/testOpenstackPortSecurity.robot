*** Settings ***
Library        OpenstackPortSecurity.py
Test Timeout  15 minutes

*** Test Cases ***
Testing the port security of VNF interfaces
    ${openstack_port_security_status}=    Test Openstack Port Security    %{openstack_port_security_deployment_info_file_path=NONE}

    IF  '${openstack_port_security_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${openstack_port_security_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${openstack_port_security_status[1]}
    ELSE
        Fail  \nUnknown Error
    END