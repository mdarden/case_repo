#!/bin/bash
git clone https://github.com/mdarden/case_repo.git
cd case_repo

echo "Print Environment"
printenv

oc apply -f templates/go-gin-app.json
oc apply -f templates/java-spring-app.json
oc apply -f templates/nodejs-express-app.json
oc apply -f templates/python-django-app.json
oc apply -f templates/python-flask-app.json