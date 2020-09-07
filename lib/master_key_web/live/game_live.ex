defmodule MasterKeyWeb.GameLive do
  use MasterKeyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, params: nil)}
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to MasterKey!</h1>
    """
  end
end
