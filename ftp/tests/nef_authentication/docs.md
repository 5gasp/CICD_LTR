# NEF Authentication Test

## 1. Test Goals

This test serves as to ensure that a VNF is capable of authenticating with the 5G NEF. In this test, a NEF Emulator is used.

## 2. Test Description

The NEF Authentication Test evaluates if a VNF can authenticate with the 5G NEF. To conduct this test, the VNF should provide an "Experimentation" API that enables 5GASP's CI/CD Agent to invoke a new interaction between the NetApp and the NEF (this is the test itself). 

This test assumes that the NetApp makes available an "Experimentation" API with the following endpoints:

- `/establish_connection_nef` - To establish the NEF connection parameters that shall be used while communicating with the 5G NEF
- `/login` - When this endpoind is called, the VNF will try to authenticate in the NEF, using the connection parameters provided via the `/establish_connection_nef` endpoint and using the credentials provided in the `/login` endpoint.
- `/make_subscription` -  When this endpoind is called, the VNF will try to make a subscription to the NEF

Moreover, this test relies on a Reporting API implemented in the NEF Emulator.
To this end, during this test the follwing Reporting API's endpoint are invoked:

- POST `/report?filename=test.json` -  Start a new report and store it in the `test.json` file
- DELETE `/report?filename=test.json` -  Delete the report stored in the `test.json` file
- GET `/report?filename=test.json` - Get the report stored in the `test.json` file

## 2.1 Test Workflow

1. The CI/CD Agent verifies if there are previous NEF Reports. If so, it will delete them
2. The CI/CD Agent triggers the creation of a new NEF Emulator Report, through the Report API
3. The CI/CD Agent passes the NEF connection parameters to the VNF under test
4. The CI/CD Agent invokes the `/login` endpoint on the VNF's Experimentation API, to get it to authenticate with the NEF
5. (Optional) The CI/CD Agent may trigger a new subscription to the NEF, using the `/make_subscription` endpoint of the VNF's Experimentation API
6. The CI/CD Agent collects the NEF's Report and evaluates the results


## 3. Inputs

The NEF Authentication takes as an input:

- The URL of the VNF's NEF Testing API - Env: `nef_authentication_vnf_base_api_location`, defined in the Testing Descriptor as `vnf_base_api_location`
- The URL of the NEF's Reporting API - Env: `nef_authentication_nef_reporting_base_api_location`, defined in the Testing Descriptor as `nef_reporting_base_api_location`
- The NEF's IP - Env: `nef_authentication_nef_ip`, defined in the Testing Descriptor as `nef_ip`
- The NEF's Main API Port - Env: `nef_authentication_nef_port`, defined in the Testing Descriptor as `nef_port`
- The NEF's Main API Login Username - Env: `nef_authentication_nef_username`, defined in the Testing Descriptor as `nef_username`
- The NEF's Main API Login Password - Env: `nef_authentication_nef_password`, defined in the Testing Descriptor as `nef_password`



## 4. Outputs

### 4.1. Example - Test was Successull

``` 
→ python -m robot ./
==============================================================================
Nef Authentication
==============================================================================
Nef Authentication.testNEFAuthentication
==============================================================================
Validate if NetApp is able to authenticate with the NEF               | PASS |
Test Successfull! NetApp was able to authenticate with the NEF
------------------------------------------------------------------------------
Nef Authentication.testNEFAuthentication                              | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Authentication                                                    | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  .../nef_authentication/output.xml
Log:     .../nef_authentication/log.html
Report:  .../nef_authentication/report.html
```

### 4.2. Example - Test Failed Due to Invalid Authentication

``` 
→ python -m robot ./
==============================================================================
Nef Authentication
==============================================================================
Nef Authentication.testNEFAuthentication
==============================================================================
Validate if NetApp is able to authenticate with the NEF               | FAIL |
Test Failed due to the following errors: Invalid Login
------------------------------------------------------------------------------
Nef Authentication.testNEFAuthentication                              | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Authentication                                                    | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  .../nef_authentication/output.xml
Log:     .../nef_authentication/log.html
Report:  .../nef_authentication/report.html
```

### 4.3. Example - Test Failed - Other error

``` 
→ python -m robot ./
==============================================================================
Nef Authentication
==============================================================================
Nef Authentication.testNEFAuthentication
==============================================================================
Validate if NetApp is able to authenticate with the NEF               | FAIL |
Test failed due to an exception. Exception: Impossible for the VNF under test to authenticate in the NEF
------------------------------------------------------------------------------
Nef Authentication.testNEFAuthentication                              | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Authentication                                                    | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  ...s/nef_authentication/output.xml
Log:     ...s/nef_authentication/log.html
Report:  ...s/nef_authentication/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```

