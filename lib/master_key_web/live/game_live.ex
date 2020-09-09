defmodule MasterKeyWeb.GameLive do
  use MasterKeyWeb, :live_view

  alias MasterKey.Game
  alias MasterKeyWeb.{BoardComponent, GuessFormData}

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
    assign(socket, board: Game.new_board())
  end

  defp changeset(socket, params) do
    assign(socket, changeset: GuessFormData.changeset(params))
  end

  defp game(socket) do
    assign(socket, game: Game.to_map(socket.assigns.board))
  end

  defp guess(socket, guess) do
    socket
    |> assign(board: Game.guess(socket.assigns.board, guess))
    |> game
  end

  def render(%{game: %{status: :lost}} = assigns) do
    ~L"""
    <button class="" phx-click="restart">Play again!</button>
    """
  end

  def render(%{game: %{status: :win}} = assigns) do
    ~L"""
    <button class="" phx-click="restart">Play again!</button>
    """
  end

  def render(%{game: %{status: :playing}} = assigns) do
    ~L"""
    <h1 class="text-3xl text-purple-700">Welcome to MasterKey!</h1>
    <%= live_component(@socket, BoardComponent, game: @game) %>
    <div id="guess">
    <%= form_for @changeset, "#", [as: :guess, phx_change: :validate, phx_submit: :guess], fn f -> %>
      <div class="field">
        <label>Guess:
          <%= text_input f, :guess %>
        </label>
        <%= error_tag f, :guess %>
      </div>
      <%= submit "Submit", disabled: !@changeset.valid? %>
    <% end %>
    </div>
    """
  end

  def handle_event("validate", %{"guess" => params}, socket) do
    {:noreply, changeset(socket, params)}
  end
  def handle_event("guess", %{"guess" => %{"guess" => params}}, socket) do
    {:noreply, guess(socket, params)}
  end
  def handle_event("restart", _params, socket) do
    {:noreply, build(socket, %{})}
  end
end
