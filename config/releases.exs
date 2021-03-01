import Config
config :tech_experiments_1, TechExperiments1Web.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT")),
    transport_options: [socket_opts: [:inet6]]
  ]
