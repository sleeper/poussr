require 'poussr/environment'

# Set host for Poussr
Poussr::Environment.configure do |cfg|
  cfg.ws_host "0.0.0.0"
  cfg.ws_port 3031
  cfg.ws_debug true

  cfg.port 3030  # REST API server port
end

