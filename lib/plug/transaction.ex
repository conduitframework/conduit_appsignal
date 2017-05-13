defmodule ConduitAppsignal.Plug.Transaction do
  use Conduit.Plug.Builder
  use Appsignal.Instrumentation.Decorators
  @moduledoc """
  Starts an Appsignal transaction. This should be early in your pipeline.

  ## Examples

      plug ConduitAppsignal.Plug.Transaction

  """

  @decorate transaction(:background_job)
  def call(message, next, _opts) do
    next.(message)
  end
end
