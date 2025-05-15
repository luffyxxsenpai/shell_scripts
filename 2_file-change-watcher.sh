#!/bin/env bash

# the file we want to monitor
FILE="/etc/ssh/sshd_config"

# checks the last time file was modified
LAST_MODIFIED=$(stat -c %Y "$FILE")

# admin mail on whom the alert will be sent
ADMIN_EMAIL="admin@linux.com"

while true; do
sleep 60
# fetch the modified date every 60 sec
CURRENT_MODIFIED=$(stat -c %Y "$FILE")

    if [ "$CURRENT_MODIFIED" -ne "$LAST_MODIFIED" ]; then
        echo "ALERT: $FILE was modified at $(date)" | mail -s "File change Alert" $ADMIN_EMAIL 
        $LAST_MODIFIED="$CURRENT_MODIFIED"
    fi
done

# in the if block
# we are comparing value of last and current modified values
# when there is a change it will send an alert
# and will also update the new value of last_modified
# and send a mail to amdin using the linux default mail system

