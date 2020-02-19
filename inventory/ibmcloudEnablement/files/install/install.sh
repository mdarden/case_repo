#!/bin/bash
git clone https://github.com/mdarden/case_repo.git
cd case_repo

oc -n openshift apply -f templates/go-gin-app.json
oc -n openshift apply -f templates/java-spring-app.json
oc -n openshift apply -f templates/nodejs-express-app.json
oc -n openshift apply -f templates/python-django-app.json
oc -n openshift apply -f templates/python-flask-app.json