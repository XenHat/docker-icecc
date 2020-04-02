#!/bin/bash
set -e
# Gentoo is buggy; this needs to be attempted twice to succeed in a container.
# I have no idea why.
if [ "$ICECC_ENABLE_SCHEDULER" == "1" ]; then
	/usr/sbin/icecc-scheduler -d -vvv -l /tmp/icecc-scheduler.log || true
	sleep 2; killall -s9 -r icecc-scheduler || true
	/usr/sbin/icecc-scheduler -d -vvv -l /tmp/icecc-scheduler.log
fi
ICECC_DEBUG="debug"
# /usr/sbin/iceccd -vvv
/usr/sbin/iceccd -vvv || true
sleep 2; killall -s9 -r iceccd || true
/usr/sbin/iceccd -vvv

