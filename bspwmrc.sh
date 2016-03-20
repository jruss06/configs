
#! /bin/sh


sxhkd &

bspc config border_width        2
bspc config window_gap         12

bspc config left_padding 15
bspc config right_padding 15

bspc config split_ratio         0.52
bspc config borderless_monocle  true
bspc config gapless_monocle     true
bspc config focus_by_distance   true

bspc monitor -d main www term files chat gimp other

bspc rule -a Gimp desktop=^8 follow=on state=floating
bspc rule -a Chromium desktop=^2
bspc rule -a mplayer2 floating=on
bspc rule -a Kupfer.py focus=on
bspc rule -a Screenkey manage=off
bspc rule -a Steam state=floating

bspc config focused_border_color "#FF7260"
bspc config normal_border_color "#FFFFFF"

bspc config focus_follows_pointer true


tint2 &
volumeicon &
nm-applet &
compton &
~/Public/panel &
nitrogen --restore &
xscreensaver -no-splash &
lxpolkit &

