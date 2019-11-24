#!/bin/sh
docker run -itd --name ansibleKiratech -v ${PWD}:/playground -w /playground microsoft/ansible bash
docker stop ansibleKiratech
