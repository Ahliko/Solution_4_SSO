# **SSO Solution Keycloak**

Keycloak is an authentication and access management solution that centralizes user authentication and authorization across different systems.

# **Summary:**

- [Installation](#installation)
- [Configuration](#configuration)
- [Configuration of Keycloak](#configuration-de-keycloak)
- [Security](#securité)

---

## **Installation:**

Download this project on your server : <br>
```bash
wget https://github.com/Ahliko/Solution_4_SSO/archive/refs/heads/main.zip
```

Unzip the project : <br>
```bash
unzip main.zip
```

Go to the folder : <br>
```bash
cd Solution_4_SSO-main
```

Run the script as **sudo** (Very important): <br>
```bash
sudo bash install.sh
```

You can check the log in the file **install.log** <br>

---

## **Configuration:**
### reverse proxy 

### Host file :
You need to edit your host file on your pc and the following lines :
<ip_server> sso
<ip_server> mykeycloak.tp.b1
<ip_server> myfenrus.tp.b1

### backup db :

---

## **Configuration of Keycloak:**
Most Keycloak configuration is done in the GUI. <br>

### *Admin console:*

To get started, go to the following [link](https://mykeycloak.tp.b1) and click on "*administration console*" you can log in with de **id: admin** and the **password: admin**

- Create a Realm : <br>
master ➜ Create Realm ➜ name : myRealm ➜ Create

- Add user to the Realm : 
you can create as many users as you want <br>

Users ➜ Create new user ➜ put a username ➜ Create ➜ Credentials ➜ Set passsword (PS: don't forget to set Temporary on off)

### *Add identity provider:*

Identity providers ➜ :
- **Github** :
copy the Redirect URL ➜ go to your Github account ➜ Settings ➜ Developer settings ➜ OAuth Apps ➜ New OAuth App : <br>

 1) Put a name
 2) On Homepage URL put ➜ https://mykeycloak.tp.b1/realms/myRealm/account/#/
 3) On Authorization callback URL put ➜ the Redirect URL copied
 4) Tick Enable Device Flow

➜ Register application <br>
You can retrieve the Client ID and the Client secret <br

➜ go back to the GitLab identity provider on Keycloak :
 1) On Client ID put ➜ Application ID
 2) On Client secret ➜ Secret <br>
➜ Add 

- **GitLab** :
copy the Redirect URL ➜ Add ➜ go to your Github account ➜ Preference ➜ Application : <br>

 1) Put a name
 2) On Redirect URL put ➜ the Redirect URL copied
 3) Tick confidential
 4) Tick all of the Scopes

➜ Save application <br>
You can retrieve the Application ID and the secret <br>

➜ go back to the GitLab identity provider on Keycloak :
 1) On Client ID put ➜ Application ID
 2) On Client secret ➜ Secret<br>
➜ Add 

### *Configure Keycloak as an identity provider:*

Create a new client : <br>
Clients ➜ Create : 
- Client ID : <Your-App>
- Client Protocol : openid-connect (Or SAML if you want but OpenID is more secure)
- Name : <Your-App>

Configure the client : <br>
- On the tab **Settings** :
Warning : This configuration is only if the App configure keycloak by itself (like Fenrus who answer a Issuer root url)<br>
 1) Root URL : nothing
 2) Homepage URL : nothing
 3) Valid Redirect URIs : https://* (PS: don't forget the *)
 4) Valid post logout redirect URIs : https://* (PS: don't forget the *)
 5) Web Origins : * (PS: don't forget the *)
 6) Admin URL : * (PS: don't forget the *)
 7) Client Authentification : **ON**
 8) Authorization : **ON**
 9) Authentication Flow : **ON** for all (but if you don't use OAuth 2.0 protocol you can disable it)
 10) Save

- On the tab **Credentials** :
    1) Copy the Client Secret

Configure Your App : <br>
***I put Fenrus as an example, but you can do it with any app who take openid connect protocol<br>***

In the initial configuration of Fenrus : <br>

1) Make Login Strategy : **Oauth**
2) Issuer root url : https://mykeycloak.sso.lab:8443/realms/myRealm
3) Client ID : <Your-Client-Id-App> (check the client id of the client you created)
4) Client Secret : <Your-Client-Secret-App> (check the client secret of the client you created)
5) Don't touch the other fields
6) Save

Configuration is now done :)