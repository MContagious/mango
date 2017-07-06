use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :mango, Mango.Web.Endpoint,
  secret_key_base: "Dfv44KQU0xWzKkAXw70cWhaZaA2RtFCvRvgRON5p7ti0aKVDwp5DYS4G1w//V4bL"

# Configure your database
config :mango, Mango.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mango_prod",
  pool_size: 15
