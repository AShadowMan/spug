#!/bin/sh

## run backend

cd $WORKDIR/spug_api
rm -f db.sqlite3 ## rm db file if exists
python manage.py initdb
python manage.py useradd -u admin -p spug.dev -s -n 管理员
python manage.py runserver &
python manage.py runworker ssh_exec &
python manage.py runscheduler &
python manage.py runmonitor

## run frontend

cd $WORKDIR/spug_web
npm start &

## pause
/bin/sh

