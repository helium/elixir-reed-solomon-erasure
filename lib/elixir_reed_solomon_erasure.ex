defmodule ElixirReedSolomonErasure do
  def encode(data_shards, parity_shards, msg) do
    Elixir.ReedSolomonErasure.Native.encode(data_shards, parity_shards, msg)
  end
end
