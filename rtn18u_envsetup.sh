#!/usr/bin/env bash

if [ -n "$BASH_SOURCE" ]; then
	THIS_SCRIPT=$BASH_SOURCE
elif [ -n "$ZSH_NAME" ]; then
	THIS_SCRIPT=$0
else
	THIS_SCRIPT="$(pwd)/rtn18u_envsetup.sh"
fi
if [ -z "$ZSH_NAME" ] && [ "$0" = "$THIS_SCRIPT" ]; then
	echo "Error: This script needs to be sourced. Please run as '. $THIS_SCRIPT'"
	exit 1
fi

PrjDir=$(dirname "$THIS_SCRIPT")
PrjDir=$(readlink -f "$PrjDir")
Profile=${PrjDir}/env/profile/rt-n18u.config
EvnSetup=${PrjDir}/env/envsetup.sh

[[ -f "$Profile" ]] || { echo "Error: $Profile not found!"; return 1; }
source $EvnSetup $Profile

# unset variables in this script
unset THIS_SCRIPT PrjDir Profile EvnSetup
