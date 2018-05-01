#!/bin/bash

# Remove NTP and install Chrony for Amazon Time Sync
yum erase -y ntp*
yum install -y chrony
service chronyd start
chkconfig chronyd on
