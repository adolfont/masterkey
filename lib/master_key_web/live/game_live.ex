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
    |> tries
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
    |> tries
    |> changeset(%{})
  end

  defp tries(%{assigns: %{tries: tries}} = socket) when tries > 0 do
    assign(socket, tries: tries - 1)
  end
  defp tries(socket) do
    assign(socket, tries: 10)
  end

  def render(%{game: %{status: :lost}} = assigns) do
    ~L"""
    <h1 class="text-3xl text-purple-700">Try again...</h1>
    <img src="/images/lost.gif">
    <button class="bg-indigo-500 text-white font-medium py-2 px-4 rounded outline-none m-4" phx-click="restart">Play again!</button>
    """
  end

  def render(%{game: %{status: :won}} = assigns) do
    ~L"""
    <h1 class="text-3xl text-purple-700">Amazing!!!</h1>
    <img src="/images/won.gif">
    <button class="bg-indigo-500 text-white font-medium py-2 px-4 rounded outline-none m-4" phx-click="restart">Play again!</button>
    """
  end

  def render(%{game: %{status: :playing}} = assigns) do
    ~L"""
    <h1 class="text-3xl text-purple-700 mb-4 pb-4 border-b-2">Welcome to MasterKey!</h1>
    <%= live_component(@socket, BoardComponent, game: @game) %>
    <div id="guess">
      <%= form_for @changeset, "#", [as: :guess, phx_change: :validate, phx_submit: :guess], fn f -> %>
        <div class="field">
          <label>Guess:
            <%= text_input f, :guess%>
          </label>
          <%= error_tag f, :guess %>
        </div>
        <%= submit "Submit", class: if !@changeset.valid?, do: "opacity-50 cursor-not-allowed" %>
        <div class="shadow-xs text-center px-4 py-2 m-2 <%= "bg-#{color(@tries)}" %> ">
          <p class="text-gray-100 opacity-90"> <%= @tries %> <p>
        </div>
      <% end %>
    </div>
    """
  end

  def handle_event("validate", %{"guess" => params}, socket) do
    {:noreply, changeset(socket, params)}
  end

  def handle_event("guess", _params, %{assigns: %{changeset: %{valid?: false}}} = socket) do
    {:noreply, socket}
  end
  def handle_event("guess", %{"guess" => %{"guess" => params}}, socket) do
    {:noreply, guess(socket, params)}
  end

  def handle_event("restart", _params, socket) do
    {:noreply, build(socket, %{})}
  end

  defp color(tries) when tries > 5, do: "green-600"
  defp color(tries) when tries > 2, do: "yellow-500"
  defp color(tries) when tries > 0, do: "red-600"

end
