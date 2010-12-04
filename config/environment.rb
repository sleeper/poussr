require 'poussr/environment'

# Set host for Poussr
Poussr::Environment.configure do |cfg|
  cfg.ws_host "0.0.0.0"
  cfg.ws_port 8080
  cfg.ws_debug true

  cfg.port 3000  # REST API server port
end

