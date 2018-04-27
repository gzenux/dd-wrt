#!/usr/bin/env bash

if [ -n "$BASH_SOURCE" ]; then
	THIS_SCRIPT=$BASH_SOURCE
elif [ -n "$ZSH_NAME" ]; then
	THIS_SCRIPT=$0
else
	THIS_SCRIPT="$(pwd)/envsetup.sh"
fi
if [ -z "$ZSH_NAME" ] && [ "$0" = "$THIS_SCRIPT" ]; then
	echo "Error: This script needs to be sourced. Please run as '. $THIS_SCRIPT' <ProfileConfigFile>"
	exit 1
fi
if [ -z "$1" ] || [ ! -f "$1" ]; then
	echo "Error: <ProfileConfigFile> argument is required to setup the environment. Please run as '. $THIS_SCRIPT' <ProfileConfigFile>"
	return 1
fi

PrjDir=$(dirname "$THIS_SCRIPT")
PrjDir=$(readlink -f "$PrjDir")
PrjDir=$(dirname "$PrjDir")
Profile=$(dirname "$1")
Profile=$(readlink -f "$Profile")/$(basename "$1")
SrcDir=${PrjDir}/src/router
KernelDir=${PrjDir}/src/linux

# backup/restore PATH variable
[[ -z "$PATH_BACKUP" ]] && PATH_BACKUP=$PATH || PATH=$PATH_BACKUP

####################
# profile handling #
####################
# source profile settings
source $Profile || return

# required keys checking
ReqVarList="MAKEFILE ROUTER_CONFIG KERNEL_CONFIG KERNEL_PATH TOOLCHAIN_PATH"
MissVar=0
for var in $ReqVarList
do
	[[ -n "${!var}" ]] || { echo "Error: Required parameter '$var' not define!"; ((MissVar++)); }
done
[[ $MissVar = 0 ]] || return

# profile configs generating
# profile configs array
#declare -A CfgProf=()
# file => array converting
#while read line
#do
#	[[ -z "$(sed -e '/^.*#/d' -e '/^$/d' <<< $line)" ]] || {
#		line="$(sed -e 's:=.*$::g' <<< $line)"
#		CfgProf[$line]=${!line}
#	}
#done < $Profile

#########################
# environment preparing #
#########################
# prepare the environment configurations
echo $PATH | grep ${TOOLCHAIN_PATH}/bin > /dev/null 2>&1 || export PATH="$PATH:${TOOLCHAIN_PATH}/bin"
export TOOLCHAIN="$TOOLCHAIN_PATH"
[[ "$(readlink -f $SrcDir/Makefile)" = "$(readlink -f $MAKEFILE)" ]] || ln -sf "$(readlink -f $MAKEFILE)" "$SrcDir/Makefile"
[[ "$(readlink -f $SrcDir/.config)" = "$(readlink -f $ROUTER_CONFIG)" ]] || ln -sf "$(readlink -f $ROUTER_CONFIG)" "$SrcDir/.config"
[[ "$(readlink -f $KERNEL_PATH/.config)" = "$(readlink -f $KERNEL_CONFIG)" ]] || ln -sf "$(readlink -f $KERNEL_CONFIG)" "$KERNEL_PATH/.config"

# change dir into srouce root
cd ${SrcDir} > /dev/null

# unset variables in this script
#for key in ${!CfgProf[@]}; do unset $key; done
unset THIS_SCRIPT PrjDir Profile SrcDir KernelDir ReqVarList MissVar
