#!/bin/sh

# brightness module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# brightnessctl

function brightness()
{
        # prints brightness in format:
        # BL: <brightness>%
        # for example:
        # BL: 69%

        # out always be 3 characters (05% instead of 5%, MAX instead of 100%) because it looks better that way
        BRIGHTNESS=$( printf "%02d%%" "$(( $( brightnessctl get ) * 100 / $( brightnessctl max ) ))" )
        if [ $BRIGHTNESS = "100%" ]; then
                BRIGHTNESS="MAX"
        fi
        echo "BL: $BRIGHTNESS"
}
