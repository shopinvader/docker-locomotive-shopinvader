## v4.0.x-20241022
 * add regex support for domain

## v4.0.x-20241015

 * Big update the project, use native steam version (not a fork anymore)
 * Broken deprecated old syntax have been removed
    see: https://github.com/shopinvader/locomotive-shopinvader/commit/335f3cdcba192989af65d7b5056a6376e055ec07
 * Following Variable have changed
   - STORE_ASSET_IN_S3 not needed anymore (duplicated information), just configure your bucket and it will use it
 * Rails 7 filter the domain available
   - the domain that locomotive respond is filtered on the list of domain that exist in the database and a cache of 2 minute exists so when you add a new site, please wait 2 minutes max
     see here: https://github.com/shopinvader/docker-locomotive-shopinvader/blob/70dc0b2dec31d767904690c1eb0752dd172e1865/shopinvader/config/application.rb#L44
   - ALLOWED_DOMAIN => you can add here additionnal domain that you want to allow


## v4.0.x-20201211

 * Update shopinvader lib to solve with_scope in operator with algolia

## v4.0.x-20200630

 * Update dependency
 * Add the recaptcha support on api endpoint of odoo
   in the erp metafields you need to add the field api_required_recaptcha

```
  erp:
    api_required_recaptcha: >
      [{ "method": "POST", "actions": ["lead", "lead/create"]}]
```

## v4.0.X.20200508

 * fix security issue, params where visible in log, remove them

## v4.0.X-20200213

 * fix issue with params in erp tag by updating shopinvader gems

## v4.0.x-20200207

 * fix dynamic rendering of esi_include by updating shopinvader gems

## v4.0.x-20200206

 * fix rendering of esi_include by updating shopinvader gems

## v4.0.x-20200204

 * fix deploying by updating to last version of locomotive engine that force the right version of rack dependency

## v4.0.x-20200128

 * move back to ruby 2.6.5 as dependency (steam) generate warning message, we will move later

## v4.0.x-20200127

 * fix issue with params in liquid tag by using a fork of steam PR is here : https://github.com/locomotivecms/steam/pull/170

## v4.0.x-20200113

 * Big change move to last version of locomotive, this version do not use anymore a liquid fork this have no impact on the templating of website but change a many line in the code source of shopinvader plugin.
 * Move to ruby 2.7
