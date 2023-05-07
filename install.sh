#!/bin/bash
####################################
# Script to install SSO on Rocky Linux 9
# Creator: Manon Arcas, Guilhem Raffanel & Ahliko
# Version: 1.0
# Date: 2023-05-07
####################################

touch install.log

####################################
# Install Docker
####################################

dnf check-update >>install.log
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo >>install.log
dnf install docker-ce docker-ce-cli containerd.io >>install.log
systemctl start docker >>install.log
systemctl status docker >>install.log

if [ "$(systemctl is-active sshd)" == "active" ]; then
  echo "Docker installed successfully" >>install.log
else
  echo "Docker installation failed ! Check the log" >>install.log
  echo "Auto Install failed ! Check the log file"
  exit 1
fi

systemctl enable docker >>install.log

####################################
# Install SSO
####################################

cp SSO /opt >>install.log
Root="/opt/SSO/"
keycloakRoot="${Root}/keycloak/"
nginxRoot="${Root}/nginx/"
fenrusRoot="${Root}/fenrus/"

openssl genrsa -out "${keycloakRoot}/server.key" 2048 >>"install.log"
openssl req -new -out "${keycloakRoot}/server.csr" -key "${keycloakRoot}/server.key" -config "${keycloakRoot}/openssl.cnf" >>"install.log"
openssl x509 -req -days 3650 -in "${keycloakRoot}/server.csr" -signkey "${keycloakRoot}/server.key" -out "${keycloakRoot}/server.crt" -extensions v3_req -extfile "${keycloakRoot}/openssl.cnf" >>"install.log"
chown 1000:1000 "${keycloakRoot}/server.key" >>"install.log"

openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout "${nginxRoot}/server.key" -out "${nginxRoot}/server.crt" >>"install.log"
chown 1000:1000 "${nginxRoot}/server.key" >>"install.log"
docker network create sso >>install.log
docker network create front >>install.log

docker compose -f "${keycloakRoot}/docker-compose.yml" up -d
docker compose -f "${fenrusRoot}/docker-compose.yml" up -d
docker compose -f "${nginxRoot}/docker-compose.yml" up -d

(
  crontab -l 2>/dev/null
  echo "* 00 * * * 1000 bash /opt/project/keycloak/backup.sh"
) | crontab -

echo "SSO installed successfully check the log file for more information"