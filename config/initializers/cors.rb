Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :patch, :put, :options]
  end
end