#!/bin/bash
#
# networktester.sh
# 		script that uses tcptraceroute to test a network for 24h
# 		inspired from tcpping by Richard van den Berg
#			(http://www.vdberg.org/~richard/tcpping.html)
#		
#	usage: ./networktester.sh <host> <port>
#
#	(c) 2015 Joao Godinho
#
#	2015/02/12 v1.0 initial version

ver="v1.0"
ttl=255
dateFormat="%s"
interval=1
req=$(expr 60 / ${interval} \* 60 \* 24)

runTrace() {
	tstamp=$(date +$dateFormat)
	ttl=$(tcptraceroute -f 255 -m 255 -q 1 $1 $2 2>/dev/null | sed 's/.*]\s\+//g')
	echo "$seq $tstamp $ttl"
}

echo "# Running for $req times."

for (( seq=0; seq<=$req-1; seq++ ))
do
	runTrace $1 $2 &
	sleep $interval
done

echo "# Test complete"
