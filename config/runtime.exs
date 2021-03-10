import Config
# This file is run at runtime, not config time
# Because of the way we deploy (double site behind nginx), we don't konw the port until runtime
config :tech_experiments_1, TechExperiments1Web.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT")),
    transport_options: [socket_opts: [:inet6]]
  ]
