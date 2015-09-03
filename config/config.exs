# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :library, Library.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "dGcjmvsImlFkPvxfrVbPbnVtAZH3E9ZSrIdclRK/i37bxrCVfexo0XAKQp1yZvCe",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Library.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :addict, not_logged_in_url: "/login",  # the URL where users will be redirected to
                db: Library.Repo,
                user: Library.User,
                register_from_email: "Registration <welcome@example.com>", # email registered users will receive from address
                register_subject: "Welcome to yourawesomeapp!", # email registered users will receive subject
                password_recover_from_email: "Password Recovery <no-reply@example.com>",
                password_recover_subject: "You requested a password recovery link",
                email_templates: Library.EmailTemplates # email templates for sending e-mails, more on this further down

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
