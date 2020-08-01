Telescope.Config.preload_all()

ExUnit.start()

ExUnit.configure(exclude: [external: true])

{:ok, _} = Application.ensure_all_started(:ex_machina)
