# Shopinvader container ready for deployment

This is the official container for shopinvader

## How to use this image

Copy the file docker-compose.yml of this directory
create the directy tmp, log, public/sites, public/uploaded_assets

Run it with ```docker-compose up```. Locomotive is now available on http://localhost:300



# Develop / Debug

If you are using amazon S3 for storing your asset you need to download them in dev mode

Before please install aws cli and read the documentation

In short for installing aws and configuring the api key
```
sudo apt install awscli
aws configure
```

Now let's synchronise the assets

```
aws s3 sync s3://mybucket/sites public/sites
aws s3 sync s3://mybucket/uploaded_assets public/uploaded_assets

```

# TODO
- add an environment example file with documentation
- add an environment dev file
- improve log managment (ready for kibana)

# Available Environnement Variables for settings:

## RAILS configuration
RAILS_ENV
MONGODB_URI
SECRET_KEY_BASE

DEVISE_PEPPER (for more information : https://stackoverflow.com/questions/45988723/what-password-hashing-algorithm-does-devise-use and https://github.com/plataformatec/devise/blob/88724e10adaf9ffd1d8dbfbaadda2b9d40de756a/lib/devise/encryptor.rb)

DRAGON_FLY_SECRET
LOCOMOTIVE_ENABLE_REGISTRATION  (true or false)


## PUMA configuration
PUMA_MIN_THREAD
PUMA_MAX_THREAD
PUMA_WORKER
PUMA_AUTH_TOKEN


## Configuration for storing the asset in amazon S3
STORE_ASSET_IN_S3  (true or false)
S3_BUCKET
S3_KEY_ID
S3_SECRET_KEY
S3_BUCKET_REGION
S3_ASSET_HOST_URL
S3_CACHE_CONTROL

## SMTP configuration
SMTP_ENABLE_STARTTLS_AUTO (default True)
SMTP_ADDRESS
SMTP_PORT
SMTP_SENDER
SMTP_USERNAME
SMTP_PASSWORD

## Sentry configuration
SENTRY_DSN
