There are two things wrong with the container:

1. Postgres doesn't start unless you `docker run` with `-e START_POSTGRES=1`, so
   the web app will throw exceptions complaining about this when you hit the endpoint
1. The users table lacks an index on the email column, so queries are slow. The gunicorn
   log format includes the request duration (in microseconds) as the last item in the log
   line.  E.g. `13345 usec` ... adding the index should get this down to 4000-5000 usec

If the candidate successfully blows through these two problems:
1. Have them modify the `init_app.py` file and lower the number of bogus email addresses down to 10
   (adding 100s of thousands of entries takes minutes)
1. Add an endpoint to create users from a JSON dict. The app already has an `add_user()` method;
   candidate has to add an endpoint which deserializes JSON and calls this method
