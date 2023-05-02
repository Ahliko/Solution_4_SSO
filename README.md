# **SSO Solution Keycloak**

Keycloak is an authentication and access management solution that centralizes user authentication and authorization across different systems.

# **Summary:**

- [Installation](#installation)
- [Configuration](#configuration)
- [Configuration of Keycloak](#configuration-de-keycloak)
- [Security](#securité)

---

## **Installation:**

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
 2) On Client secret ➜ Secret<br>
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