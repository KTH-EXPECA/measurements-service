#!/bin/bash
irtt client -i $IRTT_INTERVAL -d $IRTT_DURATION -l $IRTT_LENGTH --fill=rand --sfill=rand -o $IRTT_OUTPUT $IRTT_SERVER_IP
