#!/bin/bash
cd ~/st
sudo docker build -t seeeb/streesmind .
docker run --name stresmind -d -p 80:3000 seeeb/stressmind
