#!/bin/bash

user_to_find=$(cat /user_to_find)
printf "\n\n****** Visit this URL:  http://localhost:8000/user/${user_to_find}\n\n"

if ! test -z "${START_POSTGRES}" ; then
    service postgresql start &> /dev/null
fi

cd /app
exec gunicorn --access-logformat='%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s" %(D)s usec' --access-logfile=- --bind 0.0.0.0:8000 app.app:app
