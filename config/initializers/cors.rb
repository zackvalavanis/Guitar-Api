module YourAppName
  class Application < Rails::Application
    # Other configuration...

    # CORS Configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:5173' # Change this to the specific origins you want to allow
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true # Set to false if you don't need credentials
      end
    end
  end
end
