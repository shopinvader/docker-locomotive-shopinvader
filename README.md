# Shopinvader container ready for deployment

This is the official container for shopinvader

## How to use this image

1. copy the file `docker-compose.yml` of this directory in your project folder
2. copy `.loco-data` folder to your project folder and add ignore its content in .gitignore
3. Run it with ```docker-compose up```.
4. Locomotive is now available on http://localhost:3000


# Develop / Debug

## Static files served from AWS S3

If you are using amazon S3 for storing your asset you need to download them in dev mode.

Before please install aws cli and read the documentation.

In short for installing aws and configuring the api key
```
sudo apt install awscli
aws configure
```

Now let's synchronise the assets

```
aws s3 sync s3://mybucket/sites .loco-data/public/sites
aws s3 sync s3://mybucket/uploaded_assets .loco-data/public/uploaded_assets

```

## Locomotive theme development

The `docker-compose.yml` here provides a `wagon` container as well.
`wagon` is the LocomotiveCMS service to deploy resources to a Locomotive site
or to develop your own theme.

To run it:

```
$ docker-compose run --service-ports wagon gosu ubuntu bash
```
From there you'll be able to run all wagon commands without having to install wagon by yourself.
See https://doc.locomotivecms.com/docs (just skip wagon installation steps).

NOTE: to make wagon work, the docker-compose file should stay inside your Locomotive theme folder.
Otherwise you'll have to change the workspace volume.

# Available Environement Variables

## Locomotive configuration

### ALLOWED_HOSTS

If you want to reach the server with a domain that is not in the list of existing website on your locomotive
you can allow specific domain like this:

```
ALLOWED_HOSTS=foo1.exemple.org,10.10.10.82:3000,localhost:3000
```

### LOCOMOTIVE_ENABLE_REGISTRATION

```
LOCOMOTIVE_ENABLE_REGISTRATION=[true|false] (default: false)
```
Enables self registration on Locomotive admin backend.

### LOCOMOTIVE_ADMIN_SSL_REDIRECT

```
LOCOMOTIVE_ADMIN_SSL_REDIRECT=[true|false] (default: true)
```
Force redirection of admin backend to HTTPS.


## RAILS configuration

### RAILS_ENV
```
RAILS_ENV=[production|development]
```
Tells RoR which kind of env your are working with.

### SECRET_BASE
```
SECRET_KEY_BASE=6810991e8c119bdfe5f4dd[...]d88d1a5bcb69d6ed0cdc19892
```
This key is used to encrypt important data such as cookies and user passwords.
You can generate one by running this command:
```
$ docker-compose run --rm locomotive rake secret
```

As it's used to encode passwords, if you restore a DB locally you must config this otherwise you won't be able login.
The other option is to reset the passwords for admin users.
NOTE: website users are not the same as backend users.

For more info https://medium.com/@michaeljcoyne/understanding-the-secret-key-base-in-ruby-on-rails-ce2f6f9968a1

### DEVISE_PEPPER

```
DEVISE_PEPPER=myExtraSecret
```
This is "a string which is appended onto the password pre-hashing but not stored in the database (unlike salt, which is appended as well but stored with the password in the DB); and cost, a measure of how secure the hash should be (see the docs). Both of these are static and you can hard-code them into your non-Devise app (but make sure to keep pepper secret!)."

For more information:

* https://stackoverflow.com/questions/45988723/what-password-hashing-algorithm-does-devise-use
* https://github.com/plataformatec/devise/blob/88724e10adaf9ffd1d8dbfbaadda2b9d40de756a/lib/devise/encryptor.rb


### DRAGON_FLY_SECRET

```
DRAGON_FLY_SECRET=b75886dec470b846594[...]fe3e7a244b61242b6cec04
```
This key is used to used to generate the protective SHA.
See dragonfly configuration for more information: http://markevans.github.io/dragonfly/configuration
You can generate one by running this command:
```
$ docker-compose run --rm locomotive rake secret
```

### RAILS_SERVE_STATIC_FILES

```
RAILS_SERVE_STATIC_FILES=[true|false] (default: false)
```

## MongoDB configuration

MONGODB_URI
MONGODB_MAX_POOL_SIZE (default: 5)

## PUMA configuration

```
PUMA_MIN_THREAD
PUMA_MAX_THREAD
PUMA_WORKER
PUMA_AUTH_TOKEN
PUMA_MAX_RAM (default 4096Mo)
```

## Configuration for storing the asset in amazon S3

```
S3_BUCKET
S3_KEY_ID
S3_SECRET_KEY
S3_BUCKET_REGION
S3_ASSET_HOST_URL
S3_CACHE_CONTROL
S3_ENDPOINT (optionnal: usefull when using S3 compatible provider)
S3_PATH_STYLE (optionnal: required by some S3 compatible provider like Minio)
```

## SMTP configuration

```
SMTP_ENABLE_STARTTLS_AUTO (default True)
SMTP_HELO_DOMAIN
SMTP_ADDRESS
SMTP_PORT
SMTP_SENDER
SMTP_USERNAME
SMTP_PASSWORD
SMTP_AUTHENTICATION (default plain)
```

## Sentry configuration

```
SENTRY_DSN
```

## Rake task

Locomotive include several maintance task based on rake

You can list all of them using

```
rake -T

```

### Index generation
```
rake db:mongoid:create_indexes
```

### Purge old session

In mongo db sheeh you can purge the old session using (TODO we should do a rake task)

```
db.getCollection("sessions").deleteMany({"updated_at": {$lt:ISODate("2023-12-06")}})
```



# TODO
- improve configuration of allowed lang in front and limitation of indexing with mongodb
- improve log managment (ready for kibana)
