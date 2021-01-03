#!/bin/bash


if [ "$1" = "" ]; then
   echo -e "[INFO] You need to specify a proc net file !!"
   echo -e "[INFO] Example: ./hexToDec.sh /proc/net/tcp"
   exit
fi

FILE=$1
HEX_PORTS_LIST=$(cat $FILE | awk '{print $2}' | awk '{print $2}' FS=":" | sort -u)

for hex_port in $(echo $HEX_PORTS_LIST); do
	 counter=$(($counter+1))
     port=$(echo "obase=10; ibase=16; $hex_port" | bc)
     if [ $counter -eq 1 ]; then
        hex_list="${hex_port}"
        port_list="${port}"
     else
        hex_list="$hex_list,${hex_port}"
        port_list="$port_list,${port}"
     fi
done
echo -e "\nPORTS FOUND: $counter"
echo -e "[HEX PORTS] $hex_list"
echo -e "[DEC PORTS] $port_list\n"

#apt install xclip-y
echo "$port_list" | xclip -sel clip
echo -e "[OK] Decimal Ports has been copied to clipboard\n"
