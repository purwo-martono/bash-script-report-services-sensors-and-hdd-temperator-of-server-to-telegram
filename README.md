# Bash script to report services, sensors, and HDD temperature of your server to [Telegram](https://web.telegram.org/)

### Modification of telegram-send from [Konstantin Bogomolov](https://bogomolov.tech/Telegram-notification-on-SSH-login/)

### Don't forget to create [telegram-send](https://github.com/purwo-martono/telegram-send) file first

This bash script will check your services, sensors, and HDD temperature of your server and report to [Telegram](https://web.telegram.org/) in single chat.

In this example I use Ubuntu Server 16.04 (yes, i know T_T)

Install sensors and hddtemp if you dont have it yet
```
$ apt-get install lm-sensors hddtemp
```

Create bash script to check services, get processors and HDD temperature
```
#!/bin/bash

## define it
ipAddress=$(hostname -I)
listService=("ufw" "ssh" "apache2" "php5.6-fpm" "postgresql" "smbd")
file="/YOUR/PATH/OF/FILE/SHOULD/BE/HERE.txt"

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
echo "SERVER - $ipAddress" >> "$file"
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
```
