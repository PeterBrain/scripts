#!/usr/bin/env bash

#
# Install VMware tools first
# Virtual Machine Library -> (Top Menu) Virtual Machine -> Install VMware Tools
#

cd /Library/Application\ Support/VMware\ Tools/ || exit
# ./vmware-resolutionSet <width> <height>
./vmware-resolutionSet 1920 1200
#./vmware-resolutionSet 2048 1280
#./vmware-resolutionSet 2560 1600
#./vmware-resolutionSet 2880 1800
