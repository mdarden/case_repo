The IBM Starter Collection for Openshift installs new starter templates into the Developer Catalog for an OpenShift cluster so that OpenShift developers can easily find and use them. All the templates in this collection run on OpenShift, but automatically provision and use managed services from the IBM Cloud public catalog.

Before installing this starter collection, you must have an OpenShift cluster on IBM Cloud.  If you don't [create one here.](https://cloud.ibm.com/kubernetes/catalog/openshiftcluster). Note clusters may take 30 minutes or more to provision.

You will need these pieces of information to install the starter collection:

| Parameter | Description | Value |
|---|---|---|
| apiKey | API Key for IBM Cloud | If you have an existing key, paste it into the field.  If not, create a new one:  From the top bar of the cloud console select Manage > Access(IAM). Than select IBM Cloud API Keys from the left navigation menu and create a new key.  Copy the key and paste it into the apiKey field. |
| roksServer | Server URL for managed OpenShift on IBM Cloud | Open your cluster details view and visit the 'Access' tab.
Click 'Generate IAM token' link. |
| clusterName | Name of the cluster to which you will add the collection| Find this in the resources list of you cloud console dashboard, or in the cluster details view for your cluster. |
| resourceGroup	| Resource group for the cluster to which you will add the collection | Find this in the resources list of you cloud console dashboard, or in the cluster details view for your cluster. |

After filling in the required information, click the license acknowledgement checkbox and then click the install button.

IBM Cloud platform will use Schematics to automatically install the starter templates into your OpenShift Developer Catalog.  After installation is complete (usually about 10 minutes), reload your OpenShift web console to see the new tiles in your Developer Catalog.  Click the individual starter tiles to learn more about each.



