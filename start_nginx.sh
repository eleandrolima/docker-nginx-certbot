docker compose -f docker-swarm.yml build &&
echo "image built for execution" &&
docker stack rm nginx &&
echo "removed any nginx stack in the docker environment" &&
docker stack deploy --compose-file=docker-swarm.yml nginx &&
echo "stack docker swarm deployed"