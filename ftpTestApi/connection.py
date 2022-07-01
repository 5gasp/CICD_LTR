
#!/usr/bin/python3

import ftplib
import json
from textwrap import indent
import requests
import os

# FTP File Reading Class

class Reader:
    def __init__(self):
        self.data = ""

    def __call__(self, s):
        self.data += str(s)


#Reading Environment Variables

ftpIP = os.environ["FTPIP"]
ftpUser = os.environ["FTPUser"]
ftpPassword = os.environ["FTPPassword"]
ftpDir = os.environ["FTPDir"]

cicdManagerIP = os.environ["CI_CD_Manager_IP"]
cicdManagerUser = os.environ["CI_CD_Manager_User"]
cicdManagerPassword = os.environ["CI_CD_Manager_Password"]



#Establish Connection to server
ftp = ftplib.FTP(ftpIP, ftpUser, ftpPassword)

count = 0
result = {}

ftp.cwd(ftpDir)

#Read and retrieve all test descriptions
for dir in ftp.nlst():

    ftp.cwd(dir)

    if 'test_description.yaml' in ftp.nlst():
        count += 1

        r = Reader()
        ftp.retrbinary('RETR test_description.yaml', r)
        result[dir] = r.data

    ftp.cwd('..')

result["Total Tests"] = count

try:
    headers = {
        'accept': 'application/json',
    }

    json_data = {
        'username': cicdManagerUser,
        'password': cicdManagerPassword,
    }

    response = requests.post('http://'+cicdManagerIP+'/users/login', headers=headers, json=json_data)

    if response.status_code == 200:
        
        # Endpoint to later send the 
        # x = requests.post('http://'+cicdManagerIP +'/...', result)
        print("Total Tests: "+ json.dumps(result["Total Tests"], indent=1))


except ValueError:
    print(ValueError)