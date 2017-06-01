defmodule ConduitAppsignal.Plug.CaptureError do
  use Conduit.Plug.Builder
  @moduledoc """
  Sets the error for the transaction

  ## Examples

      plug ConduitAppsignal.Plug.CaptureError
  """

  def call(message, next, _opts) do
    next.(message)
  rescue error ->
    error = Exception.normalize(:error, error)
    name = inspect(error.__struct__)
    message = Exception.message(error)
    stacktrace = System.stacktrace

    Appsignal.Transaction.set_error(name, message, stacktrace)

    reraise error, stacktrace
  end
end
