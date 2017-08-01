#!/usr/bin/env python3

import app.app
import names
import random

app.app.db.create_all()

allnames = set(names.get_full_name() for _ in range(int(250000)))
numnames = len(allnames)
count = 0

for name in allnames:
    firstname = name.split(' ')[0]
    email = '{}{}@example.com'.format(firstname, random.randint(1, 10E6))
    app.app.add_user(full_name=name, email=email, commit=False)
    count += 1
    if count % 10000 == 0:
        print("{}/{}".format(count, numnames))

app.app.db.session.commit()

with open('/user_to_find', 'w') as fp:
    print(email, file=fp)
