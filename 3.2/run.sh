#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE_MB" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE_MB"
fi

if [ "$CACHE_SIZE_GB" != "" ]; then
    cmd="$cmd --wiredTigerCacheSizeGB $CACHE_SIZE_GB"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

fg
