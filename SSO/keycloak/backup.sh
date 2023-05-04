echo "[$(date +%Y/%m/%d\ %H:%M:%S)] Démmarrage de la backup" >> /opt/project/keycloak/backup/backup.log
docker exec -i mykeycloak bash  /opt/keycloak/bin/kc.sh export --file /opt/keycloak/data/import/realm-export.json --realm myRealm --users realm_file --db-username=keycloak --db-password=keycloak --db-url-host=postgres && tar -cvf ./realms/[$(date +%Y_%m_%d__%H_%M_%S)].json.tar ./realms/realm-export.json >> /opt/project/keycloak/backup/backup.log
echo "[$(date +%Y/%m/%d\ %H:%M:%S)] Fin de la backup" >> /opt/project/keycloak/backup/backup.log 
