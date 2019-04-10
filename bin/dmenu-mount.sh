#!/bin/bash
set -xe

# --- Functions
mount_blk () {
    local BLK_SEL  # stores the selected block device name
    BLK_SEL=$(echo "$1" \
        | dmenu -i -p "Which device would you like to mount?" -l 5 \
        | awk '{print $1}')
    [ -z "$BLK_SEL"  ] && exit 1  # exit it there is no selection
    # mount and send notification
    st -c floatingSt -e udisksctl mount -b $BLK_SEL \
        && notify-send -t 10000 DMENU-MOUNT "successfully mounted $BLK_SEL to \n$(lsblk -rpo "name,mountpoint" | grep $BLK_SEL | awk '{print $2}')" \
        || notify-send -u critical DMENU-MOUNT "error while mounting device"
}

mount_mtp () {
    local MTP_SEL # stores the selected MTP device number
    MTP_SEL=$(echo "$1" \
        | dmenu -i -p "Which device would you like to mount?" \
        | awk -F ":" '{print $1}')
    [ -z "$MTP_SEL" ] && exit 1
    MNT_DIR=$(echo "/mnt/android" | dmenu -i -p "Where would you like to mount?") 
    # mount with simple-mtpfs, capture stderr
    STDE=$(simple-mtpfs --device $MTP_SEL $MNT_DIR \
        2>&1 >/dev/null) \
        && notify-send -t 10000 DMENU-MOUNT "Device $(simple-mtpfs -l --device $MTP_SEL) successfully mounted in $MNT_DIR." \
        || notify-send -u critical DMENU-MOUNT "error mounting MTP device:\n$STDE"
}

# --- main
udevadm settle  # handle all udev events first
BLK_DEVS=$(lsblk -rpo "name,type,size,mountpoint,label" \
    | awk -F "[ ]" '$2=="part"&&$4=="" \
    {printf "%s (%s) %s \n",$1,$3,$5}')
MTP_DEVS=$(simple-mtpfs -l 2>/dev/null)||:

MODE=$(echo -e "USB\nLocal\nSmartPhone" | dmenu -i -p "What would you like to mount?")
case $MODE in
    "USB") 
        mount_blk "$(sed '/sda/d' <<< "$BLK_DEVS")"
        ;;
    "Local") 
        mount_blk "$(grep sda <<< "$BLK_DEVS")"
        ;;
    "SmartPhone") 
        mount_mtp "$MTP_DEVS"
        ;;
esac
