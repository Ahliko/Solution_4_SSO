#!/bin/bash
####################################
# Script to backup keycloak, work on Rocky Linux 9
# Creator: Manon Arcas, Guilhem Raffanel & Ahliko
# Version: 1.0
# Date: 2023-05-07
####################################

echo "[$(date +%Y/%m/%d\ %H:%M:%S)] Démmarrage de la backup" >> "backup.log"
docker exec -i mykeycloak bash  /opt/keycloak/bin/kc.sh export --file /opt/keycloak/data/import/realm-export.json --realm myRealm --users realm_file --db-username=keycloak --db-password=keycloak --db-url-host=postgres && tar -cvf ./realms/["$(date +%Y_%m_%d__%H_%M_%S)"].json.tar ./realms/realm-export.json >> "backup.log"
echo "[$(date +%Y/%m/%d\ %H:%M:%S)] Fin de la backup" >> "backup.log"
