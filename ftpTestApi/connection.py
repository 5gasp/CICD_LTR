
#!/usr/bin/python3

import ftplib
import json
from textwrap import indent
import requests
import os

#FTP File Reading Class

# class Reader:
#     def __init__(self):
#         self.data = ""

#     def __call__(self, s):
#         self.data += str(s)


#Reading Environment Variables

ftpIP = os.environ["FTPIP"]
ftpUser = os.environ["FTPUser"]
ftpPassword = os.environ["FTPPassword"]
ftpDir = os.environ["FTPDir"]

managerIP = os.environ["ManagerIP"]


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

        # r = Reader()
        # ftp.retrbinary('RETR test_description.yaml', r)
        result[dir] = 'Test found for '+dir

    ftp.cwd('..')

result["Total Tests"] = count

x = requests.post('http://'+managerIP, result)

print(json.dumps(result, indent=2))
