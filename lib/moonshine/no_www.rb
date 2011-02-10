module Moonshine
  module NoWWW

    def self.included(manifest)
      manifest.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
    end

    def no_www
      if configuration[:passenger]
        rewrite_www = <<-MOD_REWRITE

      # WWW Redirect
      RewriteCond %{HTTP_HOST}   !^www.#{configuration[:domain].gsub('.', '\.')} [NC]
      RewriteCond %{HTTP_HOST}   !^$
      RewriteRule ^/(.*)         http://#{configuration[:domain].gsub('.', '\.')}/$1 [L,R=301]
      MOD_REWRITE
    
        configure(
          {
            :passenger => {
              :vhost_extra => (configuration[:passenger][:vhost_extra] || '') + rewrite_www
            }
          }
        )
      end
      
      if configuration[:ssl]
        rewrite_www_ssl =<<-MOD_REWRITE_SSL

      # SSL WWW Redirect
      RewriteCond %{HTTP_HOST}   !^www.#{configuration[:domain].gsub('.', '\.')} [NC]
      RewriteCond %{HTTP_HOST}   !^$
      RewriteRule ^/(.*)         https://#{configuration[:domain].gsub('.', '\.')}/$1 [L,R=301]
      MOD_REWRITE_SSL

        configure(
          {
            :ssl => {
              :vhost_extra => (configuration[:ssl][:vhost_extra] || '') + rewrite_www_ssl
            }
          }
        )
      end
    end
  end
end