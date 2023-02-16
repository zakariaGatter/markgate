#!/bin/zsh 

#-------------------#
# GENERAL VARIABLES #
#-------------------#
_MARKGATE_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/markgate"
[ -f "$_MARKGATE_CACHE" ] || touch $_MARKGATE_CACHE

#-------------#
# HELP DIALOG #
#-------------#
gh(){
while read ;do
    printf "%s\n" "$REPLY"
done <<-HELP
MarkGate: Mark your Directories for easy access

FUNCTION:
  ga <name> <DIR>   Add new mark to Markgate
  gj <name>         Jumb to giving mark
  gr <name> ...     Remove one or multi Marks
  gs <name> ...     Display list of marks
  gh                Show this help dialog
HELP
return 0
}

#--------------#
# ADD NEW MARK #
#--------------#
ga(){
    (( $# > 2 )) && gh

    name="$1"
    dir="$2"

    if [ ! -d "$dir" ]; then 
       printf "%s\n" "MarkGate: '$dir' No Such directory " >&2
       return 2
    fi

    while IFS=':' read -A line ;do
       if [ "$line[1]" = "$name" ]; then 
           printf "%s\n" "MarkGate: '$name' Mark already Exist" >&2
           return 2
       elif [ "$line[2]" = "$dir" ]; then
           printf "%s\n" "MarkGate: '$dir' Directory already marked as '$line[1]'" >&2
           return 2
       fi
    done < $_MARKGATE_CACHE

    printf "%s:%s\n" "$name" "$dir" >> $_MARKGATE_CACHE
    printf "%s\n" "MarkGate: '$name' Mark created "

    unset name dir line 
}

#----------------#
# JUMB TO A MARK #
#----------------#
gj(){
    (( $# > 1 )) && gh

    name="$1"  
    while IFS=':' read -A line ;do
       if [ "$line[1]" = "$name" ]; then
           builtin cd "$line[2]"
           Jumb=true
           break
       fi
    done < $_MARKGATE_CACHE

    if [ -z "$Jumb" ]; then 
        printf "%s\n" "MarkGate: '$name' No such Mark"
        return 2
    fi

    unset line Jumb
}

#---------------#
# REMOVE A MARK #
#---------------#
gr(){
    [ -z "$1" ] && gh

    for name in $@ ; do
        while IFS=":" read -A line ;do
            if [ "$line[1]" = "$name" ]; then 
                sed -i "/^$name/d" $_MARKGATE_CACHE
                printf "%s\n" "'$name' Remove Mark"
                Remove=true
                break
            fi
        done < $_MARKGATE_CACHE
        if [ -z "$Remove" ]; then 
            printf "%s\n" "MarkGate: '$name' No such Mark"
        fi
        unset Remove
    done

    unset line name
}

#--------------------#
# SHOW LIST OF MARKS #
#--------------------#
gs(){
    if [ -z "$1" ]; then 
        column -t -s ':' $_MARKGATE_CACHE
    else
        for name in $@ ;do
            while IFS=':' read -A line ; do
                if [[ $line[1] =~ $name ]]; then 
                    printf "%s %15s" "$line[1]" "$line[2]" 
                fi
            done < $_MARKGATE_CACHE
        done
    fi
}

#----------------#
# ZSH COMPLETION #
#----------------#
_markgate(){
    while IFS=':' read -A line ; do
        ListMark+=( "$line[1]" )
    done < $_MARKGATE_CACHE

    if (( ${#ListMark[@]} > 0 )); then 
        reply=( ${ListMark[@]} )
    fi

    unset line ListMark
}

#------------------#
# APPLY COMPLETION #
#------------------#
compctl -K _markgate gj
compctl -K _markgate gr
compctl -K _markgate gs
