#!/bin/sh

# time module for xsetroot-status
# theokrueger <git@gitlab.com/theokrueger>
# MIT License

# module dependencies:
# none

# display current time in ISO-8601 format
function iso_time()
{
        # prints date in format:
        # [<weekday>] <fullyear>-<month>-<day> <time>
        # for example:
        # [4] 1970-01-01 00:00
        date "+[%u] %F %R"
}
