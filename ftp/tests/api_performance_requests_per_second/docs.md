# API Performance Requests Per Second

## 1. Test Goals

Validate by measuring how many requests the Network Application API can serve per second.

## 2. Test Description

This test is designed to evaluate the performance of an API under various conditions. It primarily focuses on measuring the API's ability to handle a high volume of requests per second, ensuring both robustness and scalability.

## 3. Inputs

Environment Variables that must be specified:
- `api_performance_requests_per_second_host`
- `api_performance_requests_per_second_endpoint`
- `api_performance_requests_per_second_http_method`
- `api_performance_requests_per_second_min_threshold`

Example:
- `export api_performance_requests_per_second_host=https://community.5gasp.eu`
- `export api_performance_requests_per_second_endpoint=/index.php/category/blog/`
- `export api_performance_requests_per_second_http_method=GET`
- `export api_performance_requests_per_second_min_threshold=10`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Api Performance Requests Per Second
==============================================================================
Api Performance Requests Per Second.Api Performance Requests Per Second
==============================================================================
Run Locust Requests Per Second Test                                   ....

Test Host: https://www.google.com/
.
Test endpoint:
.
Test HTTP Method: GET
.
Minimum Threshhold - Requests Per Second: 10 requests/sec.
Run Locust Requests Per Second Test                                   ...

[RESULT] Median Requests Per Second: 20.0 requests/sec.

Run Locust Requests Per Second Test                                   | PASS |
The Target Server/API COMPLIES with the minimum threshold set for number of requests/sec (10).
------------------------------------------------------------------------------
Api Performance Requests Per Second.Api Performance Requests Per S... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Api Performance Requests Per Second                                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Api Performance Requests Per Second
==============================================================================
Api Performance Requests Per Second.Api Performance Requests Per Second
==============================================================================
Run Locust Requests Per Second Test                                   ....

Test Host: https://community.5gasp.eu
.
Test endpoint: /index.php/category/blog/
.
Test HTTP Method: GET
.
Minimum Threshhold - Requests Per Second: 10 requests/sec.
Run Locust Requests Per Second Test                                   ...

[RESULT] Median Requests Per Second: 3 requests/sec.

Run Locust Requests Per Second Test                                   | FAIL |
The Target Server/API DOES NOT comply with the minimum threshold set for number of requests/sec (10).
------------------------------------------------------------------------------
Api Performance Requests Per Second.Api Performance Requests Per S... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Api Performance Requests Per Second                                   | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_requests_per_second/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
locust==2.20.0
```