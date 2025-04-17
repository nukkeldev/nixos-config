#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
  wofi -f
else
  pkill wofi
fi   
