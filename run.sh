#!/bin/bash
cd ~/st
sudo docker build -t seeeb/stressmind .
#docker stop stressmind
docker rm stressmind
docker run --name stressmind -d -p 80:3000 seeeb/stressmind
