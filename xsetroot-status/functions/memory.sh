#!/bin/sh

# memory module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# none

# display current memory usage
function memory()
{
        # prints memory usage in format:
        # mem: <usedmem><unit of storage>
        # for example:
        # mem: 6.9Gi

        # you can add another argument to 'free' like '--giga' or '--peta' to change scale of the number
        echo "mem: $( free -h | grep Mem | awk '{ print $3 }' )"
}
