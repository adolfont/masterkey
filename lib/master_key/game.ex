defmodule MasterKey.Game do
  defstruct [:status, :rows]
  alias MasterKey.Game.{Board, Score}
  def new_board() do
    Board.new()
  end

  def new_board(answer) do
    answer
    |> to_numbers()
    |> Board.new()
  end

  def guess(board, guess) do
    Board.guess(board, to_numbers(guess))
  end

  defp to_numbers(guess) do
    guess
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def to_map(board) do
    __struct__(status: Board.status(board), rows: turns(board))
  end

  defp turns(board) do
    Enum.map(board.guesses, &to_score(&1, board.answer))
  end

  # TODO - write tests to not accept (answer, guess) as valid params
  # I was stuck for hours because I was passing the parameters in the opposite order.
  # When we compare the guess with the answer, the zip function compares if both are equivalent disregarding the position,
  # so the tests were passing even with the parameters reversed.
  defp to_score(guess, answer) do
    %{guess: guess, score: Score.new(answer, guess)}
  end

end
