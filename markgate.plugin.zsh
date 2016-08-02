# Zakaria [Gatter] Barkouk

#----------------------#
# Get Config File Name #
#----------------------#
[ "$MARK_FILE" = "" ] && MARK_FILE="markgate"

#------------------#
# Config File PATH #
#------------------#
_MARK_FILE="$HOME/.$MARK_FILE"

#--------------------------------#
# Create Config File If no Exist #
#--------------------------------#
[ ! -e "$_MARK_FILE" ] && touch $_MARK_FILE

#--------------#
# MARkGATE ADD #
#--------------#
function markadd () {
if [ ! -z "$2" ];then 
    # Check if the mark are already exist
    local _A_check=$(grep "^$1" $_MARK_FILE)
    local PATH_=$(echo "$@" | cut -d " " -f2- )
    local _PATH_=$(echo "$PATH_" | sed -e "s:^$HOME:~:" )

    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_PATH_} " >> $_MARK_FILE
        echo -e "MarkGate : $1 Saved "
    else
        echo -e "MarkGate :\n\tThis Mark already Existed, try other Name "
    fi
else
    # Get courrent PATH 
    local _Path=$(pwd | sed -e "s:^$HOME:~:")
    # Check if the mark already exist 
    local _A_check=$(grep "^$1" $_MARK_FILE)
    
    if [ -z "$_A_check" ];then 
        echo -e "${1}=${_Path} " >> $_MARK_FILE
        echo -e "MarkGate : $1 Saved "
    else
        echo -e "MarkGate :\n\tThis Mark already Existed, try other Name "
    fi
fi
}

#-----------------#
# MARKGATE DELETE #
#-----------------#
function markdel () {
    local _D_check=$(grep "^${1}" $_MARK_FILE)
if [ -z "$_D_check" ];then 
    echo -e "MarkGate :\n\t${1} Those not Exist "
else
    sed -i "/${1}/d" $_MARK_FILE
    sed -i '/^$/d' $_MARK_FILE
    echo -e "MarkGate : ${1} Deledted"
fi
}

#---------------#
# MARKGATE JUMB #
#---------------#
function markjumb () {
    local _J_check=$(grep "^$1" $_MARK_FILE)

if [ -z "$_J_check" ];then 
    echo -e "MarkGate :\n\t$1 : Those not Exist "
else
    local J_dir=$(cat $_MARK_FILE | grep "^$1" | cut -d "=" -f2 | tr -d " ")
    local _J_dir=$(echo "$J_dir" | sed -e "s:^~:$HOME:")
    cd "${_J_dir}"
fi
}

#---------------#
# MARKGATE SHOW #
#---------------#
function markshow () {
	echo -e "\nMarkGate : \n"
	column -t -s = $_MARK_FILE
	echo ""
}
