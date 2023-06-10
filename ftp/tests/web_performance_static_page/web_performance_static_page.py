# -*- coding: utf-8 -*-
# @Author: Luka Korsic
# @Date:   2023-06-10 16:09:37
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-06-10 16:32:33
import time
import subprocess
import re
import os
from math import exp

def parse_wget_linux_bruto_duration(line):
    """
    Parse WGET bruto duration
    """

    duration = -1

    # Bruto time
    re_bruto = re.compile(r'Total wall clock time:\s*([0-9,m]*\s*[0-9,.s]*)')
    bruto = re_bruto.search(line)

    if bruto:
        bruto = bruto.group(1)

        fields = bruto.split()
        if fields[0][-1] == 's':
            duration = float(fields[0][:-1].replace(',', '.'))
        elif fields[0][-1] == 'm':
            duration = float(fields[0][:-1].replace(',', '.'))*60
            if fields[1][-1] == 's':
                duration += float(fields[1][:-1].replace(',', '.'))

    return duration

def parse_wget_linux_bruto_speed(duration, size):
    """
    Parse WGET bruto speed
    """

    speed = -1

    try:
        # Speed [bit/s]
        speed = size/duration
    except Exception:
        pass
    finally:
        return speed

def parse_wget_linux_neto(line):
    """
    Parse WGET neto results
    """

    result = (-1, -1, -1, -1)

    fields = line.split()

    # Number of transfer files
    noOfFiles = int(fields[1])

    # Size of transfer files
    sizeOfFiles = float(fields[3][:-1].replace(',', '.'))

    unit = fields[3][-1]
    if unit == 'G':
        sizeOfFiles = int(sizeOfFiles*1024*1024*1024)*8
    elif unit == 'M':
        sizeOfFiles = int(sizeOfFiles*1024*1024)*8
    elif unit == 'K':
        sizeOfFiles = int(sizeOfFiles*1024)*8
    elif unit == 'B':
        sizeOfFiles = int(sizeOfFiles)*8
    else:
        sizeOfFiles = int(sizeOfFiles)

    # Neto duration
    if fields[5][-1] == 's':
        duration = float(fields[5][:-1].replace(',', '.'))
    elif fields[5][-1] == 'm':
        duration = float(fields[5][:-1].replace(',', '.'))*60
        if fields[6][-1] == 's':
            duration += float(fields[6][:-1].replace(',', '.'))
    else:
        return result

    # Neto speed [bit/s]
    if fields[7].rstrip(')') == 'B/s':
        speed = float(fields[6].lstrip('(').replace(',', '.'))*8
    elif fields[7].rstrip(')') == 'KB/s':
        speed = float(fields[6].lstrip('(').replace(',', '.'))*1024*8
    elif fields[7].rstrip(')') == 'MB/s':
        speed = float(fields[6].lstrip('(').replace(',', '.'))*1024*1024*8
    elif fields[7].rstrip(')') == 'GB/s':
        speed = float(fields[6].lstrip('(').replace(',', '.'))*1024*1024*1024*8
    else:
        return result

    result = (duration,  speed,  noOfFiles,  sizeOfFiles)

    return result


def get_wget_results(filename):
    """
    Parse output from WGET application
    """

    raw     = '-1'        
    results = {}
    code    = -1
    status = '-1'
    
    wget_neto = (-1, -1, -1, -1, -1)
    bruto_line = None
    neto_line = None

    with open(filename, 'r') as wget:
        for line in reversed(wget.readlines()):

            if line.find('wget: unable to resolve host address') != -1:
                status = "Unable_to_resolve_host_address"

            elif line.find('WGET Timeout') != -1:
                status = "Timeout"

            if line.find('Total wall clock time:') != -1:
                bruto_line = line

            if line.find('Downloaded:') != -1:
                neto_line = line

            if bruto_line is not None and neto_line is not None:
                # WGET neto
                wget_neto = parse_wget_linux_neto(neto_line)
                raw  = 'WGET duration neto: ' + str(wget_neto[0]) + '\n'
                raw += 'WGET speed neto: ' + str(wget_neto[1]) + '\n'
                raw += 'WGET size of files: ' + str(wget_neto[3]) + '\n'
                

                # Bruto duration
                wget_bruto_duration = parse_wget_linux_bruto_duration(bruto_line)
                raw += 'WGET duration bruto: ' + str(wget_bruto_duration) + '\n'

                # Bruto speed
                wget_bruto_speed = parse_wget_linux_bruto_speed(wget_bruto_duration, wget_neto[3])
                raw += 'WGET speed bruto: ' + str(wget_bruto_speed) + '\n'

                # MOS
                mos = -1
                if float(wget_bruto_duration) == -1:
                    mos = -1
                else:
                    mos = 4.109*exp(-0.1522*float(wget_bruto_duration))+1.05

                    # Max MOS=5
                    if mos > 5:
                        mos = 5
                raw += 'WGET MOS: ' + str(mos) + '\n'

                results['duration_neto'] = wget_neto[0]
                results['speed_neto'] = wget_neto[1]
                results['size_of_files'] = wget_neto[3]
                results['duration_bruto'] = wget_bruto_duration
                results['speed_bruto'] = wget_bruto_speed
                results['mos'] = mos
                status = 'Success'
                code = 0

    results['status'] = status
    results['status_code'] = code

    return raw, results, code

def web_speed(target):

    tmp_folder = 'tmp/' 
    file_name = 'test_web_1' 
    timeout = 60 
    ip_version = '4' 

    # Parse results
    results_json = {}
    results_json['raw']     = '-1'
    results_json['code']    = -1
    results_json['results'] = '-1'

    # Create folder
    try:
        if not os.path.exists(tmp_folder):
            os.makedirs(tmp_folder)
    except Exception as e:
        return e

    # Check if previous file exists (MD5 generated file)
    summaryExists = True    
    try:
        wget_stats = open(tmp_folder+file_name, 'r')
        wget_stats.close()
    except IOError:
        summaryExists = False
    
    if summaryExists:
        os.remove(tmp_folder+file_name)

    try:
        start = time.time()
        p = subprocess.Popen(['wget', '-'+str(ip_version), '--no-check-certificate', '--page-requisites',  '--delete-after', '-o', tmp_folder+file_name, target], stdout=subprocess.PIPE,  stderr=subprocess.PIPE)

        while p.poll() is None:
            time.sleep(2)
            if time.time()-start >= timeout:
                p.kill()
                wget_file = open(tmp_folder+file_name, 'w')
                wget_file.write('WGET Timeout')
                wget_file.close()

        p.communicate()
    except Exception as e:
        return e
    try:
        # Read WGET results
        raw, results, code = get_wget_results(tmp_folder+file_name)
        results_json['raw']     = raw
        results_json['code']    = code
        results_json['results'] = results
            
    except Exception as e:
        return e

    # Debug
    print(results_json)
    if 'raw' in results_json:
        print(results_json['raw'])

    # Remove result file and folder
    try:
        if os.path.exists(tmp_folder+file_name):
            os.remove(tmp_folder+file_name)
            os.rmdir(tmp_folder)
    except Exception as e:
        return e
    
    if 'results' in results_json:
        if 'speed_neto' in results_json['results'] and 'speed_bruto' in results_json['results']:
            return round(results_json['results']['speed_neto'],2), round(results_json['results']['speed_bruto'],2)
        
    return 'Error. Can not get speed results'


if __name__ == "__main__":
    print(web_speed("https://ci-cd-service.5gasp.eu/dashboard"))