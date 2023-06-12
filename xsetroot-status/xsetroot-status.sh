#!/bin/sh

# text-based statusbar using `xsetroot` to display various modules of information
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# dependencies:
# * xorg-xsetroot (base)
# * playerctl (track)
# * brightnessctl (brightness)

#######################
# CONFIGURABLE VALUES #
#######################

# minimum bar update rate, always make it a factor of 1 (no 0.33)
UPDATE_RATE='0.5'

# separator between each module
SEPARATOR=' | '

# update function, rearrange modules as needed
function update()
{
        # $UPDATE_RATE second(s) update
        TRACK=$(track)

        # 1 second update
        if [ $(echo "$TIME % 1" | bc) = "0" ]; then
                ISO_TIME=$(iso_time)
                $IS_LAPTOP && BRIGHTNESS=$(brightness)

                # 5 second update
                if [ $(echo "$TIME % 5" | bc) = "0" ]; then
                        MEMORY=$(memory)
                        DRIVES=$(drives $(echo "$TIME / 5" | bc) )
                        # 10 second update
                        if [ $(echo "$TIME % 10" | bc) = "0" ]; then
                                $IS_LAPTOP && BATTERY=$(battery)
                                # 20 second update
                                if [ $( echo "$TIME % 20" | bc ) = "0" ]; then
					game_play
					$IS_LAPTOP && GAME=$(game)
					check_laptop
                                fi
                        fi
                fi
        fi
}

###############################################
# you probably don't need to touch below here #
###############################################

# test laptop based on if theres a battery or not because i cant think of a better way
function check_laptop()
{
	if [[ $(cat /sys/class/power_supply/BAT0/status 2> /dev/null) ]]; then
        	IS_LAPTOP=true
	fi
}

# globals
DIR=$(dirname $0)
TIME=0
IS_LAPTOP=false
check_laptop
$IS_LAPTOP && echo "this computer detected to be a laptop"

# import universal functions
TRACK=''
source "$DIR/functions/track.sh"
ISO_TIME=''
source "$DIR/functions/iso_time.sh"
MEMORY=''
source "$DIR/functions/memory.sh"
DRIVES=''
source "$DIR/functions/drives.sh"
GAME=''
source "$DIR/functions/game.sh"
# import laptop only functions
BRIGHTNESS=''
source "$DIR/functions/brightness.sh"
BATTERY=''
source "$DIR/functions/battery.sh"

# add separators to input unless input is empty
function add_sep()
{
        if [ "$1" != '' ]; then
                echo "$2$1$3"
        fi
}

# update loop
while true; do
        update
        xsetroot -name "$( add_sep "$TRACK" '' "$SEPARATOR" )$( add_sep "$MEMORY" '' "$SEPARATOR" )$( add_sep "$DRIVES" '' "$SEPARATOR" )$( add_sep "$BRIGHTNESS" '' "$SEPARATOR" )$( add_sep "$GAME" '' "$SEPARATOR")$( add_sep "$BATTERY" '' "$SEPARATOR" )$( add_sep "$ISO_TIME" '' '' )"
        TIME=$( echo "$TIME + $UPDATE_RATE" | bc )
        sleep $UPDATE_RATE
done
