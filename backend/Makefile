main: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor)
	sam build \
		--template cloudformation/template.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=find-a-tutor \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/find-a-tutor \
		--s3-bucket sam-artifacts601998595272 \

forum: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor Forum)
	sam build \
		--template cloudformation/forum.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=find-a-tutor-forum \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/find-a-tutor-forum \
		--s3-bucket sam-artifacts601998595272 \

notes: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor Notes)
	sam build \
		--template cloudformation/notes.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=find-a-tutor-notes \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/find-a-tutor-notes \
		--s3-bucket sam-artifacts601998595272 \

courses: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor Courses)
	sam build \
		--template cloudformation/courses.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=find-a-tutor-courses \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/find-a-tutor-courses \
		--s3-bucket sam-artifacts601998595272 \

courses_classes: ##=> Updates the stack on aws
	$(info [*] Updating Find a Tutor Courses Classes)
	sam build \
		--template cloudformation/courses_classes.yaml \
		--use-container

	sam deploy \
		--capabilities=CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset \
		--stack-name=find-a-tutor-courses-classes \
		--template-file .aws-sam/build/template.yaml \
		--s3-prefix sam/find-a-tutor-courses-classes \
		--s3-bucket sam-artifacts601998595272 \