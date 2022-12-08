#!/bin/bash
while true
do
	sh -c 'irtt client -i $IRTT_INTERVAL -d $IRTT_DURATION -l $IRTT_LENGTH --fill=rand --sfill=rand -o /tmp/results/irtt_data.json $IRTT_SERVER_IP & python3 /tmp/ntw-meas.py & wait'
	sh -c 'python3 /tmp/upload_files.py /tmp/results/irtt_data.json'
	sh -c 'python3 /tmp/upload_files.py /tmp/results/ntw_meas_data.json'
done
