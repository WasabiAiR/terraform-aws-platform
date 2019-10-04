# SAML Single Sign On

The GrayMeta Platform supports SP initiated SAML logins and has been tested against the following identity providers:

* Okta

**IMPORTANT NOTE:** Before enabling SAML, please deploy the platform as described in the main README, log into the platform with the `admin@graymeta.com` account, create at least one account that uses an email address that is the same as an email address associated with a user in your identity provider. This new account needs to be assigned the super-user role as once SAML is enabled the local `admin@graymeta.com` account will no longer be able to authenticate.

## Enabling SAML

Before we begin, you must know the URL that your site is deployed at. If you set the `dns_name` variable in the terraform configuration to `foo.example.com`, your endpoint url (from now on referenced as `endpoint`) will be `https://foo.example.com`.

Various URLs that you will need:

* `Assertion Consumer Service (ACS) URL`: `{endpoint}/saml/acs`
* `Audience URI (SP Entity ID)`: `{endpoint}/saml/metadata`

### Procedure

1. Create an application in your IDP. Take a note of the application's IDP Metadata URL and add it to the `platform` section of your Terraform configuration as the `saml_idp_metadata_url` variable. For Okta this URL looks like `https://dev-855992.okta.com/app/exk1h5wz8k64AyA6F357/sso/saml/metadata`
1. Configure your SAML IDP with the ACS URL and Audience URI/SP Entity ID URLs.
1. Configure the following attribute statements. Note that these are based on Okta, but adjust as necessary for your IDP:
    * `uid` - A unique ID for the user that won't change. Usernames are a poor choice as they often use first and last names which can change.
    * `firstname` - A user's first name.
    * `lastname`: `user.lastName`
    * `email`: `user.email`
    If you can't name an attribute exactly as specified (for example if you can't name `firstname` as `firstname`, set the `saml_attr_{attribute}` variable to the name of the attribute. For example, if I couldn't name the `uid` attribute and the IDP set it as `uniqueidentifier`, then I'd set the `saml_attr_uid` variable in the `platform` section of the terraform configration to the value `uniqueidentifier`.
1. Assign users in your IDP to the application.
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
