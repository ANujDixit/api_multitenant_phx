use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :apiEvaluto, ApiEvalutoWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

#configure Bamboo
config :apiEvaluto, ApiEvaluto.Notifications.Mailer,
  adapter: Bamboo.LocalAdapter

# Configure your database
config :apiEvaluto, ApiEvaluto.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "apievaluto_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
