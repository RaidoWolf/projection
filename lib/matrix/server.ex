defmodule Matrix.Server do
  @moduledoc "HTTP server for hosting Matrix servers"

  def listen(port, scheme) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: scheme,
        plug: Matrix.Server.Endpoint,
        options: [
          port: port
        ]
      )
    ]
    opts = [
      strategy: :one_for_one,
      name: Matrix.Server.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end

end
