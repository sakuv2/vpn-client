#!/bin/sh

/usr/local/vpnclient/vpnclient start

/usr/local/vpnclient/vpncmd localhost /CLIENT /CMD NicCreate $NICNAME

# アカウント作成
/usr/local/vpnclient/vpncmd localhost /CLIENT /CMD AccountCreate $ACCOUNT \
  /SERVER:$VPN_SERVER \
  /HUB:$HUB_NAME \
  /USERNAME:$VPN_USERNAME \
  /NICNAME:$NICNAME

# アカウントパスワード設定
/usr/local/vpnclient/vpncmd localhost /CLIENT /CMD AccountPasswordSet $ACCOUNT \
  /PASSWORD:$VPN_PASSWORD \
  /TYPE:standard

# アカウント接続
/usr/local/vpnclient/vpncmd localhost /CLIENT /CMD AccountConnect $ACCOUNT

sleep 3

if [ $ADDR_IP = "DHCP" ]; then
    echo 'DHCPでIPを割り当てます'
    dhclient vpn_$NICNAME
    echo 'IPを'$ADDR_IP'に割り当てました'   
else
    echo 'IPを'$ADDR_IP'に割り当てます'
    ip addr add $ADDR_IP dev vpn_$NICNAME
    echo '割り当てました'
fi

tail -f /dev/null