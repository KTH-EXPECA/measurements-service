#!/bin/bash

# ENV Vars example:
# AUTH_SERVER=10.0.87.254,AUTH_PROJECT_NAME=openstack,AUTH_USERNAME=admin,AUTH_PASSWORD=wcXLR6yAZ6mya79vi1BkjtIkONHyZqO9kJg0tYOp,IRTT_INTERVAL=10ms,IRTT_DURATION=3600s,IRTT_LENGTH=172,IRTT_SERVER_IP=10.99.99.3,MEAS_SERVER_ADDR=http://10.42.3.1:50000,SWIFT_CONTAINER=students-project

while true
do
	sh -c 'irtt client -i $IRTT_INTERVAL -d $IRTT_DURATION -l $IRTT_LENGTH --fill=rand --sfill=rand -o /tmp/results/irtt_data.json $IRTT_SERVER_IP & python3 /tmp/ntw-meas.py $IRTT_DURATION 400ms $MEAS_SERVER_ADDR & wait'
	sh -c 'python3 /tmp/upload_files.py /tmp/results/irtt_data.json $SWIFT_CONTAINER'
	sh -c 'python3 /tmp/upload_files.py /tmp/results/ntw_meas_data.json $SWIFT_CONTAINER'
done
