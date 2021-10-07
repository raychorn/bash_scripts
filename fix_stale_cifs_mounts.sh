#! /bin/bash

function check_cifs() {
    list=$(mount | grep cifs)
    while read -r line; do
        TARGET=$(echo $line | awk '{print $1}')
        MOUNT=$(echo $line | awk '{print $3}')
        STALE_TEST=$(ls $MOUNT |& grep "Stale file handle")
        if [ ! -z "$STALE_TEST" ]; then
            echo "$MOUNT -> $TARGET -> $STALE_TEST"
            #umount -l $MOUNT
            #mount -t nfs $TARGET $MOUNT
        else
            echo "$MOUNT -> $TARGET"
            ls $MOUNT
        fi
    done <<< "$list"
}

while true; do
    check_cifs
    sleep 10
done

echo "Done."