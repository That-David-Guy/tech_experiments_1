import Config
# This file is run at runtime, not config time
# Because of the way we deploy (double site behind nginx), we don't konw the port until runtime

if (System.get_env("PORT") == nil) do
  raise "Set the port when starting up. e.g. `PORT=4000 mix phx.server`"
end

config :tech_experiments_1, TechExperiments1Web.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT")),
    transport_options: [socket_opts: [:inet6]]
  ]
