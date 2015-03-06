#!/bin/bash
#baraction.sh for spectrwm status bar

SLEEP_SEC=5
#loops forever outputting a line every SLEEP_SEC secs
while :; do

	CPUFREQ_STR=`echo "Freq:"$(cat /proc/cpuinfo | grep 'cpu MHz' | sed 's/.*: //g; s/\..*//g;')`
	CPULOAD_STR="Load:$(uptime | sed 's/.*://; s/,//g')"

	eval $(awk '/^MemTotal/ {printf "MTOT=%s;", $2}; /^MemFree/ {printf "MFREE=%s;",$2}' /proc/meminfo)
	MUSED=$(( $MTOT - $MFREE ))
	MUSEDPT=$(( ($MUSED * 100) / $MTOT ))
	MEM_STR="Mem:${MUSEDPT}%"
        
	WLANINFO=$(iwconfig wlp8s0 | grep Bit | cut -c11-28)

	MTITLE=$(playerctl metadata title)
	MARTIST=$(playerctl metadata artist) 	

	echo -e " $CPUFREQ_STR  $CPULOAD_STR  $MEM_STR  $WLANINFO  Rhythmbox: $MTITLE - $MARTIST"

	sleep $SLEEP_SEC
done
