## Docker Nginx Cert
- Create and renew website SSL certificates using the Let's Encrypt free certificate authority and its client certbot.

## Development environment

### Build the docker image
```sh
docker compose build
```

### Upload the docker image
```sh
docker compose up
```

## Production environment
- Configure the server_name correctly in the file `./nginx/sites-available/app.conf`
- Launch Docker Swarm
```sh
docker swarm init
```
- Create overlay network for swarm
```sh
docker network create -d overlay --attachable net_swarm
```

- Run the command `sh start_nginx.sh` to carry out all the processes necessary to run the image in the environment
### Creating certificate
- Access the nginx docker container, and then run the following command:
```sh
certbot --nginx
```
- Once this is done, simply follow the information and configure the settings that are requested

### Renew certificate
- Repeat the same step as creating the certificate
