defmodule MasterKey.Game.Board do
  defstruct [:answer, guesses: []]

  def new do
    __struct__(answer: random_answer())
  end

  def new(answer) do
    __struct__(answer: answer)
  end

  defp random_answer do
    Enum.take_random(1..8, 4)
  end

  def guess(board, guess) do
    %{board | guesses: [guess | board.guesses]}
  end
  

end
