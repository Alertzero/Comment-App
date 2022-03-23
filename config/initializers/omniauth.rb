OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.full_host = Rails.env.production? ? 'https://secret-eyrie-95727.herokuapp.com' : 'http://localhost:3000'
OmniAuth.config.allowed_request_methods = %i[get]