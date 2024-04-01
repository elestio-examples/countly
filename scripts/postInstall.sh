#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;


docker-compose exec -T countly-frontend bash -c "countly add_user admin ${ADMIN_PASSWORD} ${ADMIN_PASSWORD}"