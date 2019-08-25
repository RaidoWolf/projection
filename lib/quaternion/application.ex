defmodule Quaternion.Application do
  @moduledoc "Quaternion server main application"

  use Application
  import Matrix.Server
  import Quaternion.Config

  def start(_type, _args) do
    case get_scheme() do
      :http -> listen_http(get_port())
      _ -> listen_https(get_port(), get_key(), get_cert())
    end
  end
end
