defmodule Telescope.MixProject do
  use Mix.Project

  def project do
    [
      app: :telescope,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      compilers: [:phoenix, :gettext] ++ Mix.compilers()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: extra_applications(Mix.env()),
      mod: {Telescope.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:finch, "~> 0.3"},
      {:skogsra, "~> 2.2"},
      {:phoenix, "~> 1.5.4"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_live_view, "~> 0.13.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 2.0"},
      {:g, path: "./gleam", manager: :rebar3},

      # Test/Dev deps
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.4", only: :test},
      {:bypass,
       git: "git@github.com:PSPDFKit-labs/bypass.git",
       ref: "8e4b4d82c593ec43da6ef6f74a046b19b249c6a5",
       only: :test},
      {:floki, ">= 0.0.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp extra_applications(:test), do: [:logger]
  defp extra_applications(_env), do: [:logger, :os_mon]

  defp aliases do
    [
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["cmd docker-compose up -d", "ecto.create", "ecto.migrate"],
      format: ["format", "cmd gleam format gleam"],
      setup: ["deps.get", "ecto.setup", "cmd yarn install --cwd assets"],
      test: ["ecto.setup", "test", "cmd (cd gleam && ~/.mix/rebar3 eunit)"]
    ]
  end
end
