# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :spiski,
       SpiskiWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "2lF1Ze5fxHdPdSAgvofdCZxdoDNfwbZmpkEuw0q4W3ZnAuKZK2+OvO8VPr+9JMEI",
       render_errors: [
         view: SpiskiWeb.ErrorView,
         accepts: ~w(html json),
         layout: false
       ],
       pubsub_server: Spiski.PubSub,
       live_view: [
         signing_salt: "Z9qqCgWX"
       ]
config :logger,
       backends: [:console, {LoggerFileBackend, :error_log}],
       format: "[$level] $message\n"

config :logger, :error_log,
       path: "/tmp/spiski.log",
       level: :info

config :logger, :console,
       level: :info

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :goth,
       json: "./config/service_account.json"
             |> File.read!


config :elixir_google_spreadsheets,
       :client,
       request_workers: 50,
       recv_timeout: 10_000