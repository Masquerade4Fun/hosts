#!/bin/bash

cat /etc/hosts | while read -r ip name rest; do
    real_ip=$(nslookup "$name" 1.1.1.1 2>/dev/null | awk '/^Address: /{c++; if(c==1){print $2; exit}}')
    echo "real ip = $real_ip and ip = $ip"
    if [ -n "$real_ip" ] && [ "$real_ip" != "$ip" ]; then
        echo "Wrong IP for $name in /etc/hosts!"
    fi
done
