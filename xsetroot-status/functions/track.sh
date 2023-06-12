#!/bin/sh

# track module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# playerctl

# display currently playing track and its volume
function track()
{
        # prints now playing track in format:
        # <status>: <track title> <pos>/<len> [<vol>%]
        # for example:
        # Playing: Touhiron 3:42/4:35 [69%]
        STATUS=$(mpc 2> /dev/null | awk 'FNR == 2 {print $1}')
        if [ "$STATUS" = '[playing]' ]; then
                #      <status>: <track title>                    <pos>/<len>     [<vol>%]
               	echo "$(mpc | awk 'FNR == 1 {print}') $(mpc | awk 'FNR == 2 {print $3}') [$(mpc | awk 'FNR == 3 {print $2}')]"
        fi
}
