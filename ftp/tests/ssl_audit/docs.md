# SSL Audit

## 1. Test Goals

This test aims to perform a security assessment of SSL Certificates protecting a resource/endpoint. This test evaluates the certificate, its chain, its validity, etc.

## 2. Test Description

This test requires the client to indicate which protected resource shall be validated. To this end, the clients must indicate an URL. Based on this URL, SSLyze will obtain the SSL certificate protecting the resource, and will evaluate its chain, its validity, its cipher suites, etc. The results are then compared to Mozilla's recommended SSL configuration. However, 5GASP does not follow such restrictive configurations so, even if a specific TLS configuration is not compliant to Mozilla's recommended SSL configuration, this test might still be successful according to 5GASP's directives. A good example of this is related to the certificate's Common Name. In 5GASP we don't enforce a validation on the certificate's common name. 

## 3. Inputs

The SSL Audit Test takes as an input the url that points to SSL protected resource.
This URL should encompass only the domain/ip and the port where the resource is being executed.

Environment Variables that must be specified:
- ssl_audit_url

Example:
- `export ssl_audit_url=ci-cd-service.5gasp.eu` (by default, the port will be 443)
- `export ssl_audit_url=atnog-harbor.av.it.pt:443`
- `export ssl_audit_url=10.0.10.92:443`
- `export ssl_audit_url=10.0.20.22:30001`


## 4. Outputs

### 4.1. Example - Test Failed  Due to an Incorrect Scan

``` 
→ python -m robot test_ssl_audit.robot 
==============================================================================
Test Ssl Audit                                                                
==============================================================================
Performing ssl audit                                                  | FAIL |
RESULT: 10.0.12.86:441: ERROR - Scan did not run successfully; review the scan logs above.
ERRORS:
        -> 10.0.12.86:441: ERROR - Scan did not run successfully; review the scan logs above.
------------------------------------------------------------------------------
Test Ssl Audit                                                        | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /home/ubuntu/ssl_audit/output.xml
Log:     /home/ubuntu/ssl_audit/log.html
Report:  /home/ubuntu/ssl_audit/report.html
```

### 4.2. Example - Test Failed Due to Incorrect SSL Configurations

``` 
→ python -m robot test_ssl_audit.robot 
==============================================================================
Test Ssl Audit                                                                
==============================================================================
Performing ssl audit                                                  | FAIL |
RESULT: xyz.av.it.pt:443: FAILED - Not compliant.
ERRORS:
        -> certificate_path_validation: Certificate path validation failed for CN=*.av.it.pt.
        -> maximum_certificate_lifespan: Certificate life span is 370 days, should be less than 366.
        -> ciphers: Cipher suites {'TLS_RSA_WITH_AES_128_CCM', 'TLS_RSA_WITH_AES_256_CCM_8', 'TLS_RSA_WITH_AES_128_CCM_8', 'TLS_RSA_WITH_AES_256_CBC_SHA', 'TLS_RSA_WITH_AES_128_CBC_SHA256', 'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA', 'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384', 'TLS_RSA_WITH_AES_128_CBC_SHA', 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256', 'TLS_RSA_WITH_AES_256_CBC_SHA256', 'TLS_RSA_WITH_AES_128_GCM_SHA256', 'TLS_RSA_WITH_AES_256_CCM', 'TLS_RSA_WITH_AES_256_GCM_SHA384', 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA'} are supported, but should be rejected.
------------------------------------------------------------------------------
Test Ssl Audit                                                        | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /home/ubuntu/ssl_audit/output.xml
Log:     /home/ubuntu/ssl_audit/log.html
Report:  /home/ubuntu/ssl_audit/report.html
```


### 4.3. Example - Test Succeeded and in Accordance to Mozilla's SSL Recommended Configurations

``` 
→ python -m robot test_ssl_audit.robot 
==============================================================================
Test Ssl Audit                                                                
==============================================================================
Performing ssl audit                                                  | PASS |
Result: ci-cd-service.5gasp.eu:443: OK - Compliant.
------------------------------------------------------------------------------
Test Ssl Audit                                                        | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /home/ubuntu/ssl_audit/output.xml
Log:     /home/ubuntu/ssl_audit/log.html
Report:  /home/ubuntu/ssl_audit/report.html
```

### 4.4. Example - Test Succeeded but not in Accordance to Mozilla's SSL Recommended Configurations

``` 
→ python -m robot test_ssl_audit.robot 
==============================================================================
Test Ssl Audit                                                                
==============================================================================
Performing ssl audit                                                  | PASS |
Result: 10.0.10.92:443: OK - Compliant with 5GASP requirements.
------------------------------------------------------------------------------
Test Ssl Audit                                                        | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /home/ubuntu/ssl_audit/output.xml
Log:     /home/ubuntu/ssl_audit/log.html
Report:  /home/ubuntu/ssl_audit/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
sslyze==5.1.1
```
