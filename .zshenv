if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH="${PATH}:$HOME/bin"
fi

export PATH="${PATH}:/opt/matlab/bin"
export PATH="${PATH}:/opt/jdownloader2"
export TERMCMD="st"
export EDITOR="vim"
export XILINXD_LICENSE_FILE='2100@srvlic-xilinx.bfh.ch'
