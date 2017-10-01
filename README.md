# Shopinvader container ready for deployment

This is the official container for shopinvader



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


# List Environnement Variable

#TODO find a simple way to auto document them


PASSENGER_APP_ENV
MONGODB_URI

SECRET_KEY_BASE

STORE_ASSET_IN_S3
S3_BUCKET
S3_KEY_ID
S3_SECRET_KEY
S3_BUCKET_REGION
S3_ASSET_HOST_URL
S3_CACHE_CONTROL

SMTP_ADDRESS
SMTP_PORT
SMTP_SENDER
SMTP_USERNAME
SMTP_PASSWORD

DEVISE_PEPPER

DRAGON_FLY_SECRET

LOCOMOTIVE_ENABLE_REGISTRATION  (true or false)

SENTRY_DSN
