#!/bin/bash

echo $$ > ~/ownscripts/drink.pid
while true; do
	echo "-------------$(date +%T)--------------"
	echo "---------DRINK---------------------"
	echo "-------------->WATER---------------"
	echo "-----------------------------------"
	notify-send "Drink water! 💧"
	sleep 900
done
