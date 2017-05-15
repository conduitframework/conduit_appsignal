defmodule ConduitAppsignal.Plug.Transaction do
  use Conduit.Plug.Builder
  use Appsignal.Instrumentation.Decorators
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]
  @moduledoc """
  Starts an Appsignal transaction and adds receive instrumentation.

  ## Examples

      plug ConduitAppsignal.Plug.Transaction

  """

  @decorate transaction(:background_job)
  def call(message, next, _opts) do
    routing_key = Message.get_header(message, "routing_key")
    title = if routing_key, do: "#{routing_key} -> #{message.source}", else: message.source
    instrument("message.receive", title, fn ->
      next.(message)
    end)
  end
end
