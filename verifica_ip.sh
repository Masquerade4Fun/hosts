#!/bin/bash

check_host_ip() {
    local name="$1"
    local ip="$2"
    local dns="$3"
    ##Masuqerade se uita la un smek
    real_ip=$(nslookup "$name" "$dns" 2>/dev/null | awk '/^Address: /{c++; if(c==1){print $2; exit}}')
    if [ -n "$real_ip" ] && [ "$real_ip" != "$ip" ]; then
        echo "Wrong IP for $name in /etc/hosts!"
    fi
}

cat /etc/hosts | while read -r ip name rest; do
    check_host_ip "$name" "$ip" "1.1.1.1"
done 
