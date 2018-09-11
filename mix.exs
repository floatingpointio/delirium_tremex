defmodule DeliriumTremex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :delirium_tremex,
      version: "0.1.2",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:ex_doc, "~> 0.16"},
      {:ecto, "~> 2.1"},
      {:gettext, "~> 0.13"},
      {:absinthe, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},
      {:confex, "~> 3.3.1"}
    ]
  end
end
