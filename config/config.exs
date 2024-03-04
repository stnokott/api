# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :helldivers_2,
  generators: [timestamp_type: :utc_datetime],
  war_season: "801",
  war_seasons: ["801", "805"],
  # default language
  language: :en,
  # all available languages
  languages: [
    en: "en-US",
    de: "de-DE",
    es: "es-ES",
    ru: "ru-RU",
    fr: "fr-FR",
    it: "it-IT",
    pl: "pl-PL"
  ]

# Configures the endpoint
config :helldivers_2, Helldivers2Web.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: Helldivers2Web.ErrorHTML, json: Helldivers2Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: Helldivers2.PubSub,
  live_view: [signing_salt: "zoUaShs4"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
