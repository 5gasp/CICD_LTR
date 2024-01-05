# Test Case Description: NEF Signaling API - Maximum Number of Connections Test

This test aims at computing the maximmum number of concurrent connections supported by the Network Application's API that will receive the NEF Callbacks.
We use locust to perform a load test on one of the NEF Callback API. Locust clients will generate various concurrent connections.

The test flow is the following:

1. Invoke the MiniAPI start test endpoint. Doing so will trigger the monitoring of the established connections
2. Invoke the Locust Load Test to generate traffic to the Network Application (this relies on a 'host' and 'endpoint' parameters passed by the tester)
3. Invoke the MiniAPI stop test endpoint. Will stop the monitoring of the established connections
4. Invoke the MiniAPI test restults endpoint to gather a file with the recorded established connections
5. Finally, evaluate the results agains the intended threshold