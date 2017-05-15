defmodule ConduitAppsignal.Plug.Publish do
  use Conduit.Plug.Builder
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]
  @moduledoc """
  Adds publish instrumentation into a conduit pipeline.

  ## Examples

      plug ConduitAppsignal.Plug.Publish
  """

  def call(message, next, _opts) do
    instrument("message.publish", message.destination, fn ->
      next.(message)
    end)
  end
end
