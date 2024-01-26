# Maximum Number of Connections Test

## 1. Test Goals

This test aims at computing the maximmum number of concurrent connections supported by a Network Application.
Given that the majority of the Network Applications rely on APIs, we can exercise these APIs to generate additional connections.
Therefore, we use locust to perform a load test on one of the Network Application's API. Locust clients will generate various concurrent connections.

## 2. Test Description

Validate by measuring maximum number of simultaneous connections established to the Network Application.

The test flow is the following:

1. Invoke the MiniAPI start test endpoint. Doing so will trigger the monitoring of the established connections
2. Invoke the Locust Load Test to generate traffic to the Network Application (this relies on a 'host', 'endpoint' and 'http_method' parameters passed by the tester)
3. Invoke the MiniAPI stop test endpoint. Will stop the monitoring of the established connections
4. Invoke the MiniAPI test restults endpoint to gather a file with the recorded established connections
5. Finally, evaluate the results agains the intended threshold

## 3. Inputs

Environment Variables that must be specified:
- 

Example:
- 

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Maximum Number Of Connections Test
==============================================================================
Maximum Number Of Connections Test.Maximum Number Of Connections Test
==============================================================================
Run Locust Requests Per Second Test                                   ...
Load Test Host: http://10.255.28.206:8080
.
Load Test
.
Load Test
Run Locust Requests Per Second Test                                   ..
Locust Output:
 [
    {
        "name": "/",
        "method": "GET",
        "last_request_timestamp": 1706116104.1884449,
        "start_time": 1706116084.684126,
        "num_requests": 1295,
        "num_none_requests": 0,
        "num_failures": 0,
        "total_response_time": 32329.271475000045,
        "max_response_time": 739.519146,
        "min_response_time": 3.6892750000010466,
        "total_content_length": 14245,
        "response_times": {
            "75": 2,
            "73": 3,
            "76": 1,
            "70": 1,
            "69": 1,
            "79": 1,
            "72": 2,
            "78": 1,
            "120.0": 3,
            "130.0": 9,
            "140.0": 11,
            "160.0": 10,
            "240.0": 17,
            "250.0": 2,
            "480.0": 8,
            "470.0": 4,
            "740.0": 3,
            "46": 1,
            "51": 2,
            "50": 1,
            "52": 1,
            "54": 2,
            "55": 2,
            "58": 2,
            "150.0": 5,
            "29": 2,
            "5": 127,
            "6": 291,
            "10": 62,
            "7": 306,
            "8": 162,
            "460.0": 1,
            "15": 9,
            "9": 101,
            "730.0": 4,
            "17": 6,
            "4": 23,
            "11": 26,
            "12": 11,
            "14": 16,
            "13": 15,
            "19": 4,
            "34": 1,
            "31": 1,
            "27": 1,
            "24": 3,
            "26": 1,
            "20": 3,
            "23": 2,
            "18": 4,
            "45": 1,
            "42": 3,
            "16": 3,
            "28": 4,
            "21": 3,
            "38": 1,
            "37": 1,
            "36": 1,
            "22": 1
        },
        "num_reqs_per_sec": {
            "1706116084": 43,
            "1706116085": 56,
            "1706116086": 61,
            "1706116087": 67,
            "1706116088": 66,
            "1706116089": 69,
            "1706116090": 64,
            "1706116091": 66,
            "1706116092": 62,
            "1706116093": 69,
            "1706116094": 65,
            "1706116095": 69,
            "1706116096": 70,
            "1706116097": 62,
            "1706116098": 63,
            "1706116099": 65,
            "1706116100": 66,
            "1706116101": 68,
            "1706116102": 63,
            "1706116103": 63,
            "1706116104": 18
        },
        "num_fail_per_sec": {}
    }
]
.....
Maximum Number Of Connections: 16
Run Locust Requests Per Second Test                                   | PASS |
The Target Server/API COMPLIES with the minimum threshold set for number of concurrent connections (10).
------------------------------------------------------------------------------
Maximum Number Of Connections Test.Maximum Number Of Connections Test | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Maximum Number Of Connections Test                                    | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Maximum Number Of Connections Test
==============================================================================
Maximum Number Of Connections Test.Maximum Number Of Connections Test
==============================================================================
Run Locust Requests Per Second Test                                   ...
Load Test Host: http://10.255.28.206:8080
.
Load Test
.
Load Test
Run Locust Requests Per Second Test                                   ..
Locust Output:
 [
    {
        "name": "/",
        "method": "GET",
        "last_request_timestamp": 1706116171.086952,
        "start_time": 1706116151.4493902,
        "num_requests": 1317,
        "num_none_requests": 0,
        "num_failures": 0,
        "total_response_time": 30440.410223999977,
        "max_response_time": 692.0628120000001,
        "min_response_time": 2.8063070000001744,
        "total_content_length": 14487,
        "response_times": {
            "96": 1,
            "120.0": 4,
            "170.0": 10,
            "160.0": 4,
            "200.0": 6,
            "190.0": 14,
            "230.0": 13,
            "240.0": 8,
            "54": 1,
            "56": 1,
            "55": 1,
            "58": 1,
            "61": 1,
            "63": 1,
            "67": 1,
            "53": 1,
            "73": 1,
            "76": 1,
            "77": 1,
            "78": 1,
            "84": 1,
            "85": 1,
            "100.0": 3,
            "150.0": 5,
            "140.0": 2,
            "4": 35,
            "6": 321,
            "5": 167,
            "7": 313,
            "9": 90,
            "8": 162,
            "370.0": 2,
            "380.0": 2,
            "420.0": 2,
            "410.0": 1,
            "430.0": 3,
            "440.0": 3,
            "19": 2,
            "14": 8,
            "15": 5,
            "16": 7,
            "690.0": 3,
            "13": 10,
            "12": 12,
            "10": 33,
            "11": 23,
            "25": 2,
            "24": 4,
            "3": 5,
            "39": 2,
            "29": 1,
            "31": 1,
            "36": 1,
            "22": 1,
            "20": 3,
            "35": 1,
            "32": 1,
            "40": 1,
            "27": 3,
            "37": 1,
            "23": 1,
            "21": 1
        },
        "num_reqs_per_sec": {
            "1706116151": 50,
            "1706116152": 69,
            "1706116153": 65,
            "1706116154": 66,
            "1706116155": 69,
            "1706116156": 63,
            "1706116157": 73,
            "1706116158": 55,
            "1706116159": 70,
            "1706116160": 68,
            "1706116161": 61,
            "1706116162": 72,
            "1706116163": 65,
            "1706116164": 64,
            "1706116165": 69,
            "1706116166": 64,
            "1706116167": 72,
            "1706116168": 65,
            "1706116169": 65,
            "1706116170": 67,
            "1706116171": 5
        },
        "num_fail_per_sec": {}
    }
]
.....
Maximum Number Of Connections: 14
Run Locust Requests Per Second Test                                   | FAIL |
The Target Server/API DOES NOT comply with the minimum threshold set for number of concurrent connections(30).
------------------------------------------------------------------------------
Maximum Number Of Connections Test.Maximum Number Of Connections Test | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Maximum Number Of Connections Test                                    | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/maximum_number_of_connections_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, either `netstat` or `ss` must be installed on the VNF.

### 5.2. Python Requirements

```
robotframework==6.0.2
locust==2.20.0
requests==2.31.0
```
