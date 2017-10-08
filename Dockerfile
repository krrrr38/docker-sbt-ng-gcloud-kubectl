FROM ubuntu:zesty

RUN apt-get update && \
  apt-get install -y apt-transport-https dirmngr ca-certificates curl lsb-release

# sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update && \
  apt-get install -y --no-install-recommends sbt

# npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get update && \
  apt-get install -y --no-install-recommends nodejs

# google cloud sdk, kubectl
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    google-cloud-sdk \
    kubectl

# angular cli
RUN npm install -g @angular/cli && npm cache clean

# docker
RUN curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz && \
    tar -xz -C /tmp -f /tmp/docker.tgz && \
    mv /tmp/docker/* /usr/bin && \
    rm -rf /tmp/docker /tmp/docker.tgz

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*
