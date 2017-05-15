defmodule ConduitAppsignal.Plug.Attempt do
  use Conduit.Plug.Builder
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]
  @moduledoc """
  Adds attempt instrumentation into a conduit pipeline.

  Should be placed after `Conduit.Plug.Retry`.

  ## Examples

      plug Conduit.Plug.Retry
      plug ConduitAppsignal.Plug.Attempt
  """

  def call(message, next, _opts) do
    instrument("message.attempt", message.source, fn ->
      next.(message)
    end)
  end
end
