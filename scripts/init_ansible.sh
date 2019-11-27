#!/bin/sh

set -e

docker run -itd --name ansible -v ${PWD}:/playground -w /playground microsoft/ansible bash
docker cp ${HOME}/.ssh/${1:-id_rsa} ansible:/root/.ssh/id_rsa
docker cp ${HOME}/.ssh/${1:-id_rsa}.pub ansible:/root/.ssh/id_rsa.pub
docker exec ansible chmod 644 /root/.ssh/id_rsa.pub
docker exec ansible chmod 600 /root/.ssh/id_rsa
docker exec ansible pip install -U ansible
docker stop ansible
