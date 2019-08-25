defmodule Matrix.Server do
  @moduledoc "HTTP server for hosting Matrix servers"

  @doc "start up an HTTP server to host Matrix"
  def listen_http(port) do
    supervise([
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Matrix.Server.Endpoint,
        options: [port: port]
      )
    ])
  end

  @doc "start up an HTTPS server to host Matrix"
  def listen_https(port, key, cert) do
    supervise([
      Plug.Cowboy.child_spec(
        scheme: :https,
        plug: Matrix.Server.Endpoint,
        options: [
          port: port,
          key: key,
          cert: cert
        ]
      )
    ])
  end

  defp supervise(children) do
    Supervisor.start_link(children, [
      strategy: :one_for_one,
      name: Matrix.Server.Supervisor
    ])
  end

end
