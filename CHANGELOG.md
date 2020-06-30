## v4.0.x-20200630

 * Update dependency
 * Add the recaptcha support on api endpoint of odoo
   in the erp metafields you need to add the field api_required_recaptcha

```
  erp:
    api_required_recaptcha: >
      [{ "method": "POST", "actions": ["lead", "lead/create"]}]
``


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
