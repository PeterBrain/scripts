#!/usr/bin/env bash

#allow all cloudflare ips; add them to iptables
for cfip in `curl https://www.cloudflare.com/ips-v4`; do iptables -I INPUT -p tcp -s $cfip --dport http -j ACCEPT; done
for cfip in `curl https://www.cloudflare.com/ips-v4`; do iptables -I INPUT -p tcp -s $cfip --dport https -j ACCEPT; done

#allow all cloudflare ips; add them to ufw
#wget https://www.cloudflare.com/ips-v4 -O /tmp/ips-v4-$$.tmp
#wget https://www.cloudflare.com/ips-v6 -O /tmp/ips-v6-$$.tmp

#for cfip in `cat /tmp/ips-v4-$$.tmp`; do ufw allow from $cfip to any port 80,443 proto tcp comment 'Cloudflare IP'; done
#for cfip in `cat /tmp/ips-v6-$$.tmp`; do ufw allow from $cfip to any port 80,443 proto tcp comment 'Cloudflare IP'; done
