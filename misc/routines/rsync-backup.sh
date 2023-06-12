#!/bin/bash
# copies $FROM to $TO using rsync
# made for usage as cronie task
# dependencies: rsync
# cron settings:
# 00 04 * * * /bin/bash /home/me/backups/code/theokrueger/configuration/misc/routines/rsync-backup.sh

OPNAME="backup2sdc"
LOGFILE="/home/me/backups/.userlog"
FROM="/home/me/backups/"
TO="/mnt/sdc/"

if [ -d "$TO"  ] && [ -d "$FROM" ]; then
    rsync -cr $FROM $TO && printf "SUCCESS in \"$OPNAME\" at $(date "+%F, %R"):\n\tSync completed\n\t\"rsync -cr $TO $FROM\"\n" >> "$LOGFILE"
else
    printf "ERROR in \"$OPNAME\" at $(date "+%F, %R"):\n\tNo such directory found in command\n\t\"rsync -cr $TO $FROM\"\n" >> "$LOGFILE"
fi

# prints as follows on success:

# SUCCESS in "mosic backup" at 2022-03-18, 13:46:
#        Successfully backed up 
#        "rsync -cr /home/me/backups/mosic /mnt/sdc/mosic"

# prints as follows on failure:

# ERROR in "mosic backup" at 2022-03-18, 13:46:
#        No such directory found in command
#        "rsync -cr /home/me/backups/mosic /mnt/sdc/mosic"
