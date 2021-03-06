# Moonshine No-www

### A plugin for [Moonshine](http://github.com/railsmachine/moonshine)

A plugin for enabled redirect from www subdomain to top domain!

### Instructions

* <tt>script/plugin install git://github.com/railsmachine/moonshine_no_www.git</tt>

* Make sure configuration[:domain] is set to what you really want!

* Invoke the recipe(s) in your Moonshine manifest
    recipe :no_www

=== Example

Say you have foo.com, and you're tired of those pesky w's in your URLs.

First, open up your config/moonshine.yml (or your config/moonshine/production.yml) and make sure that the domain is set to foo.com:

    :domain: foo.com

Next, add domain aliases for the www-version of your domain, in addition to any other domains your app is responsible for:

    :domain_aliases:
      - www.foo.com
      - bar.com
      - www.bar.com
      - baz.com
      - www.baz.com

Finally, open up your application manifest and add the recipe:

    recipe :no_www

Now you should be all good to go!

***

Unless otherwise specified, all content copyright &copy; 2014, [Rails Machine, LLC](http://railsmachine.com)
