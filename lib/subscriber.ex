defmodule ConduitAppsignal.Subscriber do
  @moduledoc """
  Instruments the process function of your subscriber.

  ## Examples

      defmodule MySubscriber do
        use Conduit.Subscriber
        use ConduitAppsignal.Subscriber
      end
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Appsignal.Instrumentation.Helpers, only: [instrument: 3]

      def call(message, next, opts) do
        action = "#{Macro.to_string(__MODULE__)}.process"
        Appsignal.Transaction.set_action(action)
        instrument("message.process", action, fn ->
          process(message, opts)
        end)
      end
    end
  end
end
