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
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Telescope.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:tzdata, "~> 1.0.3"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:finch, "~> 0.3"},
      {:type_check, "~> 0.2.1"},

      # Test/Dev deps
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.4", only: :test},
      {:stream_data, "~> 0.1", only: :test},
      # {:bypass, "~> 1.0", only: :test},
      {:bypass,
       git: "git@github.com:PSPDFKit-labs/bypass.git",
       ref: "8e4b4d82c593ec43da6ef6f74a046b19b249c6a5"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp aliases do
    [
      "ecto.setup": ["ecto.create --quiet", "ecto.migrate"],
      test: ["ecto.setup", "test"],
      "test.watch": ["ecto.setup", "test.watch"]
    ]
  end
end
