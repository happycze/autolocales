module Autolocales
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    enable :caching
    set :public_folder, Proc.new {File.join(root, "assets")} #settings.root
    set :app_dev_mode, settings.environment==:development
    
    # Autolocale
    register Padrino::Contrib::AutoLocale
    set :locales, [:cs, :en]
    set :locale_exclusive_paths, ["/stylesheets","/javascripts","/sessions","/auth", "/unauthenticated"]

    # Warden config
    register Padrino::Warden
    set :auth_success_path, "/" #settings.auth_success_path
    set :auth_error_message, "Please, use valid credentials."

    # Disable CSRF for development environment
    configure :development do
      set :protect_from_csrf, false
    end

    # Default action, render app.erb using default layout (app/views/layouts/application.erb)
    get "/" do
      if warden.authenticated?
        redirect "#{I18n.locale}/authorized"
      else
        render "app"
      end
    end

    get "/authorized" do
      @content="Locale: #{I18n.locale}<br>User: #{user.login}"
      render "app"
    end

    get "/language/:lang/:code" do
      @content="Locale: #{I18n.locale}<br>Language: #{:lang} Code: #{:code}"
      render "app"
    end

    get "/sprache/:lng/:code" do
      @content="Locale: #{I18n.locale}<br>Language: #{:lng} Code: #{:code}"
      render "app"
    end

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end
    #
  end
end
