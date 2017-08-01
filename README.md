Welcome!

This Docker image contains a very simple python flask web app.  It has a postgres database which stores
data about users.  It has a single endpoint (/user) which, when given a user's email address,
returns a user's full name by looking it up in the database.

Launch the container by running this:

```
docker run --rm -ti -p 8000:8000 quay.io/dblackdblack/x:250
```

You will see output that resembles this:
```
$ docker run --rm -ti -p 8000:8000 quay.io/dblackdblack/x:250


****** Visit this URL:  http://localhost:8000/user/Diana4843650@example.com

[2017-08-01 15:02:19 +0000] [1] [INFO] Starting gunicorn 19.7.1
[2017-08-01 15:02:19 +0000] [1] [INFO] Listening at: http://0.0.0.0:8000 (1)
[2017-08-01 15:02:19 +0000] [1] [INFO] Using worker: sync
[2017-08-01 15:02:19 +0000] [8] [INFO] Booting worker with pid: 8
```

Open up your web browser and copy-paste the URL into the browser.  And then we begin!

