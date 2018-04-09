defmodule Elixir.ReedSolomonErasure.Native do
  use Rustler, otp_app: :elixir_reed_solomon_erasure, crate: :reed_solomon_erasure_native

  def encode(_d, _p, _msg), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
