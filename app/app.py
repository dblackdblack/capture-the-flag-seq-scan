#!/usr/bin/env python3

import os

from flask import Flask, abort
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ['DATABASE_URL']
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    full_name = db.Column(db.String(120))
    email = db.Column(db.String(120))

    def __init__(self, full_name, email):
        self.full_name = full_name
        self.email = email

    def __repr__(self):
        return '<User %r>' % self.username


@app.route('/user/<email>', methods=['GET'])
def get_user(email):
    try:
        user = Users.query.filter_by(email=email).first()
        return user.full_name + "\n"
    except:
        abort(404)


def add_user(full_name, email, commit=True):
    user = Users(full_name=full_name, email=email)
    db.session.add(user)
    if commit:
        db.session.commit()

