defmodule MasterKeyWeb.BoardComponent do
  use MasterKeyWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= for row <- @game.rows do %>
      <div class="flex flex-row bg-gray-200">
        <%= for guess <- row.guess do %>
        <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">
          <%= guess %>
        </div>
        <% end %>
      </div>
    <% end %>
    """
  end



end
