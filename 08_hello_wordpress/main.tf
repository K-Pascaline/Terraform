# Instance configuration
resource "vultr_instance" "wordpress_vm" {
  plan         = "vc2-1c-1gb"
  region       = "fra"
  image_id     = "docker"
  enable_ipv6  = true
  ssh_key_ids  = [vultr_ssh_key.wordpress_vm_key.id]

  user_data = <<-EOF
    #!/bin/bash
    # create directory for docker compose configuration
    mkdir wordpress_setup
    cd wordpress_setup

    # populate docker compose file
    cat <<'EOF_DOCKER_COMPOSE' > docker-compose.yml
version: '3'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    depends_on:
      - mysql
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: MYSQL_PASSWORD
      WORDPRESS_DB_NAME: wordpress

  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: MYSQL_ROOT_PASSWORD
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: MYSQL_PASSWORD
EOF_DOCKER_COMPOSE

    # install Docker
    curl -fsSL http://get.docker.com/ -o get_docker.sh
    sudo sh get_docker.sh

    # install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version

    # Start containers with Docker compose
    docker-compose up -d
EOF
}
