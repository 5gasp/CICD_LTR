# -*- coding: utf-8 -*-
# @Author: Luka Korsic
# @Date:   2023-06-10 16:09:37
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-06-10 16:33:35
import subprocess
import re

def ip_ping_rtt(target, count='5'):

    result = "-1"
    code   = -1

    try:
        result = subprocess.check_output('ping -c ' + count +  ' ' + target, shell=True).decode('utf-8').strip('\n')
        code = 0
    except Exception as e:
        try:
            result = str(e.output.decode("utf-8"))
            code   = int(e.returncode)
        except :
            None

    # Parse results
    results_json = {}
    results_json['raw']     = result
    results_json['code']    = code
    
    try:
        results = []
        target = re.search(r'PING (.*?) ', result).group(1).strip()
        for line in result.splitlines():
            result_tmp = {}

            icmp_seq = re.search(r'icmp_seq=(.*?) ', line)               
            if icmp_seq != None:
                if 'bytes from' in line:
                    result_tmp['status'] = 'Success'
                    result_tmp['status_code'] = code
                    result_tmp['target'] = target
                    result_tmp['rtt_ms'] = re.search(r'time=(.*?)ms', line).group(1).strip()
                    result_tmp['icmp_seq'] = icmp_seq.group(1).strip()
                elif 'Destination Host Unreachable' in line:
                    result_tmp['target'] = target
                    result_tmp['status'] = 'Destination Host Unreachable'
                    result_tmp['status_code'] = 1
                    result_tmp['rtt_ms'] = -1
                    result_tmp['icmp_seq'] = icmp_seq.group(1).strip()
                else:
                    result_tmp['target'] = target
                    result_tmp['status'] = 'Unknown error'
                    result_tmp['status_code'] = 2
                    result_tmp['rtt_ms'] = -1
                    result_tmp['icmp_seq'] = icmp_seq.group(1).strip()
                
                results.append(result_tmp)

        results_json['results'] = results

    except Exception as e:
        return "Ping parser not successful"
    
    # Debug
    print(results_json)
    if 'raw' in results_json:
        print(results_json['raw'])

    # Calculate sum and average rtt
    try:
        sum_rtt_ms = 0.0    
        for item in results_json['results']:
            sum_rtt_ms += float(item['rtt_ms'])

        if len(results_json['results']) > 0:
            rtt_ms_avg = sum_rtt_ms/len(results_json['results'])
            return round(rtt_ms_avg,2)
        else:
            return "Fail: RTT results not available."
    except Exception as e:
        return str(e)

if __name__ == "__main__":
    print(ip_ping_rtt("5gasp.eu"))