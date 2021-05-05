#!/bin/bash

sudo echo '/media   /etc/auto.ext-usb --timeout=10,defaults,user,exec,uid=1000' >> /etc/auto.master
sudo cp auto.ext-usb /etc/auto.ext-usb && chmod 644 /etc/auto.ext-usb && chown root /etc/auto.ext-usb
sudo systemctl restart autofs
