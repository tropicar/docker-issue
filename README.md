# docker-issue-recreate

The purpose of this repo is to recreate the issue of not setup the memory limitation.

To use this repo simply:

Download the repo:
`git clone https://github.com/tropicar/docker-issue-recreate.git`

Build the docker compose:
`docker-compose build`

Up the container with the detach option:
`docker-compose up -d`

Check if the limitations are set up:
`docker stats`
