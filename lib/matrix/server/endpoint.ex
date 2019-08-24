defmodule Matrix.Server.Endpoint do
  @moduledoc false

  use Plug.Router

  # log to plug logger
  plug(Plug.Logger)
  # match routes
  plug(:match)
  # send JSON to HTTPoison
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # dispatch routes
  plug(:dispatch)

  get "/" do
    {status, body} =
      case conn.body_params do
        %{"events" => events} -> {200, process_events(events)}
        _ -> {400, missing_events()}
      end

    send_resp(conn, status, body)
  end

  defp process_events(events) when is_list(events) do
    Poison.encode!(%{
      data: "Received Events!"
    })
  end

  defp process_events(_) do
    Poison.encode!(%{
      data: "No events received."
    })
  end

  defp missing_events do
    Poison.encode!(%{
      errors: [
        "Expected Payload: {events:[...]}"
      ]
    })
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

end
