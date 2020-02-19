The IBM Starter Kit Collection for OpenShift installs new IBM templates into the Developer Catalog for an OpenShift cluster, so developers can easily find and use them. All the templates in this collection run on OpenShift and have the ability to automatically provision and use managed services from the IBM Cloud public catalog.

These starter kits are included in the deployment:
* [Node.js Express App](https://github.com/IBM/nodejs-express-app)
* [Go Gin App](https://github.com/IBM/go-gin-app)
* [Python Flask App](https://github.com/IBM/python-flask-app)
* [Python Django App](https://github.com/IBM/python-django-app)
* [Java Spring App](https://github.com/IBM/java-spring-app)

Before installing this template, you must have an OpenShift cluster on IBM Cloud.  If you don't [create one here](https://cloud.ibm.com/kubernetes/catalog/openshiftcluster). Note clusters may take 30 minutes or more to provision.

IBM Cloud platform will use Schematics to automatically install the starter templates into your OpenShift Developer Catalog.  After installation is complete (usually about 10 minutes), reload your OpenShift web console to see the new tiles in your Developer Catalog.  Click the individual starter tiles to learn more about each.