defmodule ConduitAppsignal do
  @moduledoc """
  Incorporates AppSignal instrumentation into Conduit.
  """

  defmodule Error do
    defexception [:message]
  end
end
