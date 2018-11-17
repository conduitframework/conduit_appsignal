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

  def init([subscriber: _] = opts) do
    opts
  end

  def call(message, next, opts) do
    action = "#{inspect(opts[:subscriber])}.process"
    Appsignal.Transaction.set_action(action)
    instrument("message.process", action, fn ->
      next.(message)
    end)
  end
end
