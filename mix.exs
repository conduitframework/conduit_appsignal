defmodule ConduitAppsignal.Mixfile do
  use Mix.Project

  def project do
    [
      app: :conduit_appsignal,
      version: "0.5.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "ConduitAppsignal",
      source_url: "https://github.com/conduitframework/conduit_appsignal",
      homepage_url: "https://hexdocs.pm/conduit/conduit_appsignal",
      docs: docs(),

      # Package
      description: "A plug to add Appsignal instrumentation to your conduit pipelines.",
      package: package(),

      aliases: ["publish": ["hex.publish", &git_tag/1]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:conduit, "~> 0.8.0"},
      {:appsignal, "~> 1.2"},
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end

  defp package do
    [# These are the default files included in the package
      name: :conduit_appsignal,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Allen Madsen"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/conduitframework/conduit_appsignal",
                "Docs" => "https://hexdocs.pm/conduit_appsignal"}
    ]
  end

  defp docs do
    [
      main: "readme",
      project: "ConduitAppsignal",
      extra_section: "Guides",
      extras: ["README.md"]
    ]
  end

  defp git_tag(_args) do
    tag = "v" <> Mix.Project.config[:version]
    System.cmd("git", ["tag", tag])
    System.cmd("git", ["push", "origin", tag])
  end
end
