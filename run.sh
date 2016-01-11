#!/bin/bash
cd ~/st
sudo docker build -t seeeb/streesmind .

docker run --name stresmind -d -e VIRTUAL_HOST=stress.lapela.dk -e VIRTUAL_SSL_HOST=stress.lapela.dk -v ~/st:/usr/src/app
