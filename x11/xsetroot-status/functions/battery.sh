#!/bin/sh

# battery module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# none

function battery()
{
        # prints battery in format:
        # <status>: <charge>%
        # for example:
        # Discharging: 69%

        # sometimes battery status might be 'UNKNOWN', and that is okay!
        echo "$( cat /sys/class/power_supply/BAT0/status ): $( cat /sys/class/power_supply/BAT0/capacity )%"
}
