FROM amazoncorretto:17-alpine-jdk

# install maven
ARG MAVEN_VERSION=3.8.6
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries


RUN apk update
RUN apk add curl
RUN apk add bash

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
&& curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
&& rm -f /tmp/apache-maven.tar.gz \
&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"


--COPY settings.xml /root/.m2/settings.xml

#install angular and node
RUN curl -sL https://rpm.nodesource.com/setup_12.x
RUN apk add nodejs
RUN apk add npm
RUN npm -g install -y @angular/cli@14.1.2


WORKDIR /

ENTRYPOINT []
