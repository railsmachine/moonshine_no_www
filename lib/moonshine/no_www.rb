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
        rewrite_section = <<-MOD_REWRITE
 # WWW Redirect
 RewriteCond %{HTTP_HOST}  ^www\.(.*) [NC]
 RewriteRule               ^(.*)$ http://%1$1 [L,R=301]
MOD_REWRITE
    
        configure :passenger => {
                    :vhost_extra => (configuration[:passenger][:vhost_extra] || '') + rewrite_section
                  }
      end
      
      if configuration[:ssl]
        rewrite_section = <<-MOD_REWRITE_SSL
          # SSL WWW Redirect
          RewriteCond %{HTTP_HOST}  ^www\.(.*) [NC]
          RewriteRule               ^(.*)$ https://%1$1 [L,R=301]
        MOD_REWRITE_SSL

        configure :ssl => {
                    :vhost_extra => (configuration[:ssl][:vhost_extra] || '') + rewrite_section
                  }
      end
    end
  end
end