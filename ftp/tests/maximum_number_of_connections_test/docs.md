# Test Case Description: Maximum Number of Connections Test

This test aims at computing the maximmum number of concurrent connections supported by a Network Application.
Given that the majority of the Network Applications rely on APIs, we can exercise these APIs to generate additional connections.
Therefore, we use locust to perform a load test on one of the Network Application's API. Locust clients will generate various concurrent connections.

The test flow is the following:

1. Invoke the MiniAPI start test endpoint. Doing so will trigger the monitoring of the established connections
2. Invoke the Locust Load Test to generate traffic to the Network Application (this relies on a 'host', 'endpoint' and 'http_method' parameters passed by the tester)
3. Invoke the MiniAPI stop test endpoint. Will stop the monitoring of the established connections
4. Invoke the MiniAPI test restults endpoint to gather a file with the recorded established connections
5. Finally, evaluate the results agains the intended threshold