#!/bin/bash
git clone https://github.com/mdarden/case_repo.git
cd case_repo

oc -n openshift delete -f templates/nodejs-express-app.json