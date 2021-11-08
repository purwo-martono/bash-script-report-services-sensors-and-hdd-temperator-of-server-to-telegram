#!/bin/bash

## define it
ipAddress=$(hostname -I)
listService=("ufw" "ssh" "apache2" "php5.6-fpm" "postgresql" "smbd")
file="/home/ciptana/script/gadogado.txt"

## get length of $service array
len=${#listService[@]}

br=$'\n'
lines=""

## Use bash for loop
lines=$(for (( i=0; i<$len; i++ ));
    do
        status=$( systemctl is-active "${listService[$i]}")
        echo "${listService[$i]} $status";
    done
)
echo "========================" > "$file"
echo "HRMS - $ipAddress" >> "$file"
echo "------------------------" >> "$file"
echo "Service"$'\n'"$lines" >> "$file"
echo "========================" >> "$file"
liness=""
sensors | grep '^Core\s[[:digit:]]\+:' | (while read line;
do
  IN="$line"
  arrIN=(${IN/ /})
  liness+="${br}${arrIN[0]} ${arrIN[1]}"
done
echo "Sensors $liness")  >> "$file"
echo "========================" >> "$file"

#HDDTEMP
linesss=""
hddtemp /dev/sda | (while read line;
do
  IN="$line"
  arrIN=(${IN/:/})
  linesss+="${br}${arrIN[1]} ${arrIN[2]} "
done
echo "HddTemp $linesss")  >> "$file"
echo "========================" >> "$file"
