# **Fail2Ban**

## Install and configuration of Fail2Ban :

```bash
sudo dnf update

sudo dnf install fail2ban
```
- add the file [jail.local](/securit%C3%A9/Fail2ban/jail.local) in the directory : /etc/fail2ban/

## Configuration of the notifications on discord (optional): 
- add the file [discord_notifications.conf](/securit%C3%A9/Fail2ban/discord_notifications.conf) in the directory : /etc/fail2ban/

- create a webhook on your discord server :


    ➜ Server Setting ➜ Integrations ➜ Create Webhooks ➜ click on your webhook ➜ Copy Webhook URL

- change the variable "webhook" in the file with the URL

- change the variable "hostname" in the file with your ip

## Start and enable the service :
```bash
sudo systemctl start fail2ban.service

sudo systemctl enable fail2ban.service
```