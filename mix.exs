defmodule BinanceSpotRest.MixProject do
  use Mix.Project

  @source_url "https://github.com/Centib/binance_spot_rest"
  @version "0.1.0"

  def project do
    [
      app: :binance_spot_rest,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      consolidate_protocols: Mix.env() == :prod,

      # Hex
      description: "Elixir library for Binance Spot rest api",
      package: package(),

      # Docs
      name: "Binance Spot Rest",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7.12"},
      {:ex_doc, "~> 0.38.1", only: :dev, runtime: false},
      {:req, "~> 0.5.8"},
      {:decimal, "~> 2.3.0"},
      {:numa, "~> 0.1.0"},
      {:loe, "~> 0.1.2"},
      {:valpa, "~> 0.1.0"}
    ]
  end

  defp package do
    [
      maintainers: ["gnjec (Centib)"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(.formatter.exs mix.exs README.md CHANGELOG.md LICENSE.md lib),
      keywords: ["binance", "spot", "rest", "crypto", "api"]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md", "LICENSE.md"],
      source_ref: "v#{@version}",
      source_url: @source_url,
      logo: "assets/logo.svg"
    ]
  end
end
