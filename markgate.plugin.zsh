# Zakaria [Gatter] Barkouk

# # # # Color # # # #
BRed='\e[1;31m'     #
BGreen='\e[1;32m'   #
BYellow='\e[1;33m'  #
BBlue='\e[1;34m'    #
BWhite='\e[1;37m'   #
# # # # # # # # # # #
Off='\e[0m'         #
# # # # # # # # # # #

#----------------------#
# Get Config File Name #
#----------------------#
[ "$MARK_FILE" = "" ] && export MARK_FILE="markgate"

#------------------#
# Config File PATH #
#------------------#
export _MARK_FILE="$HOME/.$MARK_FILE"

#--------------------------------#
# Create Config File If no Exist #
#--------------------------------#
[ ! -e "$_MARK_FILE" ] && touch $_MARK_FILE

#--------------#
# MARkGATE ADD #
#--------------#
function markadd () {
    # Check if there is to many argulent 
    [ "$#" -gt "2" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}" && return
    [ "$#" -lt "1" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : Please Set Mark Name ${Off}" && return

    # Check if the mark are already exist
    _A_check=$(grep -w "^$1" $_MARK_FILE)

if [ -n "$2" ];then 
    PATH_=$(echo "$@" | cut -d " " -f2- )
    _PATH_=$(echo "$PATH_" | sed -e "s:^$HOME:~:" )

    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_PATH_} " >> $_MARK_FILE
        echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Saved ${Off}" && return
    else
        echo -e "${BYellow} ==> MarkGate :\n\t[${BRed}${$1}${BWhite}] already Existed, try other Name ${Off}" && return
    fi
elif [ -z "$2" ];then 
    _PATH_=$(pwd | sed -e "s:^$HOME:~:")
    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_PATH_} " >> $_MARK_FILE
        echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Saved ${Off}" && return
    else
        echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] already Existed, try other Name ${Off}" && return
    fi
fi
}

#-----------------#
# MARKGATE DELETE #
#-----------------#
function markdel () {
    # Check if there is to many argulent 
    [ "$#" -gt "1" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}" && return
    [ "$#" -lt "1" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : Please Set Mark Name ${Off}" && return

    _D_check=$(grep -w "${1}" $_MARK_FILE)
if [ -z "$_D_check" ];then 
    echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] Those not Exist ${Off}" && return
else
    sed -i "/${1}/d" $_MARK_FILE
    sed -i '/^$/d' $_MARK_FILE
    echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Deledted ${Off}" && return
fi
}

#---------------#
# MARKGATE JUMB #
#---------------#
function markjumb () {
    # Check if there is to many argulent 
    [ "$#" -gt "2" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}" && return
    [ "$#" -lt "1" ] && echo -e "${BYellow} ==>${BWhite} MarkGate : Please Set Mark Name ${Off}" && return

    _J_check=$(grep -w "$1" $_MARK_FILE)

if [ -z "$_J_check" ];then 
    echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] : Those not Exist ${Off}" && return
else
    J_dir=$(cat $_MARK_FILE | grep -w "$1" | cut -d "=" -f2 | tr -d " ")
    _J_dir=$(echo "$J_dir" | sed -e "s:^~:$HOME:")
    cd "${_J_dir}"
fi
}

#---------------#
# MARKGATE SHOW #
#---------------#
function markshow () {
	Show_check=$(column -t -s = $_MARK_FILE | wc -l )
	if [ "$Show_check" = "0" ];then 
		echo -e "\n${BWhite} MarkGate : "
		echo -e "${BBlue} -->${BWhite} No Mark Set ${Of}"
	else
		echo -e "\n${BBlue} -->${BWhite} MarkGate : Show Mark's \n"
		column -t -s = $_MARK_FILE
        echo -e "${Off}"
	fi 
}

#-----------------#
# Auto Completion #
#-----------------#
_completemarkgate() {
    if [[ $(cat "${_MARK_FILE}" | wc -l) -gt 0 ]];then 
        reply=($(cat $_MARK_FILE | cut -d "=" -f1))
    fi
}

compctl -K _completemarkgate markdel
compctl -K _completemarkgate markjumb
