


import subprocess
import re

def ssh_bruteforce(user, pass_file, ip):
	try:
		founds_hosts = []
		cmd = [
				"hydra",
				"-l",
				str(user),
				"-P",
				str(pass_file),
				str(ip),
				"ssh"
		]
		response_hydra = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
	    	timeout=30
        )
		if response_hydra.returncode == 255:
			error_msg = ""
			for l in response_hydra.stderr.splitlines():
				if "ERROR" in l:
					error_msg += f"\n\t-> {l}"
			raise Exception(error_msg)
		stdout_lines = response_hydra.stdout.splitlines()
		stdout_lines = [
			line.strip() for line in stdout_lines
		  	if len(line)>0
		]
		for line in stdout_lines:
			res = re.search(r"^\[22\]\[ssh\]", line)
			if res:
				founds_hosts.append(line)
		if not founds_hosts:
			return 1, f"No valid password were found: {stdout_lines[-2]}"
		else:
			matches_str = "Error. Matches were found:"
			for host in founds_hosts:
				matches_str += f"\n\t-> {host}"
			return 2, matches_str
	except subprocess.TimeoutExpired:
		return 3, "There was a timeout running the test"
	except Exception as e:
		return 4, f"An error occured. Exception {e}"


if __name__ == "__main__":
	print(ssh_bruteforce(
		user="ubunt",
		pass_file="password_small_2.lst",
		ip="10.0.30.10asd8"
	))
