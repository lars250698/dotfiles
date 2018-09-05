#!/bin/bash
 
scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
# Uncomment next line for blur effect instead of pixelation
# This will take longer to lock!
convert /tmp/screen.png -blur 0x8 /tmp/screen.png
 
if [[ -f $HOME/.xlock/icon.png ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file ~/.xlock/icon.png | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
 
        convert /tmp/screen.png $HOME/.xlock/icon.png -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        echo "done"
    done
fi
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
# i3lock  -I 10 -d -e -u -n -i /tmp/screen.png
i3lock -e -n -i /tmp/screen.png --insidevercolor=00000000 --insidewrongcolor=00000000 --insidecolor=00000000 --ringvercolor=ffffffc0 --ringwrongcolor=ff0000ff --ringcolor=00000000 --linecolor=00000000 --keyhlcolor=fffffff0 --bshlcolor=ff2400f0 --separatorcolor=00000000 --wrongcolor=ff2400ff --verifcolor=50c878ff --timecolor=ffffffff --timepos="100:40" -k --datecolor=00000000 --veriftext="" --wrongtext="" --noinputtext="" --radius=$(($RX/2)) --ring-width=4 &
exit
