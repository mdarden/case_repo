#!/bin/bash
export RESOURCE_GROUP=${resourceGroup}
export CLUSTER_NAME=${clusterName}
export TEMPLATE_FILE=${templateFile}
export API_KEY=${apiKey}
export ROKS_TOKEN=${osToken}
export ROKS_SERVER=${roksServer}

oc -n openshift apply -f templates/nodejs-express-app.json