#!/bin/bash
if test -z "$MONGO_PASSWD"; then
    echo "MONGO_PASSWD not defined"
    exit 1
fi

(
echo "setup mongo auth ..."
auth="-u root -p $MONGO_PASSWD"
js="if (!db.getUser('root')) { db.createUser({ user: 'root', pwd: '$MONGO_PASSWD', roles: [ {role:'root', db:'admin'} ]}) }"
until mongo admin --eval "$js" || mongo admin $auth --eval "$js"; do sleep 5; done
echo "completed auth setup, killing naked mongo"
killall mongod
sleep 1
killall -9 mongod
) &

echo "start mongodb wihtout auth"
chown -R mongodb /data/db
gosu mongodb mongod --bind_ip=127.0.0.1 "$@"

echo "restarting with auth on"
sleep 5
exec gosu mongodb mongod --auth "$@"
