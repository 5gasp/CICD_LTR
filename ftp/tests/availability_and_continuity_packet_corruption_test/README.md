TCTest.py
The script starts by stopping the Movement of All UEs (if any of the UEs moves already).
After this initialization step, the script makes an authentication request and gets a Bearer, which is used to start the movement of a UE using the bearer, the nef_url and the UE supi.
The script then waits for a predetermined amount of time defined per UE (based one the time that is required for each path to be completed two consecutive times.
Then a command for the UE’s movement stop is sent and a command to delete any NEF monitoring subscriptions present for the UE (using the bearer, the nef_url and the externalId of the UE).

Robot Scripts
For each UE a robot script has been created that executes the TCTest.py script for each UE.

Traffic Control Rules
Tc rules have been updated for 
•	Communication loss
•	Throttling
•	Packet Corruption 5%
•	Packet Error Rate 5%
•	Packet Loss 5%
