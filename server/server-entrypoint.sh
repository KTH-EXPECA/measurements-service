#!/bin/bash

sh -c 'irtt server -i $IRTT_INTERVAL -d $IRTT_DURATION -l $IRTT_LENGTH --fill=rand --sfill=rand -b $IRTT_BIND_ADDR'
