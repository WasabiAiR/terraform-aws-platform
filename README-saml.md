# SAML Single Sign On

The GrayMeta Platform supports SP initiated SAML logins and has been tested against the following identity providers:

* Okta
* Azure AD

**IMPORTANT NOTE:** Before enabling SAML, please deploy the platform as described in the main README, log into the platform with the `admin@graymeta.com` account, create at least one account that uses an email address that is the same as an email address associated with a user in your identity provider. This new account needs to be assigned the super-user role as once SAML is enabled the local `admin@graymeta.com` account will no longer be able to authenticate.

## Enabling SAML

Before we begin, you must know the URL that your site is deployed at. If you set the `dns_name` variable in the terraform configuration to `foo.example.com`, your endpoint url (from now on referenced as `endpoint`) will be `https://foo.example.com`.

Various URLs that you will need:

* `Assertion Consumer Service (ACS) URL`: `{endpoint}/saml/acs` - also referred to as the Reply URL.
* `Audience URI (SP Entity ID)`: `{endpoint}/saml/metadata`

### OKTA Procedure
1. Create an application in your IDP.  
    * Okta: [SAML Application Setup Overview](https://developer.okta.com/docs/guides/saml-application-setup/overview/)
1. Configure your SAML IDP with the ACS URL and Audience URI/SP Entity ID URLs.
1. Configure the following attribute statements.  Note that these are based on Okta, but adjust as necessary for your IDP:
    * `uid`: `user.id` Unique id for every user
    * `firstname`: `user.firstName`
    * `lastname`: `user.lastName`
    * `email`: `user.email`
    
    If you can't name an attribute exactly as specified (for example if you can't name `firstname` as `firstname`, set the `saml_attr_{attribute}` variable to the name of the attribute. For example, if I couldn't name the `uid` attribute and the IDP set it as `uniqueidentifier`, then set the `saml_attr_uid` variable in the `platform` section of the terraform configration to the value `uniqueidentifier`.
1. Assign users in your IDP to the application.
1. Take a note of the application's `Identity Provider metadata` URL and add it to the `platform` section of your Terraform configuration as the `saml_idp_metadata_url` variable. For Okta this URL is under Sign On -> Settings and looks like `https://dev-855992.okta.com/app/exk1h5wz8k64AyA6F357/sso/saml/metadata`
1. Generate a self-signed x509 certificate:
    ```
    openssl req -x509 -newkey rsa:2048 -keyout myservice.key -out myservice.cert -days 365 -nodes -subj "/CN=myservice.example.com"
    ```
    **NOTE:** the CN of the certificate doesn't matter.
1. base64 encode the certificate:
    ```
    cat myservice.cert | base64 -w0
    ```
    Add this string to the `platform` section of your Terraform configuration as the `saml_cert` variable. If you are using the encrypted blob, feel free to add this information to that configuration instead: `saml_cert={base64 encoded cert}`.
1. base64 encode the key:
    ```
    cat myservice.key | base64 -w0
    ```
    Add this string to the `platform` section of your Terraform configuration as the `saml_key` variable. If you are using the encrypted blob, feel free to add this information to that configuration instead: `saml_key={base64 encoded key}`.

1. Run a `terraform apply` and browse to your `{endpoint}` URL. You should be redirected to your IDP's login screen to begin the authentication process. If you are not redirected and instead are dropped into the application, you may still be logged in as the `admin@graymeta.com` account. If that is the case, click the logout button and you should get redirected to your IDP login screen.

### Azure AD Procedure

1. Create an Enterprise App using the `Integrate any other application you don't find in the gallery` option, then proceed to configure SSO/SAML.

1. Set the Identifier (Entity ID) as `{endpoint}/saml/metadata` 

1. Set the Reply URL (Assertion Consumer Service URL) as `{endpoint}/saml/acs`

1. Configure `Single Sign-On with SAML` in the Azure portal with the following attribute statements, and set your variables in Terraform:
    * `saml_attr_email       = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"` (user.mail)
    * `saml_attr_firstname   = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"` (user.givenname)
    * `saml_attr_lastname    = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"` (user.surname)
    * `saml_attr_uid         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"` (user.objectid)

1. Add the 'App Federation Metadata Url' to the `saml_idp_metadata_url` variable.

1. Generate a self-signed x509 certificate:
    ```
    openssl req -x509 -newkey rsa:2048 -keyout myservice.key -out myservice.cert -days 365 -nodes -subj "/CN=myservice.example.com"
    ```
    **NOTE:** the CN of the certificate doesn't matter.
1. base64 encode the certificate:
    ```
    cat myservice.cert | base64 -w0
    ```
    Add this string to the `platform` section of your Terraform configuration as the `saml_cert` variable. If you are using the encrypted blob, feel free to add this information to that configuration instead: `saml_cert={base64 encoded cert}`.
1. base64 encode the key:
    ```
    cat myservice.key | base64 -w0
    ```
    Add this string to the `platform` section of your Terraform configuration as the `saml_key` variable. If you are using the encrypted blob, feel free to add this information to that configuration instead: `saml_key={base64 encoded key}`.
1. Run a `terraform apply` and browse to your `{endpoint}` URL. You should be redirected to your IDP's login screen to begin the authentication process. If you are not redirected and instead are dropped into the application, you may still be logged in as the `admin@graymeta.com` account. If that is the case, click the logout button and you should get redirected to your IDP login screen.