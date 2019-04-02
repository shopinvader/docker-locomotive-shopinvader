# Be sure to restart your server when you modify this file.

# TODO it will be great if we can use the cookie_store
# instead of mongoid_store
# but for this we need to review the way to store the
# cart cache. Currently it's stored in the cookie

Rails.application.config.session_store(
  :mongoid_store,
  key: '_station_session',
  expire_after: 2.years,
)
