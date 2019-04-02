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

# Varnish will drop all cookie session for get method
# this mean that we will have a lot of request without any session cookie
# generating a cookie even if the session is empty

module ActionDispatch
  module Session
    class MongoStoreBase
      alias_method :orig_write_session, :write_session

      def write_session(req, sid, session_data, options)
        if session_data.size > 0
          orig_write_session(req, sid, session_data, options)
        else
          delete_session(req, sid, options)
          'nosession'
        end
      end

    end
  end
end
