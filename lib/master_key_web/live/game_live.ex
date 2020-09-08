defmodule MasterKeyWeb.GameLive do
  use MasterKeyWeb, :live_view

  alias MasterKey.Game
  alias MasterKeyWeb.GuessFormData

  def mount(params, _session, socket) do
    {:ok, build(socket, params)}
  end

  def build(socket, params) do
    socket
    |> board(params)
    |> changeset(%{})
    |> game
  end


  defp board(socket, %{"answer" => answer}) do
    assign(socket, board: Game.new_board(answer))
  end
  defp board(socket, _) do
    assign(socket, board: Game.new_board)
  end

  defp changeset(socket, params) do
    assign(socket, changeset: GuessFormData.changeset(params))
  end

  defp game(socket) do
    assign(socket, game: Game.to_map(socket.assigns.board))
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to MasterKey!</h1>
    """
  end
end
