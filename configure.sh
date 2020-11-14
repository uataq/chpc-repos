#!/bin/bash

BACKUP_RANDOM=backup-$RANDOM

USER_CUSTOM_SH=${HOME}/.custom.sh
USER_CUSTOM_SH_BACKUP=${USER_CUSTOM_SH}.$BACKUP_RANDOM
USER_CUSTOM_SH_TMP=${USER_CUSTOM_SH}.tmp

USER_BASHRC=${HOME}/.bashrc
USER_BASHRC_BACKUP=${USER_BASHRC}.$BACKUP_RANDOM

R_MAKEVARS=$HOME/.R/Makevars

echo "Backing up $USER_BASHRC to $USER_BASHRC_BACKUP"
cp $USER_BASHRC $USER_BASHRC_BACKUP

echo "Backing up $USER_CUSTOM_SH to $USER_CUSTOM_SH_BACKUP"
cp $USER_CUSTOM_SH $USER_CUSTOM_SH_BACKUP

echo

while true; do
    read -p "Replace $USER_CUSTOM_SH (Y/n): " YN
    YN=${YN:-Y}
    case $YN in
    [Yy]*)
        REPLACE_CUSTOM_SH=1
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

echo

source $(dirname $BASH_SOURCE)/scripts/config.sh

cp templates/custom.sh $USER_CUSTOM_SH_TMP

# Render template using environment variables defined in scripts/config.sh
sed -i".template.backup" -e "s|{{INCLUDE}}|$INCLUDE|g" $USER_CUSTOM_SH_TMP
sed -i".template.backup" -e "s|{{BIN}}|$BIN|g" $USER_CUSTOM_SH_TMP
sed -i".template.backup" -e "s|{{LIB}}|$LIB|g" $USER_CUSTOM_SH_TMP
sed -i".template.backup" -e "s|{{MKL_LIBRARY_PATH}}|$MKL_LIBRARY_PATH|g" $USER_CUSTOM_SH_TMP
sed -i".template.backup" -e "s|{{PKGCONFIG}}|$PKGCONFIG|g" $USER_CUSTOM_SH_TMP
sed -i".template.backup" -e "s|{{SHARE}}|$SHARE|g" $USER_CUSTOM_SH_TMP
rm ${USER_CUSTOM_SH_TMP}.template.backup

if [ $REPLACE_CUSTOM_SH ]; then
    mv $USER_CUSTOM_SH_TMP $USER_CUSTOM_SH
else
    cat $USER_CUSTOM_SH_BACKUP $USER_CUSTOM_SH_TMP >$USER_CUSTOM_SH
fi

echo
echo "Configuration complete! Log out and back in for changes to take effect."
