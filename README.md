# Shopinvader container ready for deployment

This is the official container for shopinvader

## How to use this image

In the directory of your choice (not a clone of this repo), create a ```docker-compose.yml``` file with the following content:

```
version: '3'
services:
  db:
    image: mongo:3
    volumes:
      - .db:/data/db
  locomotive:
    environment:
      - LOCOMOTIVE_ENABLE_REGISTRATION=true
      - PASSENGER_APP_ENV=production
      - MONGODB_URI=mongodb://db/shopinvader
      - SECRET_KEY_BASE=generateArealSecretKey
      - DRAGON_FLY_SECRET=generateArealSecretKey
    image: quay.io/akretion/shopinvader
    ports:
      - 8080:80
    volumes:
      - ./data/sites:/home/app/webapp/public/sites
      - ./data/uploaded_assets:/home/app/webapp/public/uploaded_assets
    links:
      - db

```

Create the directory data/sites and data/uploaded_assets for the assets
The user that own this directory must be the user 9999

Run it with ```docker-compose up```. Locomotive is now available on http://localhost:8080



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





# Available Environnement Variables for settings:

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
