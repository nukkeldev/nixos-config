#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
  wofi -fn
else
  pkill wofi
fi   
