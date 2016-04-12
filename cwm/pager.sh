#!/bin/sh
#
# a script to provide a workspace switcher and menu for openbox (and others) using dzen2
# relies on xdotool

font='fixed:size=8'

x='25'
y='1030'
h='24'
w='205'


defaultBgC='#191919'
activeBgC='#656e72'
inactiveBgC='#191919'
activeFgC='#212629'
inactiveFgC='#656e72'


while : 
do
	one="^bg(${inactiveBgC})^fg(${inactiveFgC}) one ^bg(${defaultBgC})"
	two="^bg(${inactiveBgC})^fg(${inactiveFgC}) two ^bg(${defaultBgC})"
	three="^bg(${inactiveBgC})^fg(${inactiveFgC}) three ^bg(${defaultBgC})" 
	four="^bg(${inactiveBgC})^fg(${inactiveFgC}) four ^bg(${defaultBgC})"
        five="^bg(${inactiveBgC})^fg(${inactiveFgC}) five ^bg(${defaultBgC})"
	six="^bg(${inactiveBgC})^fg(${inactiveFgC}) six ^bg(${defaultBgC})"

	currentDesktop=`xprop -root | grep '_NET_CURRENT_DESKTOP(CARDINAL*' | awk -F= '{print $2}'`

	if [ ${currentDesktop} = 1 ]; then #first desktop is active, etc
		one="^bg(${activeBgC})^fg(${activeFgC}) one ^bg(${defaultBgC})"
	else
		if [ ${currentDesktop} = 2 ]; then 
			two="^bg(${activeBgC})^fg(${activeFgC}) two ^bg(${defaultBgC})"
		else
			if [ ${currentDesktop} = 3 ]; then 
				three="^bg(${activeBgC})^fg(${activeFgC}) three ^bg(${defaultBgC})"
			else
				if [ ${currentDesktop} = 4 ]; then 
					four="^bg(${activeBgC})^fg(${activeFgC}) four ^bg(${defaultBgC})"
	                    else
				 if [ ${currentDesktop} = 5 ]; then
                                        five="^bg(${activeBgC})^fg(${activeFgC}) five ^bg(${defaultBgC})"
				  else
                                 if [ ${currentDesktop} = 6 ]; then
                                        six="^bg(${activeBgC})^fg(${activeFgC}) six ^bg(${defaultBgC})"
                                fi


				fi

                             fi

			fi
		fi
	fi
	echo "${one}${two}${three}${four}${five}${six}"
	sleep 0.25

done | dzen2 -bg '#191919' -fn "$font" -x $x -y $y -h $h -w $w -e ''
