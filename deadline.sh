#!/bin/bash

paces=(8 12 15 18 22 24)

declare -A milestone_days=(
	[0]="8 13 18 24 30 45"
	[1]="32 48 60 72 88 118"
	[2]="54 81 101 121 148 178"
	[3]="90 134 168 201 246 306"
	[4]="141 211 264 316 387 447"
	[5]="212 318 398 478 584 644"
	[6]="244 365 457 548 670 730"
)

usage() {
	echo "Usage: $0 [start_date] [pace]"
	echo "  start_date: Optional day before the start date in YYYY-MM-DD format for correct Hive Milestone Deadline calculation (defaults to hivers 7)"
	echo "  pace: Optional pace in months (8, 12, 15, 18, 22, or 24)"
	exit 1
}

# Default arguments, hivers 7
start_date=2024-10-27
selected_pace=""

# Check arguments
case $# in
	0)  # No arguments, use defaults
		;;
	1)  # One argument could be either a date or a pace
		if [[ $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
			start_date=$1
		elif [[ " ${paces[@]} " =~ " $1 " ]]; then
			selected_pace=$1
		else
			usage
		fi
		;;
	2)  # Two arguments: date and pace
		if [[ ! $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
			usage
		fi
		if [[ ! " ${paces[@]} " =~ " $2 " ]]; then
			usage
		fi
		start_date=$1
		selected_pace=$2
		;;
	*)  # Too many arguments
		usage
		;;
esac

echo "Starting from: $start_date"
if [ -n "$selected_pace" ]; then
	echo "Showing calculations for ${selected_pace}-month pace only"
fi
echo

for milestone in {0..6}; do
	echo "Milestone $milestone:"
	echo "-------------"
	
	for i in "${!paces[@]}"; do
		pace=${paces[$i]}
		
		if [ -n "$selected_pace" ] && [ "$pace" != "$selected_pace" ]; then
			continue
		fi
		
		echo "Pace $pace months:"
		
		days=$(echo ${milestone_days[$milestone]} | cut -d' ' -f$((i+1)))
		
		target_date=$(date -d "$start_date + $days days" +%Y-%m-%d)
		echo "  $days days = $target_date"
	done
	echo
done
