## -- Namespace --

.PHONY: create-namespace
create-namspace:
	oc apply -f namespace.yaml

## -- Operators --

## Service Binding Operator
.PHONY: install-sbo-operator-source
install-sbo-operator-source:
	oc apply -f opsrc.service-binding-operator.yaml
	@echo Now go to OperatorHub in OpenShift console to install the Service Binding Operator

.PHONY: uninstall-sbo-operator-source
uninstall-sbo-operator-source:
	-oc delete -f opsrc.service-binding-operator.yaml

.PHONY: undeploy-service-binding-operator
undeploy-service-binding-operator:
	@-oc delete opsrc redhat-developer-operators -n openshift-marketplace
	@-oc delete sub service-binding-operator -n openshift-operators
	@-oc delete crd servicebindingrequests.apps.openshift.io
	@-oc delete rolebinding service-binding-operator
	@-oc delete serviceaccount service-binding-operator  -n openshift-operators
	@-oc delete role service-binding-operator -n openshift-operators
	@-oc delete csv service-binding-operator.v0.0.14
	@-oc delete deployment service-binding-operator -n openshift-operators

## AWS RDS Operator

.PHONY: install-aws-rds-operator-source
install-aws-rds-operator-source:
	oc apply -f opsrc.aws-rds-operator.yaml
	@echo Now go to OperatorHub in OpenShift console to install the AWS RDS Operator

.PHONY: uninstall-aws-rds-operator-source
uninstall-aws-rds-operator-source:
	-oc delete -f opsrc.aws-rds-operator.yaml

.PHONY: install-aws-rds-operator-secrets
install-aws-rds-operator-secrets:
	$(eval AWS_ACCESS_KEY_ID := $(shell cat ~/.aws/credentials | grep aws_access_key_id | cut -d " " -f3))
	$(eval AWS_SECRET_ACCESS_KEY := $(shell cat ~/.aws/credentials | grep aws_secret_access_key | cut -d " " -f3))
	@sed -e 's,REPLACE_AWS_ACCESS_KEY_ID,$(shell echo -n "$(AWS_ACCESS_KEY_ID)" | base64),g' secret.aws.yaml | \
	 sed -e 's,REPLACE_AWS_SECRET_ACCESS_KEY,$(shell echo -n "$(AWS_SECRET_ACCESS_KEY)" | base64),g' | oc apply -f -

.PHONY: uninstall-aws-rds-operator-secrets
uninstall-aws-rds-operator-secrets:
	-oc delete secret aws-rds-operator -n openshift-operators

.PHONY: undeploy-aws-rds-operator
undeploy-aws-rds-operator:
	@-oc delete opsrc aws-rds-operator -n openshift-marketplace
	@-oc delete sub aws-rds-operator -n openshift-operators
	@-oc delete crd rdsdatabases.aws.pmacik.dev
	@-oc delete rolebinding aws-rds-operator
	@-oc delete serviceaccount aws-rds-operator
	@-oc delete role aws-rds-operator
	@-oc delete csv aws-rds-operator.v0.1.0-dev
	@-oc delete deployment aws-rds-operator -n openshift-operators

## -- Applications --

## Bash app
.PHONY: deploy-bash-app
deploy-bash-app:
	oc apply -f deployment.bash-app.yaml

.PHONY: undeploy-bash-app
undeploy-bash-app:
	-oc delete -f deployment.bash-app.yaml

## NodeJS app
.PHONY: undeploy-nodejs-app
undeploy-nodejs-app:
	@-oc delete bc nodejs-app -n service-binding-demo
	@-oc delete dc nodejs-app -n service-binding-demo
	@-oc delete svc nodejs-app -n service-binding-demo
	@-oc delete route nodejs-app -n service-binding-demo
	@-oc delete is nodejs-app -n service-binding-demo

## AWS RDS Database
.PHONY: deploy-db
deploy-db:
	oc apply -f rds.mydb.yaml

.PHONY: undeploy-db
undeploy-db:
	-oc delete -f rds.mydb.yaml

## -- Service binding requests --

## Bash app
.PHONY: create-binding-request-bash
create-binding-request-bash:
	oc apply -f sbr.bash-app.yaml

.PHONY: delete-binding-request-bash
delete-binding-request-bash:
	-oc delete -f sbr.bash-app.yaml

## NodeJS App
.PHONY: create-binding-request-nodejs
create-binding-request-nodejs:
	oc apply -f sbr.nodejs-app.yaml

.PHONY: delete-binding-request-nodejs
delete-binding-request-nodejs:
	-oc delete -f sbr.nodejs-app.yaml

## -- Labels --

## Bash app
.PHONY: set-labels-on-bash-app
set-labels-on-bash-app:
	oc label deployment bash-app 'connects-to=postgres' 'environment=bash' -n service-binding-demo

.PHONY: clear-labels-on-bash-app
clear-labels-on-bash-app:
	oc label deployment bash-app connects-to- environment- -n service-binding-demo

## NodeJS app
.PHONY: set-labels-on-nodejs-app
set-labels-on-nodejs-app:
	oc label dc nodejs-app 'connects-to=postgres' 'environment=nodejs' -n service-binding-demo

.PHONY: clear-labels-on-nodejs-app
clear-labels-on-nodejs-app:
	oc label dc nodejs-app connects-to- environment- -n service-binding-demo
