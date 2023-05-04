touch install.log

####################################
# Install Docker
####################################

dnf check-update >> install.log
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo >> install.log
dnf install docker-ce docker-ce-cli containerd.io >> install.log
systemctl start docker >> install.log
systemctl status docker >> install.log
systemctl enable docker >> install.log

####################################
# Install SSO
####################################

cp SSO /opt >> install.log
Root="/opt/SSO/"
keycloakRoot="${Root}/keycloak/"
nginxRoot="${Root}/nginx/"
fenrusRoot="${Root}/fenrus/"

openssl genrsa -out "${keycloakRoot}/server.key" 2048 >> "install.log"
openssl req -new -out "${keycloakRoot}/server.csr" -key "${keycloakRoot}/server.key" -config "${keycloakRoot}/openssl.cnf" >> "install.log"
openssl x509 -req -days 3650 -in "${keycloakRoot}/server.csr" -signkey "${keycloakRoot}/server.key" -out "${keycloakRoot}/server.crt" -extensions v3_req -extfile "${keycloakRoot}/openssl.cnf" >> "install.log"

docker network create sso >> install.log
docker network create front >> install.log

docker compose -f "${keycloakRoot}/docker-compose.yml" up -d
docker compose -f "${fenrusRoot}/docker-compose.yml" up -d
docker compose -f "${nginxRoot}/docker-compose.yml" up -d
