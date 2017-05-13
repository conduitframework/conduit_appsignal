defmodule ConduitAppsignal.Plug.Event do
  use Conduit.Plug.Builder
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]
  @moduledoc """
  Adds event instrumentation into a conduit pipeline.

  Options:
    * name - Categorization of the event
    * title - Descriptive information about the event

  ## Examples

      plug ConduitAppsignal.Plug.Event, name: "message.deserialize", title: "Deserializing messages"

  """

  def init(opts) do
    if Keyword.get(opts, :name) && Keyword.get(opts, :title) do
      opts
    else
      raise ConduitAppsignal.Error,
        "Must specify a name and title as options to ConduitAppsignal.Plug.Event"
    end
  end

  def call(message, next, opts) do
    instrument(opts[:name], opts[:title], fn ->
      next.(message)
    end)
  end
end
