#!/bin/bash
set -e

# --- functions
unmount_blk () {
# Argument: \n separated list of blk devices
    echo -e "$1"
    local BLK_SEL  # stores the selected block device name
    BLK_SEL=$(echo "$1" \
        | dmenu -i -p "Which device would you like to unmount?" -l 5 \
        | awk '{print $1}')
    [ -z "$BLK_SEL" ] && exit 1 # exit if there is no selection
    # unmount and send notification
    STDE=$(udisksctl unmount -b $BLK_SEL 2>&1 >/dev/null) \
        && notify-send DMENU-UNMOUNT "successfully unmounted $BLK_SEL" \
        || notify-send -u critical DMENU-UNMOUNT "error while unmounting $BLK_SEL\n$STDE"
}

unmount_mtp () {
# Argument: \n separated list of mtp device paths
    echo -e "$1"
    local MTP_SEL  # stores the selected MTP device name
    MTP_SEL=$(echo "$1" \
        | dmenu -i -p "Which device would you like to unmount?" -l 5)
    STDE=$(fusermount3 -u $MTP_SEL 2>&1 >/dev/null) \
        && notify-send DMENU-UNMOUNT "successfully unmounted $MTP_SEL" \
        || notify-send -u critical DMENU-UNMOUNT "error while unmounting $MTP_SEL\n$STDE"
}


# --- main
MNTD_BLK_DEV=$(lsblk -rpo "name,type,size,mountpoint,label" \
    | awk -F "[ ]" '$2=="part"&&$4!="/"&&$4!~/SWAP/&&length($4)>1 \
    {printf "%s (%s) %s \n",$1,$3,$5}')

# check if simple-mtpfs entry is in /etc/mtab
MTP_DEVS=$(awk '/simple-mtpfs/{print $2}' /etc/mtab)
if [[ $MTP_DEVS ]]
then
    if [ -z "$MNTD_BLK_DEV" ]
    then
        # there is a mounted simple-mtpfs device
        unmount_mtp "$MTP_DEVS"
    else
        # there are both simple-mtpfs and regulalr devices mounted
        # ask which device it is to unmount
        case $(echo -e "BlockDevice\nSmartPhone" | dmenu -i -p "What would you like to unmount?") in
            "BlockDevice")
                unmount_blk "$MNTD_BLK_DEV"
                ;;
            "SmartPhone")
                unmount_mtp "$MTP_DEVS"
                ;;    
        esac
    fi
else
    if [ -z "$MNTD_BLK_DEV" ]
    then
        # there are neither block devices nor smart phones to unmount
        notify-send DMENU-UNMOUNT "There are no devices to unmount"
    else
        # there are block devices to unmount
        unmount_blk "$MNTD_BLK_DEV"
    fi
fi
