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

    tags = %{
      source: message.source,
      destination: message.destination,
      user_id: message.user_id,
      correlation_id: message.correlation_id,
      message_id: message.message_id
    }

    environment =
      Map.merge(
        %{
          content_type: message.content_type,
          content_encoding: message.content_encoding,
          created_by: message.created_by,
          created_at: message.created_at
        },
        message.headers
      )

    custom = %{
      assigns: message.assigns,
      private: message.private
    }
    
    action
    |> Appsignal.Transaction.set_action()
    |> Appsignal.Transaction.set_sample_data("environment", environment)
    |> Appsignal.Transaction.set_sample_data("tags", tags)
    |> Appsignal.Transaction.set_sample_data("params", message.body)
    |> Appsignal.Transaction.set_sample_data("custom_data", custom)

    instrument("message.process", action, fn ->
      next.(message)
    end)
  end
end
