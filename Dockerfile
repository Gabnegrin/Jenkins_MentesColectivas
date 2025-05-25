FROM jenkins/jenkins:jdk21

USER root


RUN apt-get update && apt-get install -y \
    lsb-release \
    python3-pip \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common

#para insstalar docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli

#agregar compose
RUN curl -SL https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


RUN apt-get install -y git

USER jenkins

#blueocean, de normal se ve re feo
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow docker-plugin pipeline-utility-steps"