defmodule MasterKeyWeb.BoardComponent do
  use MasterKeyWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="flex flex-row bg-gray-200">
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">1</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">2</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">3</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">4</div>
    </div>
    <div class="flex flex-row bg-gray-200">
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">1</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">2</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">3</div>
      <div class="text-gray-700 text-center bg-gray-400 px-4 py-2 m-2">4</div>
    </div>
    """
  end

end
