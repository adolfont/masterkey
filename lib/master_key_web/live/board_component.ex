defmodule MasterKeyWeb.BoardComponent do
  use MasterKeyWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= for row <- @game.rows do %>
      <div class="flex flex-row bg-gray-100">
        <%= for guess <- row.guess do %>
          <div class="h-12 w-12 rounded-lg shadow-xs text-center px-4 py-2 m-2 <%= "bg-#{color(guess)}" %> ">
            <p class="text-gray-100 opacity-90"> <%= guess %> <p>
          </div>
        <% end %>
        <div class="h-12 w-16 rounded-lg text-center px-4 py-2 m-2 bg-gray-100 flex flex-col flex-wrap">
          <%= for i <- (0)..(row.score.reds), i > 0 do %>
            <svg class="fill-current text-red-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
            </svg>
          <% end %>
          <%= for i <- (0)..(row.score.whites), i > 0 do %>
          <svg class="fill-current text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
          </svg>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end

  defp color(1), do: "pink-600"
  defp color(2), do: "purple-600"
  defp color(3), do: "yellow-500"
  defp color(4), do: "green-600"
  defp color(5), do: "blue-600"
  defp color(6), do: "orange-600"
  defp color(7), do: "red-600"
  defp color(8), do: "gray-800"

end
