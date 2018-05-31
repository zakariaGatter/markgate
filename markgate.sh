#!/bin/bash 

# config Folder 
CONF_DIR="$HOME/.config"

# file name in config dir 
DIR_GATE="$CONF_DIR/dir_gate"

# create dir file if its not exist
[ -f "$DIR_GATE" ] || touch "$DIR_GATE"

# Set Text editor 
[ -z "$EDITOR" ] && EDITOR="vim"

# Version 
_VERSION_="29/04/2018"

# Help Dialog 
USAGE () {
echo "
        MARK GATE ($_VERSION_)
        Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

        Mark your directory's for Easy Access

OPTS    :       
        ga          Add Mark Directory
        gr          Remove Mark Directory 
        gs          Show All Mark Directory's
        gj          Jumb To mark Directory
        ge          Change or Edit Exist mark

EXAMPLE :   
        ga home     ( add 'home' Mark to corrent Directory)
        ga home ~   ( Add 'home' Mark to $HOME Directory)
        gj home     ( Jumb to 'home' Mark)
        gr home     ( Delete 'home' Mark and suport multi Delete )
        ge home     (Edit or Change Mark name or Directory)

File    :   DIR_GATE=\"~/.config/dir_gate\"
"
}

# Change or Edit Exist mark 
ge () {
    [ "$1" = "help" -o -z "$1" ] && { USAGE && return 0 }

E_CHECK=$(grep --color=never -w "^$1" $DIR_GATE)

if [ -z "$E_CHECK" ]; then 
    echo "X - [ $1 ] dosen't Exist"
else
    echo "$E_CHECK" > /tmp/dir_edit
    
    bash -c "$EDITOR /tmp/dir_edit"

    sed -i "s:$E_CHECK::g" $DIR_GATE

    cat /tmp/dir_edit >> $DIR_GATE
fi

unset E_CHECK 
}

# Add new mark 
ga () {
    [ "$#" -gt "2" ] && { echo "Wrong argument(s), please see help for more information" && return 0 }
    [ "$1" = "help" -o -z "$1" ] && { USAGE && return 0 }

[ -d "$1" ] && { echo "X - Give the Mark Name first , please see help for more information " && return 1 } ||{
    [ -n "$2" ] && {
        _CHECK_=$(grep --color=never -w "^$1" $DIR_GATE )

        [ -n "$_CHECK_" ] && { echo "X - [ $1 ] Alredy Exist " && return 1 } || {
            [ -d "$2" ] && {
                _DIR_=$(echo "$2" | sed "s:$HOME:~:") 

                echo "$1 = $_DIR_" >> $DIR_GATE

                echo "[ $1 ] Added "
            }||{
                echo " Invalid or None Exist Directory"
                return 1
            }
        }
} || {
    _CHECK_=$(grep -w --color=never "^$1" $DIR_GATE )

    [ -n "$_CHECK_" ] && { echo "X - [ $1 ] Alredy Exist " && return 1 } || {
        _DIR_=$(dirs) 

        echo "$1 = $_DIR_" >> $DIR_GATE

        echo "[ $1 ] Added "
    }
}
}

unset _CHECK_ _DIR_ 
}

# Remove a dir 
gr () {
[ "$1" = "help" ] && { USAGE && return 0 }

D_GR=0
for D in ${@} ; do 
    D_CHECK_=$(grep -w --color=never "^$D" $DIR_GATE )

    [ -z "$D_CHECK_" ] && {
        echo "X - [ $D ] dosen't Exist "
        D_GR=$(( $D_GR +1 ))
    } || {
        sed -i "/^$D = */d" $DIR_GATE
        echo "[ $D ] Deleted "
    }
done 

[ "$D_GR" -eq 0 ] || return 1

unset D_GR D_CHECK_ 
}

# Show dir marks 
gs () {

[ -n "$1" ] && { USAGE && return 0}

echo "Marks :"
cat $DIR_GATE | column -t | sort -u
}

# dir Jumb
gj () {
[ "$1" = "help" -o -z "$1" ] && { USAGE && return 0 }
[ "$#" -gt 1 ] && {echo "Wrong argument(s), please see help for more information" && return 1}

J_CHECK=$(grep -w --color=never "^$1" $DIR_GATE)

[ -z "$J_CHECK" ] && {
    echo "X - [ $1 ] dosen't Exist " && return 1
} || {
    JUB_DIR=$(grep -w --color=never "$1" $DIR_GATE | cut -d " " -f3- | sed 's:^~:'"$HOME"':');

    cd $JUB_DIR

unset JUB_DIR J_CHECK 
}
}

# AUTO COMPLITION  for zsh 
function _complete_zsh {
    if [[ "$(cat "${DIR_GATE}" | wc -l)" -gt 0 ]];then 
	reply=($(cut -d= -f1 $DIR_GATE))
    fi
}

# Auto completion for bash 
function _complete_bash {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "$(cut -d= -f1 $DIR_GATE)" -- $curw))
    return 0
}

#exec the completion 
if [ $ZSH_VERSION ]; then
    compctl -K _complete_zsh gj
    compctl -K _complete_zsh gr
    compctl -K _complete_zsh ge
else
    shopt -s progcomp
    complete -F _complete_bash gj
    complete -F _complete_bash gr
    complete -F _complete_bash ge
fi
