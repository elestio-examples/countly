#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./mongodb_data
chown -R 1001:1001 ./mongodb_data


sed -i "s~EMAIL_TO_CHANGE~${FROM_EMAIL}~g" ./mail.js