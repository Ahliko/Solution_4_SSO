# **NetData**

## Install and configure NetData :

run this [script](/securit%C3%A9/NetData/netdata_script.sh) with sudo :
```bash
sudo bash netdata_script.sh
```

## Configuration of the notifications on discord (optional): 

- create a webhook on your discord server :


    ➜ Server Setting ➜ Integrations ➜ Create Webhooks ➜ click on your webhook ➜ Copy Webhook URL

- edit the file *health_alarm_notify.conf* with the command :
```bash
cd /etc/netdata/
sudo bash edit-config health_alarm_notify.conf
```
- Set SEND_DISCORD to YES.

- Set DISCORD_WEBHOOK_URL to the webhook URL.

- Set DEFAULT_RECIPIENT_DISCORD to the channel you want the alert notifications to be sent to.

## Start and enable the service :
```bash
sudo systemctl start fail2ban.service

sudo systemctl enable fail2ban.service
```