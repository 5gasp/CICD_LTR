import subprocess
import re

def run_hping(target_host, target_port, num_packets=10):
    try:
        # Run hping3 command
        command = f"hping3 -c {num_packets} {target_host} -p {target_port}"
        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, universal_newlines=True)

        # Parse the output
        parsed_output = parse_hping_output(output)

        return parsed_output
    except subprocess.CalledProcessError as e:
        print(f"Error running hping3: {e}")
        return None

def parse_hping_output(output):
    parsed_data = {
        "sent": None,
        "received": None,
        "loss": None,
        "min_rtt": None,
        "avg_rtt": None,
        "max_rtt": None,
    }

    # Regular expressions to extract relevant information from hping output
    sent_pattern = r"(\d+) packets transmitted"
    received_pattern = r"(\d+) packets received"
    loss_pattern = r"(\d+)% packet loss"
    rtt_pattern = r"min/avg/max = ([\d.]+)/([\d.]+)/([\d.]+) ms"

    # Extract data using regular expressions
    sent_match = re.search(sent_pattern, output)
    received_match = re.search(received_pattern, output)
    loss_match = re.search(loss_pattern, output)
    rtt_match = re.search(rtt_pattern, output)

    if sent_match:
        parsed_data["sent"] = int(sent_match.group(1))
    if received_match:
        parsed_data["received"] = int(received_match.group(1))
    if loss_match:
        parsed_data["loss"] = int(loss_match.group(1))
    if rtt_match:
        parsed_data["min_rtt"] = float(rtt_match.group(1))
        parsed_data["avg_rtt"] = float(rtt_match.group(2))
        parsed_data["max_rtt"] = float(rtt_match.group(3))

    return parsed_data

if __name__ == "__main__":
    target_host = "chat.openai.com"  # Replace with your target host
    target_port = 80            # Replace with your target port

    result = run_hping(target_host, target_port)
    if result:
        print("Hping Results:")
        print(f"Sent: {result['sent']} packets")
        print(f"Received: {result['received']} packets")
        print(f"Packet Loss: {result['loss']}%")
        print(f"Min RTT: {result['min_rtt']} ms")
        print(f"Avg RTT: {result['avg_rtt']} ms")
        print(f"Max RTT: {result['max_rtt']} ms")
