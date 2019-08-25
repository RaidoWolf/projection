defmodule Quaternion.Config do
  @moduledoc false

  @doc "get the configured server URI scheme as an atom (:http or :https), default :https"
  def get_scheme do
    case Application.get_env(:quaternion, :quaternion_scheme, "https") do
      "http" -> :http
      _ -> :https
    end
  end

  @doc "get the configured server port number as an integer, default 8000"
  def get_port do
    String.to_integer(Application.get_env(:quaternion, :quaternion_port, "8000"))
  end

  @doc "get the configured server SSL key as a string"
  def get_key do
    Application.get_env(:quaternion, :quaternion_key, nil)
  end

  @doc "get the configured server SSL certificate as a string"
  def get_cert do
    Application.get_env(:quaternion, :quaternion_cert, nil)
  end

end
