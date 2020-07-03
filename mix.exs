defmodule Telescope.MixProject do
  use Mix.Project

  def project do
    [
      app: :telescope,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
    [{:jason, "~> 1.2"}, {:tzdata, "~> 1.0.3"}]
  end
end
