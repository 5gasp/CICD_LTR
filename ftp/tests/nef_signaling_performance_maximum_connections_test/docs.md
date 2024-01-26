# NEF Signaling Performance Maximum Connections Test

## 1. Test Goals

This test aims at computing the maximmum number of concurrent connections supported by the Network Application's API that will receive the NEF Callbacks.
We use locust to perform a load test on one of the NEF Callback API. Locust clients will generate various concurrent connections.

## 2. Test Description

Validate by measuring maximum number of simultaneous connections established to the NEF API.

The test flow is the following:

1. Invoke the MiniAPI start test endpoint. Doing so will trigger the monitoring of the established connections
2. Invoke the Locust Load Test to generate traffic to the Network Application (this relies on a 'host' and 'endpoint' parameters passed by the tester)
3. Invoke the MiniAPI stop test endpoint. Will stop the monitoring of the established connections
4. Invoke the MiniAPI test restults endpoint to gather a file with the recorded established connections
5. Finally, evaluate the results agains the intended threshold

## 3. Inputs

Environment Variables that must be specified:
- `nef_signaling_performance_maximum_connections_test_load_test_host`
- `nef_signaling_performance_maximum_connections_test_load_test_endpoint`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results`
- `nef_signaling_performance_maximum_connections_test_connections_minimum_threshold`

Example:
- `nef_signaling_performance_maximum_connections_test_load_test_host=http://10.255.28.206:8080`
- `nef_signaling_performance_maximum_connections_test_load_test_endpoint=/`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def14Perf7`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup=http://10.255.28.206:8000/stop/Def14Perf7`
- `nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results=http://10.255.28.206:8000/results/Def14Perf7`
- `nef_signaling_performance_maximum_connections_test_connections_minimum_threshold=100`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Maximum Connections Test
==============================================================================
Nef Signaling Performance Maximum Connections Test.Nef Signaling Performanc...
==============================================================================
Run Locust Requests Per Second Test                                   ..
Load Test Host: http://10.255.28.206:8080
.
Load Test
.....
Locust Output:
 [
    {
        "name": "/",
        "method": "POST",
        "last_request_timestamp": 1706115474.0923772,
        "start_time": 1706115454.561959,
        "num_requests": 252,
        "num_none_requests": 0,
        "num_failures": 3,
        "total_response_time": 12018.131952999993,
        "max_response_time": 1049.325875,
        "min_response_time": 3.7312880000008875,
        "total_content_length": 2739,
        "response_times": {
            "32": 3,
            "49": 3,
            "48": 3,
            "50": 1,
            "54": 1,
            "52": 1,
            "140.0": 4,
            "1000.0": 9,
            "8": 40,
            "6": 65,
            "5": 43,
            "7": 60,
            "9": 8,
            "10": 1,
            "4": 4,
            "11": 5,
            "12": 1
        },
        "num_reqs_per_sec": {
            "1706115454": 16,
            "1706115455": 12,
            "1706115456": 13,
            "1706115457": 10,
            "1706115458": 14,
            "1706115459": 12,
            "1706115460": 15,
            "1706115461": 12,
            "1706115462": 12,
            "1706115463": 9,
            "1706115464": 10,
            "1706115465": 14,
            "1706115466": 11,
            "1706115467": 13,
            "1706115468": 14,
            "1706115469": 12,
            "1706115470": 10,
            "1706115471": 13,
            "1706115472": 13,
            "1706115473": 13,
            "1706115474": 4
        },
        "num_fail_per_sec": {
            "1706115454": 3
        }
    }
]
Run Locust Requests Per Second Test                                   .....
Maximum Number Of Connections: 13
Run Locust Requests Per Second Test                                   | PASS |
The Target Server/API COMPLIES with the minimum threshold set for number of concurrent connections (2).
------------------------------------------------------------------------------
Nef Signaling Performance Maximum Connections Test.Nef Signaling P... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Signaling Performance Maximum Connections Test                    | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Maximum Connections Test
==============================================================================
Nef Signaling Performance Maximum Connections Test.Nef Signaling Performanc...
==============================================================================
Run Locust Requests Per Second Test                                   ..
Load Test Host: http://10.255.28.206:8080
.
Load Test
.....
Locust Output:
 [
    {
        "name": "/",
        "method": "POST",
        "last_request_timestamp": 1706115565.614141,
        "start_time": 1706115546.3050292,
        "num_requests": 258,
        "num_none_requests": 0,
        "num_failures": 5,
        "total_response_time": 3745.125101000002,
        "max_response_time": 143.00043699999998,
        "min_response_time": 3.8928540000000567,
        "total_content_length": 2783,
        "response_times": {
            "57": 3,
            "56": 1,
            "55": 1,
            "64": 2,
            "63": 1,
            "66": 1,
            "65": 1,
            "61": 1,
            "100.0": 7,
            "98": 1,
            "96": 1,
            "99": 1,
            "110.0": 2,
            "140.0": 2,
            "5": 51,
            "7": 55,
            "8": 30,
            "6": 61,
            "9": 14,
            "4": 7,
            "10": 8,
            "12": 2,
            "11": 4,
            "32": 1
        },
        "num_reqs_per_sec": {
            "1706115546": 25,
            "1706115547": 8,
            "1706115548": 17,
            "1706115549": 11,
            "1706115550": 14,
            "1706115551": 9,
            "1706115552": 14,
            "1706115553": 15,
            "1706115554": 7,
            "1706115555": 17,
            "1706115556": 8,
            "1706115557": 16,
            "1706115558": 12,
            "1706115559": 12,
            "1706115560": 12,
            "1706115561": 12,
            "1706115562": 8,
            "1706115563": 16,
            "1706115564": 13,
            "1706115565": 12
        },
        "num_fail_per_sec": {
            "1706115546": 5
        }
    }
]
Run Locust Requests Per Second Test                                   .....
Maximum Number Of Connections: 13
Run Locust Requests Per Second Test                                   | FAIL |
The Target Server/API DOES NOT comply with the minimum threshold set for number of concurrent connections(100).
------------------------------------------------------------------------------
Nef Signaling Performance Maximum Connections Test.Nef Signaling P... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Signaling Performance Maximum Connections Test                    | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_maximum_connections_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, either `netstat` or `ss` must be installed on the VNF that comprises the API that was declared for the NEF Callback.

### 5.2. Python Requirements

```
robotframework==6.0.2
locust==2.20.0
requests==2.31.0
```
