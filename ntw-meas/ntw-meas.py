
import subprocess
import json
import time
import os
import sys

# example python3 ntw-meas.py 100s 400ms http://10.42.3.1:50000

def main():
    args_num = len(sys.argv)
    if args_num <= 3:
        print("no duration, sleep_time, or server address is provided")
        return

    duration_str = sys.argv[1]
    print(f"duration: {duration_str}")
    
    sleep_time_str = sys.argv[2]
    print(f"sleep time: {sleep_time_str}")

    server_addr = sys.argv[3]
    print(f"server address: {server_addr}")


    # example
    # duration_str = 100s
    # sleep_time_str = 400ms
    # should result:
    # duration = 100 # seconds
    # sleep_time = 0.4 # seconds

    seconds_per_unit = {"ms":0.001, "s": 1, "m": 60, "h": 3600, "d": 86400, "w": 604800}
    def convert_to_seconds(s):
        if s[-2:] == "ms":
            return float(s[:-2]) * seconds_per_unit[s[-2:]]
        else:
            return float(s[:-1]) * seconds_per_unit[s[-1]]

    duration = convert_to_seconds(duration_str)
    sleep_time = convert_to_seconds(sleep_time_str)

    meas_duration = 0
    meas_list = []
    t0 = time.time()
    while meas_duration < duration:
        t = time.time_ns()
        res = subprocess.check_output(["curl","-s", server_addr])
        res = res.decode('utf-8').strip()
        print(res)
        res = json.loads(res)
        res['timestamp'] = t
        meas_list.append(res)
        time.sleep(sleep_time)
        meas_duration = time.time()-t0

    print(meas_duration)

    for elem in meas_list:
        elem['RSRP'] = elem.pop('Signal Strength')
        elem['RSRQ'] = elem.pop('Signal Quality')
        new_RSRP = float(elem['RSRP'].split()[0])
        elem['RSRP'] = new_RSRP
        new_RSRQ = float(elem['RSRQ'].split()[0])
        elem['RSRQ'] = new_RSRQ

    with open("/tmp/results/ntw_meas_data.json", "w") as outfile:
        json.dump(meas_list, outfile)


main()
