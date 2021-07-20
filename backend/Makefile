STACK_NAME=find-a-tutor

stack: ##=> Updates the stack on aws
	$(info [*] Updating CLI pipeline)
	sam build \
		--template cloudformation/template.yaml \
		--use-container

	sam package \
		--s3-prefix sam/$(STACK_NAME) \
		--template-file .aws-sam/build/template.yaml \
		--output-template-file cloudformation/packaged.yaml

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=$(STACK_NAME) \
		--template-file=cloudformation/packaged.yaml

	rm -f cloudformation/packaged.yaml