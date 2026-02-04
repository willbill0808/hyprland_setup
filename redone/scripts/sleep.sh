#!/bin/bash

echo sleep

killall -9 hyprlock

hyprlock & disown

sleep 3

systemctl suspend 