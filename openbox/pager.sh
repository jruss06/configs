#!/bin/sh
#
# a script to provide a workspace switcher and menu for openbox (and others) using dzen2
# relies on xdotool

font='fixed:size=8'

x='0'
y='0'
h='24'
w='185'

menuButton='^ca(1,xdotool key ctrl+alt+q)menu^ca()'
oneButton='^ca(1,xdotool key super+1)one^ca()'
twoButton='^ca(1,xdotool key super+2)two^ca()'
threeButton='^ca(1,xdotool key super+3)three^ca()'
fourButton='^ca(1,xdotool key super+4)four^ca()'
fiveButton='^ca(1,xdotool key super+5)five^ca()'

defaultBgC='#191919'
activeBgC='#656e72'
inactiveBgC='#191919'
menuBgC='#6c8b9e'
activeFgC='#212629'
inactiveFgC='#656e72'
menuFgC='#212629'

menu="^bg(${menuBgC})^fg(${menuFgC}) ${menuButton} ^bg(${defaultBgC})"

while : 
do
	one="^bg(${inactiveBgC})^fg(${inactiveFgC}) ${oneButton} ^bg(${defaultBgC})"
	two="^bg(${inactiveBgC})^fg(${inactiveFgC}) ${twoButton} ^bg(${defaultBgC})"
	three="^bg(${inactiveBgC})^fg(${inactiveFgC}) ${threeButton} ^bg(${defaultBgC})" 
	four="^bg(${inactiveBgC})^fg(${inactiveFgC}) ${fourButton} ^bg(${defaultBgC})"
        five="^bg(${inactiveBgC})^fg(${inactiveFgC}) ${fiveButton} ^bg(${defaultBgC})"

	currentDesktop=`xprop -root | grep '_NET_CURRENT_DESKTOP(CARDINAL*' | awk -F= '{print $2}'`

	if [ ${currentDesktop} = 0 ]; then #first desktop is active, etc
		one="^bg(${activeBgC})^fg(${activeFgC}) ${oneButton} ^bg(${defaultBgC})"
	else
		if [ ${currentDesktop} = 1 ]; then 
			two="^bg(${activeBgC})^fg(${activeFgC}) ${twoButton} ^bg(${defaultBgC})"
		else
			if [ ${currentDesktop} = 2 ]; then 
				three="^bg(${activeBgC})^fg(${activeFgC}) ${threeButton} ^bg(${defaultBgC})"
			else
				if [ ${currentDesktop} = 3 ]; then 
					four="^bg(${activeBgC})^fg(${activeFgC}) ${fourButton} ^bg(${defaultBgC})"
	                    else
				 if [ ${currentDesktop} = 4 ]; then
                                        five="^bg(${activeBgC})^fg(${activeFgC}) ${fiveButton} ^bg(${defaultBgC})"
				fi

                             fi

			fi
		fi
	fi
	echo "${one}${two}${three}${four}${five}"
	sleep 0.25

done | dzen2 -bg '#191919' -fn "$font" -x $x -y $y -h $h -w $w -e ''
