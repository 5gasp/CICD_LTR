| *Settings* | *Value*  | 
| Library    | Choir.py | ${choir.ip} | ${choir.port} | ${choir.appid}


| *Variables*         |
| ${choir.ip}         | 127.0.0.1
| ${choir.port}       | 8080
| ${choir.appid}      | 13265

| *Keywords* |
| Choir CacheGet
| | [Arguments]   | ${cache_id}    | ${object_id}
| | ${dict}       | Choir.Cacheget | ${cache_id} | ${object_id}
| | [return]      | ${dict}

| Choir Publish
| | [Arguments]   | ${msg_id}      | ${payload}
| | ...           | ${format}
| | Choir.Publish | ${msg_id} | ${payload} | ${format}




