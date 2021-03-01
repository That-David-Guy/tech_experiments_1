# TechExperiments1

## Domain

[tech-experiments-1.makeawesomestuff.com](tech-experiments-1.makeawesomestuff.com)

## Code analysis

This should run automatically if you have Credo visual studio plugin

`mix credo` or `mix credo --strict`

`--scrict` includes low priority issues

For more details on a particular issue:
`mix credo lib/credo/check.ex:306`

## Debugging

Checking subdomain DNS
`nslookup -type=A tech-experiments-1.makeawesomeworkshop.com`

Check logs in prod (real time)
`ssh tech_experiments_1 journalctl -f`

Check logs in prod (most recent N times)
`ssh tech_experiments_1 journalctl -n 500`

To limit to just your app
`ssh tech_experiments_1 journalctl -n 500 -u tech_experiments_1@4001` (or 4000)


## Deploying

`ssh tech_experiments_1 ./deploy.sh` from you local machine


If you have modified `config/prod.secret.exs` push it to prod with
`scp config/prod.secret.exs tech_experiments_1:~/tech_experiments_1/config/`




To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


