STACK_NAME=find-a-tutor

stack: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor)
	sam build \
		--template cloudformation/template.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=$(STACK_NAME) \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/$(STACK_NAME) \
		--s3-bucket sam-artifacts601998595272 \