#!/usr/bin/env sh

killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar1 &
  done
else
  polybar --reload example &
fi


#polybar bar1 &
#echo "Bar launched..."
