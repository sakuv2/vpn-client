
FROM ubuntu:trusty

ENV VPN_INTERFACE_NAME vpn0

WORKDIR /usr/local/vpnclient

RUN apt-get update &&\
    apt-get -y -q install gcc make wget && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
    wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.28-9669-beta/softether-vpnclient-v4.28-9669-beta-2018.09.11-linux-x64-64bit.tar.gz -O /tmp/softether-vpnclient.tar.gz &&\
    tar -xzvf /tmp/softether-vpnclient.tar.gz -C /usr/local/ &&\
    rm /tmp/softether-vpnclient.tar.gz &&\
    make i_read_and_agree_the_license_agreement &&\
    apt-get purge -y -q --auto-remove gcc make wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/dhcp/dhclient-enter-hooks.d/resolvconf ; \
    rm -f /etc/dhcp/dhclient-exit-hooks.d/resolvconf

ENV ACCOUNT="private" \
    NICNAME="vpn0" \
    VPN_SERVER="IP_Adress:5555" \
    HUB_NAME="VPN" \
    VPN_USERNAME="DefaultUser" \
    VPN_PASSWORD="DefaultPassword" \
    IP="DHCP"

COPY start.sh /tmp/

ENTRYPOINT ["/tmp/start.sh"]