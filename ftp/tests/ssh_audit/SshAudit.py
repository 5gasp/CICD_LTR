# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-07 11:03:24
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-07 12:03:44

# Return Codes:
# 0 - Success (PASS)
# 1 - The audit has presented warnings (PASS)
# 2 - The audit has failed (FAIL)
# 3 - Host not acessible (FAIL)

import subprocess
import re


def check_errors(result_audit: dict):
    report_str = "SSH's Algorithms/Keys Validation Report:"
    print(report_str)
    for key, value in result_audit.items():
        for algorithm, validation in value.items():
            report_str += f"\n{validation} -> {algorithm}"
        if key == "fail":
            if any(result_audit[key]):
                print(report_str)
                return 2, f"The audit has failed:\n{report_str}\n"\
                    "If you wish to SOLVE THE ENCOUNTERED ISSUES, please "\
                    "visit: https://www.ssh-audit.com/hardening_guides.html"
        if any(result_audit[key]):
            print(report_str)
            return 1, f"The audit has presented warnings\n{report_str}\n"\
                "If you wish to SOLVE THE ENCOUNTERED ISSUES, please "\
                "visit: https://www.ssh-audit.com/hardening_guides.html"
    return 0, "Success"


# Run ssh-audit and capture its output
def test_ssh_audit(ssh_host, ssh_port=22):
    ansi_escape = re.compile(
        r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    try:
        cmd = ["ssh-audit", ssh_host, "-p", str(ssh_port)]
        response_ssh_audit = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if response_ssh_audit.returncode == 1:
            raise Exception("Host not acessible")
        response_ssh_audit = response_ssh_audit.stdout
        res = {"fail": {}, "warn": {}}
        for lines in response_ssh_audit.splitlines():
            new_lines = ansi_escape.sub('', lines)
            if "(" in new_lines and "#" not in new_lines\
            and "(nfo)" not in new_lines and "(gen)"\
            not in new_lines and "(fin)" not in new_lines:
                replace_lines = new_lines.replace("  ", "")
                key = replace_lines[:replace_lines.find("--")]
                value = new_lines[new_lines.find("--")+3:]
                if 'warn' in value:
                    res['warn'][key] = value
                if 'fail' in value:
                    res['fail'][key] = value
        return check_errors(res)
    except Exception as e:
        return 3, f"Host not acessible. Exception: {e}"
