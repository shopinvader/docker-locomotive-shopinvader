# Be sure to restart your server when you modify this file.

Rails.application.config.session_store(
  :mongoid_store,
  expire_after: 2.years
)
