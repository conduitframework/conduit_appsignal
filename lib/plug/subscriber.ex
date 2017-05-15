defmodule ConduitAppsignal.Plug.Subscriber do
  use Conduit.Plug.Builder
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]
  @moduledoc """
  Instruments the process function of your subscriber.

  ## Examples

      defmodule MySubscriber do
        use Conduit.Subscriber
        plug ConduitAppsignal.Plug.Subscriber, subscriber: __MODULE__

        # ...
      end
  """

  def opts([subscriber: subscriber]) do
    Macro.to_string(subscriber)
  end

  def call(message, next, subscriber) do
    action = "#{subscriber}.process"
    Appsignal.Transaction.set_action(action)
    instrument("message.process", action, fn ->
      next.(message)
    end)
  end
end
