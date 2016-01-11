docker run --name app -it -p 80:80 \
    -e APP_NAME=app \
    -e APP_REPO_URL="https://github.com/sinise/st.git" \
    -e RAILS_ENV=production \
    -e DATABASE_URL="mongo://hao:hao@paulo.mongohq.com:10045/streemind_test" \
    -e SECRET_KEY_BASE="yoursecretkeybaseforproduction"
    zumbrunnen/rails
