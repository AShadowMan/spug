#!/bin/sh

## start redis
redis-server &

## run backend

cd $WORKDIR/spug_api
rm -f db.sqlite3 ## rm db file if exists
python manage.py initdb
python manage.py useradd -u admin -p spug.dev -s -n 管理员
nohup python manage.py runserver &
nohup python manage.py runworker ssh_exec &
nohup python manage.py runscheduler &
nohup python manage.py runmonitor &

## run frontend

cd $WORKDIR/spug_web
nohup npm start &

## pause
/bin/sh

