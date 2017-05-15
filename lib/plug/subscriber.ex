defmodule ConduitAppsignal.Plug.Subscriber do
  use Conduit.Plug.Builder
  @moduledoc """
  Instruments the process function of your subscriber.

  ## Examples

      defmodule MySubscriber do
        use Conduit.Subscriber
        plug ConduitAppsignal.Plug.Subscriber

        # ...
      end
  """

  def call(message, next, _opts) do
    action = "#{Macro.to_string(__MODULE__)}.process"
    Appsignal.Transaction.set_action(action)
    instrument("message.process", action, fn ->
      next.(message)
    end)
  end
end
