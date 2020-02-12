#!/bin/bash
export RESOURCE_GROUP=${resourceGroup}
export CLUSTER_NAME=${clusterName}
export TEMPLATE_FILE=${templateFile}
export API_KEY=${apiKey}
export ROKS_TOKEN=${osToken}
export ROKS_SERVER=${roksServer}

function usage {
    echo "Usage: ./ibm-ocp-template-install.sh --apikey=<api_key> --resource-group-id=<resource_group_id> --cluster-name=<cluster_name> [--template-file=template_file]"
    echo "Defaults to the template file located in /openshift/templates."
}

# REMOVE when running with Schematics/Terraform worker
# function check_input {
#     if [[ -z "$1" ]]; then
#         echo "$2"
#         usage
#         exit 1
#     fi
# }
# END REMOVE

function check_exit {
    check_exit_custom $? $2
}

function check_exit_custom {
    if [[ $1 -ne 0 ]]; then
        echo -e "\n$2"
        exit 1
    fi
}

# REMOVE when running with Schematics/Terraform worker
# for arg in "$@"
# do
#     if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
#         usage
#         exit 0
#     fi

#     if [[ $arg == --apikey=* ]]; then
#         API_KEY=$( echo $arg | cut -d'=' -f 2 )
#     fi

#     if [[ $arg == --resource-group-id=* ]]; then
#         RESOURCE_GROUP=$( echo $arg | cut -d'=' -f 2 )
#     fi

#     if [[ $arg == --cluster-name=* ]]; then
#         CLUSTER_NAME=$( echo $arg | cut -d'=' -f 2 )
#     fi

#     if [[ $arg == --template-file=* ]]; then
#         TEMPLATE_FILE=$( echo $arg | cut -d'=' -f 2 )
#     fi
# done

# if [[ -z "$TEMPLATE_FILE" ]]; then
#     TEMPLATE_FILE=$PWD/openshift/templates/clone.json
# fi
# echo "Using template file $TEMPLATE_FILE"

# check_input "$API_KEY" "No API key was supplied. A valid IBM Cloud API key is required to login to the IBM Cloud. Use 'ibmcloud iam api-key-create' to create an API key."
# check_input "$RESOURCE_GROUP" "No resource group ID was supplied. Execute 'ibmcloud resource groups' to list resource groups."
# check_input "$CLUSTER_NAME" "No cluster name was supplied. Execute 'ibmcloud ks clusters' to list available clusters."
# check_input "$TEMPLATE_FILE" "No template file was supplied."
# END REMOVE

echo -e "\nLogging in to IBM Cloud...\n"
# ibmcloud api https://test.cloud.ibm.com
echo ${API_KEY}
# ibmcloud login -a https://test.cloud.ibm.com -r us-south --apikey ${API_KEY}

echo -e "\nListing resource groups...\n"
# ibmcloud resource groups

echo -e "\nTargeting resource group ${RESOURCE_GROUP}...\n"
# ibmcloud target -r us-south -o mdarden@us.ibm.com -s dev -g ${RESOURCE_GROUP}
# ibmcloud target --cf-api https://api.us-south.cf.test.cloud.ibm.com -o mdarden@us.ibm.com -s dev -r us-south -g ${RESOURCE_GROUP}
# ibmcloud target --cf -o mdarden@us.ibm.com -s dev -r us-south -g ${RESOURCE_GROUP}

# REMOVE for local runs
# install ks plugin
echo -e "\nInstalling ks plugin...\n"
# ibmcloud plugin install container-service -f
#END REMOVE

# ibmcloud target --cf -r us-south -g ${RESOURCE_GROUP}
echo -e "\nListing clusters...\n"
# ibmcloud ks cluster ls

# ibmcloud target command uses https://mccp.us-south.cf.test.cloud.ibm.com end point to set org and space.
# We need to whitelist source and destination IPs to access mccp endpoint from public container (from which Schematics runs)
# so let's get source and destination IPs
echo -e "\nsource ip(s)\n"
hostname -I

# echo -e "\nInstalling nslookup\n"
# yum -y install bind-utils

# echo -e "\ndestination ips\n"
# nslookup mccp.us-south.cf.test.cloud.ibm.com

echo -e "\ndestination ips\n"
# getent hosts mccp.us-south.cf.test.cloud.ibm.com

echo -e "\nLogging in to openshift...\n"
# oc login ${ROKS_SERVER} -u apikey -p ${API_KEY}
# echo -e ${ROKS_SERVER}
# oc login --token=${ROKS_TOKEN} --server=${ROKS_SERVER}

echo -e "\nApplying cluster configuration for cluster ${CLUSTER_NAME}...\n"
# $( ibmcloud ks cluster config ${CLUSTER_NAME} --admin | grep export)
# $( ibmcloud cs cluster config ${CLUSTER_NAME} --admin  | grep export)
# $( ibmcloud ks cluster config ${CLUSTER_NAME} --admin  | grep export)
# check_exit "Failed to apply cluster configuration for cluster ${CLUSTER_NAME}. Check the cluster name and try again."

echo -e "\nInstalling Operator Lifecycle Manager...\n"
# kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.12.0/crds.yaml && kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.12.0/olm.yaml
# check_exit "Failed to install the Operator Lifecycle Manager. Check the command output and try again."

echo -e "\nInstalling Marketplace Operator...\n"
# OM_TEMP_DIR=om_temp
# mkdir $OM_TEMP_DIR
# cd $OM_TEMP_DIR
# git clone https://github.com/operator-framework/operator-marketplace.git
# GIT_CLONE_EXIT=$?
# oc apply -f operator-marketplace/deploy/upstream/
# OC_APPLY_EXIT=$?
# cd ..
# rm -rf ./$OM_TEMP_DIR
# check_exit_custom $GIT_CLONE_EXIT "Failed to download Operator Marketplace resource definitions. Ensure that you are connected to the Internet and can access GitHub."
# check_exit_custom $OC_APPLY_EXIT "Failed to install Operator Marketplace. Check the command output and try again."

echo -e "\nInstalling IBM Cloud Operator...\n"
echo -e "\n   Deploying IBM Cloud Operator...\n"
# kubectl apply -f https://operatorhub.io/install/ibmcloud-operator.yaml
# check_exit "Failed to deploy IBM Cloud Operator. Ensure the ${CLUSTER_NAME} cluster is available."
echo -e "\n   Configuring IBM Cloud Operator...\n"
# curl -sL https://raw.githubusercontent.com/IBM/cloud-operators/master/hack/config-operator.sh | bash
# check_exit "Failed to configure IBM Cloud Operator. Check the command output and try again."

# Create and manually install a new template to the catalog -- this will also be scoped for that cluster only.
echo -e "\nInstalling template ${TEMPLATE_FILE}...\n"
# curl https://raw.githubusercontent.com/mdarden/nodejs-cloudant/master/openshift/templates/clone.json -o file1.json
# curl "${TEMPLATE_FILE}" -o clone.json
# oc -n openshift apply -f "${TEMPLATE_FILE}"
# oc -n openshift apply -f clone.json

# check_exit "Failed to install template ${TEMPLATE_FILE}. Ensure the template definition is valid and try again."
echo -e "\nTemplate installation succeeded!"
