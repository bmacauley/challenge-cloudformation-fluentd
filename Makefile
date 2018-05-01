#--------------------------------------------
# Makefile - challenge-cloudformation-fluentd
#--------------------------------------------

.DEFAULT: help
.PHONY:  help



help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


#--------------------------------------------
# Virtualenvwrapper setup
#--------------------------------------------

SHELL:=/bin/bash
VIRTUAL_ENV_NAME:=challenge-cloudformation-fluentd
VIRTUAL_ENV_INSTALL:=~/.virtualenvs/$(VIRTUAL_ENV_NAME)/bin/activate
PIP_INSTALL:=~/.virtualenvs/$(VIRTUAL_ENV_NAME)/bin/pip

$(VIRTUAL_ENV_INSTALL):
	( \
	source $(VIRTUALENVWRAPPER_SCRIPT) ; \
	mkvirtualenv $(VIRTUAL_ENV_NAME) --python=/usr/local/bin/python3.6 ; \
	touch ~/.virtualenvs/$(VIRTUAL_ENV_NAME)/bin/activate ; \
	)


$(PIP_INSTALL): $(VIRTUAL_ENV_INSTALL) requirements.txt
	( \
	source $(VIRTUALENVWRAPPER_SCRIPT) ; \
	workon $(VIRTUAL_ENV_NAME) ; \
	pip install -r requirements.txt ;\
	touch ~/.virtualenvs/$(VIRTUAL_ENV_NAME)/bin/pip ;\
	)

setup: $(PIP_INSTALL) ## Setup Python virtualenv


validate_s3:
	aws cloudformation validate-template --template-body file://${PWD}/cloudformation/s3.yml



build_s3:
	aws cloudformation create-stack --template-body file://${PWD}/cloudformation/s3.yml \
		--stack-name s3-bucket \
		--parameters file://env.json \
		--capabilities CAPABILITY_IAM \
		--region eu-west-1


update_s3:
	aws cloudformation update-stack --template-body file://${PWD}/cloudformation/s3.yml \
		--stack-name s3-bucket \
		--capabilities CAPABILITY_IAM \
		--region eu-west-1

events_s3:
	aws cloudformation describe-stack-events \
		--stack-name s3-bucket \
		--region eu-west-1


watch_s3:
	watch --interval 10 "bash -c 'make events_s3 | head -25'"


output_s3:
	aws cloudformation describe-stacks \
		--stack-name s3-bucket \
		--region eu-west-1 | jq -r '.Stacks[].Outputs'


delete_s3:
	aws cloudformation delete-stack \
		--stack-name s3-bucket \
		--region eu-west-1




validate:
	aws cloudformation validate-template --template-body file://${PWD}/cloudformation/ec2.yml



build:
	aws cloudformation create-stack --template-body file://${PWD}/cloudformation/ec2.yml \
		--stack-name ec2-instance \
		--parameters file://env.json \
		--capabilities CAPABILITY_NAMED_IAM \
		--region eu-west-1


update:
	aws cloudformation update-stack --template-body file://${PWD}/cloudformation/ec2.yml \
		--stack-name ec2-instance \
		--capabilities CAPABILITY_NAMED_IAM \
		--region eu-west-1

events:
	aws cloudformation describe-stack-events \
		--stack-name ec2-instance \
		--region eu-west-1


watch:
	watch --interval 10 "bash -c 'make events | head -25'"


output:
	aws cloudformation describe-stacks \
		--stack-name ec2-instance \
		--region eu-west-1 | jq -r '.Stacks[].Outputs'


delete:
	aws cloudformation delete-stack \
		--stack-name ec2-instance \
		--region eu-west-1



upload_files:
	aws s3 cp ${PWD}/scripts/fluent.conf s3://fluentd-logging-1drf398/files/fluent.conf
	aws s3 cp ${PWD}/scripts/fluent.conf s3://fluentd-logging-1drf398/files/install_fluentd.sh
	aws s3 cp ${PWD}/scripts/fluent.conf s3://fluentd-logging-1drf398/files/install_security_updates.sh
	aws s3 cp ${PWD}/scripts/fluent.conf s3://fluentd-logging-1drf398/files/install_time_sync.sh
