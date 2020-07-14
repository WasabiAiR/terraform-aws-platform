# OAuth based storage provider configuration

## Box.com

* Go to https://app.box.com/developers/services
* Click "Create new App"
* Select "Custom App" and select "Next"
* Select "Standard OAuth 2.0 (User Authentication)" and select "Next"
* Give you app a unique name, then select "Create App"
* Select "View your app"
* Under "Oauth 2.0 Credentials" record the Client ID and Client Secret as the `box_com_client_id` and `box_com_secret_key` input Terraform variables.
* Set the Redirect URI to `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on)
* Select "Save Changes"
* Deploy your Terraform environment


## Dropbox

* Go to https://www.dropbox.com/developers/apps
* Select "Create app"
  * Under "Choose an API" select "Dropbox API"
  * Under "Choose the type of access you need" select "Full Dropobx"
  * Give your app a unique name
* Record the "App key" and "Application secret" as the `dropbox_app_key` and `dropbox_app_secret` input Terraform variables.
* Add `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on) as a Redirect URI
* Under the "Status" section, "Apply For Production" to enable all users (not just your account) to use the Dropbox integration
* Deploy your Terraform environment

## Dropbox Teams

* Go to https://www.dropbox.com/developers/apps
* Select "Create app"
  * Under "Choose an API" select "Dropbox Business API"
  * Under "Choose the type of access you need" select "Team member file access"
  * Give your app a unique name
* Record the "App key" and "Application secret" as the `dropbox_teams_app_key` and `dropbox_teams_app_secret` input Terraform variables.
* Add `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on) as a Redirect URI
* Under the "Status" section, "Apply For Production" to enable all users (not just your account) to use the Dropbox integration
* Deploy your Terraform environment

## Onedrive

* Go to https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade
* Select "New registration"
  * Give your app a unique name
  * Under "Supported Account Types" select "Accounts in any organizational directory"
  * Under "Redirect URI" enter in your base URL/connect.  Ex: `https://{dns_name}/connect`
* Record the "Application ID" as the `onedrive_client_id`
* Create client secret under "Certificates & Secrets" and recode as the `onedrive_client_secret`
* Permissions: add the following Graph API permissions as Delegated permissions `User.Read`, `Files.Read`, `offline_access`
* Deploy your Terraform environment

## Sharepoint

* Go to https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade
* Select "New registration"
  * Give your app a unique name
  * Under "Supported Account Types" select "	Accounts in any organizational directory"
  * Under "Redirect URI" enter in your base URL/connect.  Ex: `https://{dns_name}/connect`
* Record the "Application ID" as the `sharepoint_client_id`
* Create client secret under "Certificates & Secrets" and recode as the `sharepoint_client_secret`
* Permissions: add the following Graph API permissions as Delegated permissions.  `User.Read`, `Files.Read`, `offline_access`, `Group.Read.All`
* Deploy your Terraform environment
