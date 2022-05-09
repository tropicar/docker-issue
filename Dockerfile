# Build binaries
#####################################
FROM node:14.17.6-alpine as build-binaries

RUN apk add --no-cache bind-tools docker


# Final state
FROM node:14.17.6-alpine

# ENV DOCKER_COMPOSE_VERSION 1.25.5
WORKDIR /usr/local/bin

RUN apk add --no-cache curl bind-dev xz libltdl miniupnpc zip unzip dbus bind 

# RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-$(uname -m) > /usr/local/bin/docker-compose \
#     && chmod +x /usr/local/bin/docker-compose

RUN curl -L https://github.com/docker/compose/releases//download/v2.5.0/docker-compose-Linux-$(uname -m) > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

COPY ./files .
COPY --from=build-binaries /usr/bin/docker .

# Required for executing docker-compose binary addgroup & adduser
#RUN usermod -aG docker root
# RUN addgroup -g 1414 docker
# RUN adduser root -G docker 


# It's mandatory to define this environment variables
ENV COMPOSE_HTTP_TIMEOUT=300 \
    DOCKER_CLIENT_TIMEOUT=300 \
    DOCKER_HOST=unix:///var/run/docker.sock 

#CMD ["docker-compose -f /usr/src/app/docker-compose.yml up -d --force-recreate"]
#CMD ["/usr/local/bin/docker-compose -f /app/docker-compose.yml up -d --force-recreate"]
ENTRYPOINT [ "/bin/sh", "-c", "exec /usr/local/bin/docker-compose -f /usr/local/bin/docker-compose.yml up -d --force-recreate" ]
# curl -XPOST --unix-socket /var/run/docker.sock -d -H 'Content-Type: application/json' http://localhost/containers/json
#CMD ["top"]