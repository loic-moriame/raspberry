alias la='ls -A'
alias l='ls -CF'
alias mkcd='_(){ mkdir $1; cd $1; }; _'

#ll alias if "tree" already install or not
if [ -f /usr/bin/tree ]
then
    alias ll='tree -L 1'
else
    alias ll='ls -lF'
fi

