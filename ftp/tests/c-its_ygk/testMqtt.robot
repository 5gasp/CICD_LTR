| *Settings* | *Value*                  |
| Library    | MQTTLibrary              |
| Library    | Collections              |
| Resource   | choirkeywords.resource   |

| *Variables*       |
# | ${MQTT_BROKER_IP} | 192.168.35.43
| ${MQTT_BROKER_IP} | %{SERVER_IP=127.0.0.1}
# | ${choir.ip}       | 10.0.30.151
| ${choir.ip}       | %{CHOIR_IP=127.0.0.1}
| ${PUB_TOPIC}      | upstream/quad/0/3/1/3/3/1/1/0/3/3/0/3/3/0/0/0/1/2/cam/1000/json
| ${SUB_TOPIC}      | downstream/quad/0/3/1/3/3/1/1/0/3/3/0/3/3/0/0/+/+/+/cam/1000/json
| ${PUB_MESSAGE}    | {"header":{"messageID":2,"protocolVersion":2,"stationID":1000},"cam":{"generationDeltaTime":23709,"camParameters":{"basicContainer":{"referencePosition":{"altitude":{"altitudeValue":18200,"altitudeConfidence":"alt-050-00"},"positionConfidenceEllipse":{"semiMajorOrientation":0,"semiMinorConfidence":1,"semiMajorConfidence":1},"latitude":481358000,"longitude":-16220000},"stationType":5},"highFrequencyContainer":{"basicVehicleContainerHighFrequency":{"vehicleLength":{"vehicleLengthValue":1023,"vehicleLengthConfidenceIndication":"unavailable"},"accelerationControl":"00","vehicleWidth":61,"yawRate":{"yawRateValue":32767,"yawRateConfidence":"unavailable"},"heading":{"headingValue":1800,"headingConfidence":1},"curvatureCalculationMode":"unavailable","longitudinalAcceleration":{"longitudinalAccelerationValue":161,"longitudinalAccelerationConfidence":102},"driveDirection":"unavailable","speed":{"speedValue":140,"speedConfidence":1},"curvature":{"curvatureConfidence":"unavailable","curvatureValue":1023}}}}}}

| *Test Cases*
| Print variables
| | Log To Console      | Environment variables :
| | Log To Console      |   MQTT_BROKER_IP (data plane): ${MQTT_BROKER_IP} 
| | Log To Console      |   CHOIR_IP (control plane): ${choir.ip} 

| Testing forwarding from upstream to downstream
| | MQTTLibrary.Connect            | ${MQTT_BROKER_IP}
| | MQTTLibrary.Subscribe          | topic=${SUB_TOPIC}      | qos=1                  | timeout=0 | limit=0
| | MQTTLibrary.Publish            | topic=${PUB_TOPIC}      | message=${PUB_MESSAGE}
| | ${SUB_MESSAGE}                 | MQTTLibrary.Listen      | topic=${SUB_TOPIC}     | timeout=3 | limit=2
| | MQTTLibrary.Disconnect
| | Should Not Be Empty           |  ${SUB_MESSAGE}
| | Should Be Equal As Strings    | '${SUB_MESSAGE}[0]'     | '${PUB_MESSAGE}'

| Testing insertion in Cache
| | MQTTLibrary.Connect            | ${MQTT_BROKER_IP}
| | MQTTLibrary.Publish            | topic=${PUB_TOPIC} | message=${PUB_MESSAGE}
| | ${cache_get}                   | Choir CacheGet     | cache_id=10            | object_id=562949953422312
| | Dictionary Should Contain Item | ${cache_get}       | key=stationid          | value=${1000}
| | Disconnect