# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-08 16:14:47
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-08 16:14:55

import subprocess
import re

# Return Codes:
# 0 - Success (PASS)
# 1 - The audit reavealed that the TLS configuration is not compliant, but in 
# the context of 5GASP, the non-compliant characteristics are not required
# 2 - The audit reavealed that the TLS configuration is not compliant (FAIL)
# 3 - No audit results were gathered (FAIL)
# 4 - Other error

# 
# Run ssh-audit and capture its output
def ssl_audit(url):

    try:
        cmd = ["sslyze", url]
        response_sslyze = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )    
        
        # get output
        stdout_lines = response_sslyze.stdout.splitlines()
        
        # Get the compliance report against mozilla's directives
        compliance_info = None
        for i in range(len(stdout_lines)-1, 0, -1):
            if "COMPLIANCE AGAINST MOZILLA TLS" in stdout_lines[i]:
                compliance_info = stdout_lines[i+2:]
                break
        
        # in the case there is no report
        if not compliance_info:
            print(response_sslyze.stdout)
            return 3, "No audit results were gathered!"
            
        # clease compliance report
        compliance_info = [
            l.strip() for l in compliance_info 
            if 
                len(l)>0 
                and "Checking results against Mozilla's" not in l
            ]
        
        # 1. Check if successfull according to mozilla's directives
        if re.search(rf"^{url}.* OK - Compliant.$", compliance_info[-1]):
            print(response_sslyze.stdout)
            return 0, f"\nResult: {compliance_info[-1]}"
            
        # 2. Even if not compliant with mozilla's directive, the SSL analysis 
        # may still be successful. There is a collection of compliance rules 
        # that can be ignored
        compliance_errors = []
        ignore_compliance_errors_regexes = [
            r"^\* certificate_hostname_validation:.*"
        ]

        # First, check if there was an error
        if len(compliance_info)==1\
        and re.search(rf"^{url}.* ERROR -.*", compliance_info[0]):
            compliance_errors.append(compliance_info[0])
        else:
            for i in range(1, len(compliance_info)):
                match_ignore_rule = False
                for ignore_regex in ignore_compliance_errors_regexes:
                    if re.search(ignore_regex, compliance_info[i]):
                        match_ignore_rule = True
                        break
                if not match_ignore_rule:
                    compliance_errors.append(compliance_info[i][2:])

        # If there are compliancy errors, even after applying the ignore rules       
        if len(compliance_errors) != 0:
            error_str = f"RESULT: {compliance_info[0]}"
            error_str += "\nERRORS:"
            for error in compliance_errors:
                error_str+=(f"\n\t-> {error}")

            # Print results
            print(response_sslyze.stdout)            
            return 2, error_str
        
        # Test
        print(response_sslyze.stdout)
        result = compliance_info[0]\
            .replace('Not compliant', 'Compliant with 5GASP requirements')\
            .replace('FAILED', 'OK')
        return 1, f"\nResult: {result}"
    except Exception as e:
        return 4, f"An error occured. Exception {e}"