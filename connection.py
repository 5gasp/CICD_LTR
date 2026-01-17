
#!/usr/bin/python3

import ftplib
import json
import requests

urlFTPServer="10.0.12.114"
urlManager='http://10.0.12.114:80'

ftp = ftplib.FTP(urlFTPServer,'ftp-user','ftp-password')

count=0
result={}

ftp.cwd('tests')

for dir in ftp.nlst():
    ftp.cwd(dir)

    if 'test_description.yaml' in ftp.nlst():
        count+=1
        result[dir]='test-description.yaml'
    
    ftp.cwd('..')

result["Total Tests"] = count

x=requests.post(urlManager, result)

print(result)