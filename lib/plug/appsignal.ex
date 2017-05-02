defmodule ConduitAppsignal.Plug.Appsignal do
  use Conduit.Plug.Builder
  use Appsignal.Instrumentation.Decorators

  @decorate transaction(:background_job)
  def call(message, next, _opts) do
    next.(message)
  end
end
