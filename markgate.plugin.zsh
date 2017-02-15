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
    if [ "$#" -gt "2" ];then 
        echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}"
        exit 1
    fi 

    # Check if the mark are already exist
    local _A_check=$(grep -w "^$1" $_MARK_FILE)

if [ -n "$2" ];then 
    local PATH_=$(echo "$@" | cut -d " " -f2- )
    local _PATH_=$(echo "$PATH_" | sed -e "s:^$HOME:~:" )

    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_PATH_} " >> $_MARK_FILE
        echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Saved ${Off}"
        exit 0
    else
        echo -e "${BYellow} ==> MarkGate :\n\t[${BRed}${$1}${BWhite}] already Existed, try other Name ${Off}"
        exit 3
    fi
elif [ -z "$2" ];then 
    _PATH=$(pwd | sed -e "s:^$HOME:~:")
    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_PATH} " >> $_MARK_FILE
        echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Saved ${Off}"
        exit 0
    else
        echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] already Existed, try other Name ${Off}"
        exit 3
    fi
fi
}

#-----------------#
# MARKGATE DELETE #
#-----------------#
function markdel () {
    # Check if there is to many argulent 
    if [ "$#" -gt "1" ];then 
        echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}"
        exit 1
    fi 

    local _D_check=$(grep -w "${1}" $_MARK_FILE)
if [ -z "$_D_check" ];then 
    echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] Those not Exist ${Off}"
    exit 1
else
    sed -i "/${1}/d" $_MARK_FILE
    sed -i '/^$/d' $_MARK_FILE
    echo -e "${BBlue} -->${BWhite} MarkGate : [${BGreen}${1}${BWhite}] Deledted ${Off}"
    exit 0
fi
}

#---------------#
# MARKGATE JUMB #
#---------------#
function markjumb () {
    # Check if there is to many argulent 
    if [ "$#" -gt "2" ];then 
        echo -e "${BYellow} ==>${BWhite} MarkGate : To Many Argument ${Off}"
        exit 1
    fi 

    local _J_check=$(grep -w "$1" $_MARK_FILE)

if [ -z "$_J_check" ];then 
    echo -e "${BYellow} ==>${BWhite} MarkGate :\n\t[${BRed}${1}${BWhite}] : Those not Exist ${Off}"
    exit 3
else
    local J_dir=$(cat $_MARK_FILE | grep -w "$1" | cut -d "=" -f2 | tr -d " ")
    local _J_dir=$(echo "$J_dir" | sed -e "s:^~:$HOME:")
    cd "${_J_dir}"
fi
}

#---------------#
# MARKGATE SHOW #
#---------------#
function markshow () {
	local Show_check=$(column -t -s = $_MARK_FILE | wc -l )
	if [ "$Show_check" = "0" ];then 
		echo -e "\n${BWhite} MarkGate : "
		echo -e "${BBlue} -->${BWhite} No Mark Set ${Of}"
        exit 1
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
