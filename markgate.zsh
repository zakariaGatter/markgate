#!/bin/env zsh

#-------------#
# CACHE FILE  #
#-------------#{{{
_mg_cache_="$HOME/.cache/markgate"
#}}}

#-------------#
# HELP DIALOG #
#-------------#{{{
_markgate_help_(){
cat <<- HELP
[MARKGATE] Mark your directory's for Easy Access

OPTS :
 ga         Add Mark Directory
 gr         Remove Mark Directory
 gj         Jumb To mark Directory
 gs         Show All Mark Directory's
 ge         Change or Edit Exist mark

EXAMPLE :
 ga home     ( add 'home' Mark to corrent Directory )
 ga home ~   ( Add 'home' Mark to $HOME Directory )
 gj home     ( Jumb to 'home' Mark )
 gr home     ( Delete 'home' Mark and support multi Delete )
 ge home     ( Edit or Change Mark name or Directory )
HELP
}
#}}}

#--------------#
# ADD NEW MARK #
#--------------#{{{
ga(){
[ -z "${1}" -o "${#}" -gt 2 ] && { _markgate_help_ && return 0 ;}

local _name_=${1}
local _path_=${2:-${PWD/$HOME/\~}}

local _check_=$(\grep "^$_name_ " $_mg_cache_ 2> /dev/null)

[ "$_check_" ] && {
    echo -e "[X] $_name_: Already exist " >&2
} || {
    echo -e "$_name_ ; $_path_" >> "$_mg_cache_"
    echo -e "[+] $_name_: Added" >&2
}
}
#}}}

#--------------#
# REMOVE MARKS #
#--------------#{{{
gr(){
[ "${1}" ] || { _markgate_help_ && return 0 ;}

local _name_=${1}

for i in $@ ; do
    local _check_=$(\grep "^$i " $_mg_cache_ 2> /dev/null)

    [ "$_check_" ] && {
        \sed -i "/^$i /d" $_mg_cache_
        echo -e "[-] $_name_: Removed" >&2
    } || {
        echo -e "[X] $_name_: No mark exist " >&2
    }
done
}
#}}}

#--------------#
# JUMB TO MARK #
#--------------#{{{
gj(){
[ "${#}" -gt 1 -o -z "$1" ] && { _markgate_help_ && return 0 ;}

local _name_=${1}
local _check_=$(\grep "^$_name_ " $_mg_cache_ 2> /dev/null)
local _path_=$(\grep "^$_name_ " $_mg_cache_ 2> /dev/null | \cut -d " " -f3-)

[ "$_check_" ] && {
    \builtin cd -- $_path_ &> /dev/null || echo -e "[X] $_path_: no such file or directory" >&2
} || {
    echo -e "[X] $_name_: No mark exist " >&2
}
}
#}}}

#-------------#
# SHOW MARKS  #
#-------------#{{{
gs(){
local _name_=${1}

[ "$_name_" ] && {
    local _check_=$(\grep "^$_name_ " $_mg_cache_ 2> /dev/null)

    [ "$_check_" ] && {
        echo -e "$_check_" | \column -t -s ";"
    } || {
        echo -e "[X] $_name_: No mark exist " >&2
    }
} || {
    \column -t -s ";" $_mg_cache_
}
}
#}}}

#-----------#
# MARK EDIT #
#-----------#{{{
ge(){
[ -z "${1}" -o "${#}" -gt 1 ] && { _markgate_help_ && return 0 ;}

local _name_=${1}
local _check_=$(\grep "^$_name_ " $_mg_cache_ 2> /dev/null)

[ "$_check_" ] && {
    \sed -i "/^$_name_ /d" $_mg_cache_
    vared _check_
    echo -e "$_check_" >> $_mg_cache_
} || {
    echo -e "[X] $_name_: No mark exist " >&2
}
}
#}}}

#---------------------------#
# AUTO COMPLITION  FOR ZSH  #
#---------------------------#{{{
function _markgate {
    if [[ "$(wc -l < $_mg_cache_)" -gt 0 ]];then
		reply=( $(\cut -d " " -f1 $_mg_cache_) )
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

# vim: ft=sh
