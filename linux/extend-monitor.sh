#!/bin/bash
#xrandr sets screen1(HDMI) resolution and extends the desktop to the screen2(VGA) and its resolution
xrandr --output HDMI1 --mode 1600x900 --output VGA1 --mode 1440x900 --right-of HDMI1 

