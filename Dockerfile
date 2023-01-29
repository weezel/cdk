FROM ubuntu:22.10

ARG VERSION=2.61.1

ARG DEPLOY_ENV=${DEPLOY_ENV}
ARG DEBIAN_FRONTEND=noninteractive
ARG ARG_TIMEZONE=UTC
ENV ENV_TIMEZONE=${ARG_TIMEZONE}
RUN echo "$ENV_TIMEZONE" > /etc/timezone \
        && ln -fsn /usr/share/zoneinfo/$ENV_TIMEZONE /etc/localtime

# TAG
# Install CDK from npm and Python venv
RUN apt-get update && \
	apt-get install -y \
		ca-certificates \
		curl \
		make \
		nodejs \
		npm \
		python3-venv \
		unzip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
RUN curl -o awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
	&& unzip awscliv2.zip \
	&& ./aws/install \
	&& rm -rf awscliv2.zip
RUN npm install -g aws-cdk@${VERSION}

# Add directory and unpriveleged user
WORKDIR /opt/cdk
RUN useradd -ms /bin/bash cdk
RUN chown -R cdk: .
# Drop privileges
USER cdk
ENV VIRTUAL_ENV=venv
ENV PATH="$VIRTUAL_ENV/bin:$HOME/.local/bin:$PATH"

ENTRYPOINT ["cdk"]
CMD ["ls"]
