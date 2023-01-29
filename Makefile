VERSION		 = 2.62.1
DOCKER		?= docker
USE_BUILDKIT	?= 1
IMAGE_NAME	?= cdk:${VERSION}
APP_DIR		?= /opt/cdk
AWS_DIR		?= /home/cdk/.aws


build:
	DOCKER_BUILDKIT=${USE_BUILDKIT} ${DOCKER} build -t ${IMAGE_NAME} .

init:
	${DOCKER} run -it --rm \
		-v ${PWD}:${APP_DIR} \
		${IMAGE_NAME} \
		init app --language=python --generate-only

diff:
	${DOCKER} run -it --rm \
		-v ~/.aws:${AWS_DIR} \
		-v ${PWD}:${APP_DIR} \
		${IMAGE_NAME} \
		diff

deploy:
	${DOCKER} run -it --rm \
		-v ~/.aws:${AWS_DIR} \
		-v ${PWD}:${APP_DIR} \
		${IMAGE_NAME} \
		diff

version:
	${DOCKER} run -it --rm ${IMAGE_NAME} cdk --version

shell:
	${DOCKER} run -it --rm \
		-v ${PWD}:${APP_DIR} \
		--entrypoint bash \
		${IMAGE_NAME}

