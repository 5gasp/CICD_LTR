



import subprocess
import json
import re
import os


def check_errors(result_audit: dict):
    
    for key, value in result_audit.items():
        if key == "fail":
            if any(result_audit[key]):
                return 3, f"The audit has failed {result_audit[key]}"
        if any(result_audit[key]):
            return 2, f"The audit has presented warnings {result_audit[key]}"
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
        return 4, "Host not acessible"
    