# API Performance Response Time

## 1. Test Goals

Validate by measuring Network Application API response time.

## 2. Test Description

This test is designed to rigorously assess the performance and responsiveness of an API. The primary aim is to ensure that the API can handle high traffic efficiently while maintaining optimal response times. By simulating realistic load scenarios and analyzing response behaviors under various conditions, this test suite helps in identifying potential performance bottlenecks and ensures that the API can deliver a reliable, high-quality user experience even under peak load conditions.

## 3. Inputs

Environment Variables that must be specified:
- `api_performance_response_time_api_target`
- `api_performance_response_time_api_target`

Example:
- `export api_performance_response_time_api_target=https://community.5gasp.eu`
- `export api_performance_response_time_threshold_ms=1000`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Api Performance Response Time
==============================================================================
Api Performance Response Time.Api Performance Response Time
==============================================================================
API Performance Response Time - Network Application - API performa... ..Response Time 384.9978446960449 s, threshold 1000, target: https://google.pt
API Performance Response Time - Network Application - API performa... | PASS |
------------------------------------------------------------------------------
Api Performance Response Time.Api Performance Response Time           | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Api Performance Response Time                                         | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Api Performance Response Time
==============================================================================
Api Performance Response Time.Api Performance Response Time
==============================================================================
API Performance Response Time - Network Application - API performa... | FAIL |
'673.0151176452637 < 500' should be true.
------------------------------------------------------------------------------
Api Performance Response Time.Api Performance Response Time           | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Api Performance Response Time                                         | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/api_performance_response_time/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```