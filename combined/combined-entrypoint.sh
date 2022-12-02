#!/bin/bash
while true
do
	sh -c 'irtt client -i 10ms -d 100s -l 172 --fill=rand --sfill=rand -o /tmp/results/irtt_data.json 10.99.99.3 & python3 /tmp/ntw-meas.py & wait'
	sh -c 'python3 upload_files.py /tmp/results/irtt_data.json'
	sh -c 'python3 upload_files.py /tmp/results/ntw_meas_data.json'
done
