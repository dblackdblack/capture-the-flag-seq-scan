#!/bin/bash -xe

user_to_find=$(cat /user_to_find)
echo "****** Try to find this user's name:  $user_to_find"
service postgresql start
cd /app
exec gunicorn --access-logfile=- --bind 0.0.0.0:8000 app.app:app
