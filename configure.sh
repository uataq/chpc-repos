#!/bin/bash
set -e

BACKUP_RANDOM=backup-$RANDOM

USER_CUSTOM_SH=${HOME}/.custom.sh
USER_CUSTOM_SH_BACKUP=${USER_CUSTOM_SH}.$BACKUP_RANDOM

USER_BASHRC=${HOME}/.bashrc
USER_BASHRC_BACKUP=${USER_BASHRC}.$BACKUP_RANDOM

R_MAKEVARS=$HOME/.R/Makevars

echo "Backing up $USER_BASHRC to $USER_BASHRC_BACKUP"
cp $USER_BASHRC $USER_BASHRC_BACKUP

if [[ -f $USER_CUSTOM_SH ]]; then
    echo "Backing up $USER_CUSTOM_SH to $USER_CUSTOM_SH_BACKUP"
    cp $USER_CUSTOM_SH $USER_CUSTOM_SH_BACKUP
fi

echo

while true; do
    read -p "Replace $USER_CUSTOM_SH (Y/n): " YN
    YN=${YN:-Y}
    case $YN in
    [Yy]*)
        [[ -f $USER_CUSTOM_SH ]] && rm $USER_CUSTOM_SH
        break
        ;;
    [Nn]*)
        break
        ;;
    *) echo "Please answer y or n" ;;
    esac
done

while true; do
    read -p "Reset $USER_BASHRC (Y/n): " YN
    YN=${YN:-Y}
    case $YN in
    [Yy]*)
        cp /uufs/chpc.utah.edu/sys/modulefiles/templates/bashrc $USER_BASHRC
        break
        ;;
    [Nn]*)
        break
        ;;
    *) echo "Please answer y or n" ;;
    esac
done

while true; do
    read -p "Reset $R_MAKEVARS (Y/n): " YN
    YN=${YN:-Y}
    case $YN in
    [Yy]*)
        [[ -f $R_MAKEVARS ]] && rm $R_MAKEVARS
        break
        ;;
    [Nn]*)
        break
        ;;
    *) echo "Please answer y or n" ;;
    esac
done

source $(dirname $BASH_SOURCE)/scripts/config.sh

echo "
# Source lin-group environment configuration
if [ -f "$CONFIG_FILENAME" ]; then
    source $CONFIG_FILENAME
fi
" >>$USER_CUSTOM_SH

echo
echo "Configuration complete! Log out and back in for changes to take effect."
