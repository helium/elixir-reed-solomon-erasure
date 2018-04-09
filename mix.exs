defmodule ElixirReedSolomonErasure.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_reed_solomon_erasure,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers,
      rustler_crates: rustler_crates(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def rustler_crates do
    [reed_solomon_erasure_native: [
      path: "native/reed_solomon_erasure_native",
      mode: rustc_mode(Mix.env)
    ]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:rustler, github: "hansihe/rustler", sparse: "rustler_mix"}]
  end

  defp rustc_mode(:prod), do: :release
  defp rustc_mode(_), do: :debug
end
