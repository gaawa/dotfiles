#!/bin/zsh
set -e

VIVADO="Vivado Integrated Development Environment"
XSDK="Xilinx Software Development Kit"
DOCNAV="Xilinx Documentation Navigator"
SEL="$VIVADO\n$XSDK\n$DOCNAV"

CHOICE=$(echo "$SEL" | dmenu -i -p "Launch Selection" -l 3)
case $CHOICE in
    "$VIVADO")
        echo $VIVADO
        unset LANG && unset QT_PLUGIN_PATH && source /opt/Xilinx/Vivado/2018.3/settings64.sh && vivado
        ;;
    "$XSDK")
        echo $XSDK
        unset LANG && unset QT_PLUGIN_PATH && source /opt/Xilinx/SDK/2018.3/settings64.sh && xsdk
        ;;
    "$DOCNAV")
        echo $DOCNAV
        # libpng12 is needed for the docnav
        /opt/Xilinx/DocNav/docnav
        ;;
esac
