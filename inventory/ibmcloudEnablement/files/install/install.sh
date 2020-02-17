#!/bin/bash
git clone https://github.com/mdarden/case_repo.git
cd case_repo

oc -n openshift apply -f templates/nodejs-express-app.json