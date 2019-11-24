#!/bin/sh

docker run -itd --name ansibleKiratech -v ${PWD}:/playground -w /playground microsoft/ansible bash
docker cp ${HOME}/.ssh/github_rsa ansibleKiratech:/root/.ssh/id_rsa
docker cp ${HOME}/.ssh/github_rsa.pub ansibleKiratech:/root/.ssh/id_rsa.pub
docker exec ansibleKiratech chmod 644 /root/.ssh/id_rsa.pub
docker exec ansibleKiratech chmod 600 /root/.ssh/id_rsa
docker stop ansibleKiratech
