# ConduitAppsignal

A plug to add Appsignal instrumentation to your conduit pipelines.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `conduit_appsignal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:conduit_appsignal, "~> 0.1.0"}]
end
```

## Usage

In your broker, early in an incoming pipeline, include the `ConduitAppsignal.Plug.Transaction`. Early
in an outgoing pipeline include `ConduitAppsignal.Plug.Publish`

``` elixir
# broker.ex
pipeline :in_tracking do
  plug ConduitAppsignal.Plug.Transaction
end

pipeline :out_tracking do
  plug ConduitAppsignal.Plug.Publish
end

incoming MyApp do
  pipe_through [:in_tracking, :error_handling, :deserialize] # Include tracking early

  # subscribes ...
end

outgoing do
  pipe_through [:out_tracking, :serialize] # Include tracking early

  # publishes ...
end
```

In each subscriber:

``` elixir
defmodule MySubscriber do
  use Conduit.Subscriber
  plug ConduitAppsignal.Plug.Subscriber, subscriber: __MODULE__

  # ...
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/conduit_appsignal](https://hexdocs.pm/conduit_appsignal).

