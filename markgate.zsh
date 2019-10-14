#!/bin/zsh

#--------------------#
# MARK FOLDERS CACHE #
#--------------------#{{{
MARKGATE_CACHE="$HOME/.cache/markgate.cache"
# }}}

#--------------#
# HELP DIALOG  #
#--------------#{{{
USAGE () {
echo "
MARK GATE
Written by Zakaria Barkouk (gitlab.com/zakariagtter)

Mark your directory's for Easy Access

OPTS :
 ga          Add Mark Directory
 gr          Remove Mark Directory
 gs          Show All Mark Directory's
 gj          Jumb To mark Directory
 ge          Change or Edit Exist mark

EXAMPLE :
 ga home     ( add 'home' Mark to corrent Directory )
 ga home ~   ( Add 'home' Mark to $HOME Directory )
 gj home     ( Jumb to 'home' Mark )
 gr home     ( Delete 'home' Mark and support multi Delete )
 ge home     ( Edit or Change Mark name or Directory )
"
}
# }}}

#-----------------#
# MAKE A NEW MARK #
#-----------------#{{{
ga(){
[ "$#" -gt 2 -o -z "$1" ] && USAGE

local name path check

name="${1}"			# mark name the first argument
path="${2:-$PWD}"   # make path the second argument
path="$path:P"

## start adding marks
# check if the mark already exist
check=$(awk '/^'"$name"' /' "$MARKGATE_CACHE")

if [ -z "$check" ]; then
    if [ -d "$path" ]; then
		echo -e "[+] - $name Added"
		echo -e "$name ; $path" >> "$MARKGATE_CACHE"
    else
		echo -e "[X] - $path no such directory"
    fi
else
    echo -e "[X] - $name mark alredy exist"
fi
}
# }}}

#---------------#
# REMOVE A MARK #
#---------------#{{{
gr(){
[ -z "$1" ] && USAGE

local check i

for i in $@; do
    #check if the mark exist
    check=$(awk '/^'"$i"' /' "$MARKGATE_CACHE")

    # remove the mark
    if [ -z "$check" ]; then
		echo -e "[X] - $i none exist mark"
    else
		sed -i "/^$i /d" $MARKGATE_CACHE
		echo -e "[-] - $i Deleted "
    fi
done
}
# }}}

#------------------#
# JUMB TO THE MARK #
#------------------#{{{
gj(){
[ -z "$1" ] && USAGE

local check path

# check if the mark exist
check=$(awk '/^'"$1"' /' "$MARKGATE_CACHE")

# jumb to mark
if [ -z "$check" ]; then
    echo -e "[X] - $1 none exist mark"
else
    path=$(awk -F ';' '/^'"$1"' /{print $2}' "$MARKGATE_CACHE")
    eval "cd $path"
fi

}
# }}}

#-----------------#
# SHOW EXIS MARKS #
#-----------------#{{{
gs(){
if [ -z "$1" ]; then
    column -t -s ';' "$MARKGATE_CACHE"
else
    for i in $@; do
		check=$(awk '/^'"$i"' /' "$MARKGATE_CACHE")

		if [ -z "$check" ]; then
			echo -e "[X] - $i None exist Mark"
		else
			echo -e "$check" | column -t -s ';'
		fi
    done
fi
}
# }}}

#------------------#
# EDIT EXIST MARKS #
#------------------#{{{
ge(){
[ "$#" -gt 1 -o -z "$1" ] && USAGE

local mark _mark_

# get the mark
mark=$(awk '/^'"$1"' /' "$MARKGATE_CACHE")

if [ -z "$mark" ]; then
    echo -e "[X] - $mark None exist Mark"
else
    # delete the mark
    sed -i "/$mark/d" $MARKGATE_CACHE

    # edit the mark with zle
    vared mark

    sed -i "/$mark/$_mark_" $MARKGATE_CACHE

    # rewrite the mark
    echo $mark >> "$MARKGATE_CACHE"
fi
}
# }}}

#---------------------------#
# AUTO COMPLITION  FOR ZSH  #
#---------------------------#{{{
function _markgate {
    if [[ "$(grep -c ".*" $MARKGATE_CACHE)" -gt 0 ]];then
		reply=($(awk -F ';' '{print $1}' "$MARKGATE_CACHE"))
    fi
}
# }}}

#----------------------#
# EXEC THE COMPLETION  #
#----------------------#{{{
compctl -K _markgate gj
compctl -K _markgate gr
compctl -K _markgate ge
compctl -K _markgate gs
#}}}
