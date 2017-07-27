#!/usr/bin/env python3

import app.app
import names
import random

app.app.db.create_all()

allnames = set(names.get_full_name() for _ in range(int(10_000_000)))
for name in allnames:
    firstname = names.get_first_name()
    email = '{}{}@example.com'.format(firstname, random.randint(1, 10E6))
    app.app.add_user(username=name, email=email)

with open('/user_to_find', 'w') as fp:
    print(email, file=fp)
