#!/bin/bash
cd ~/st
sudo docker build -t seeeb/streesmind .

docker run --name stresmind -it -e VIRTUAL_HOST=stress.lapela.dk -v ~/st:/usr/src/app \
    -e APP_NAME=app \
    -e APP_REPO_URL="https://github.com/sinise/st.git" \
    -e RAILS_ENV=production \
    -e DATABASE_URL="mongo://hao:hao@paulo.mongohq.com:10045/streemind_test" \
    -e SECRET_KEY_BASE="etellerandetsecret"
    zumbrunnen/rails
