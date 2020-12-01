defmodule AOC2020.Day01 do
  @doc """
  Find two numbers that sum to 2020
  """
  def solve_p1(arr, two_sum \\ 2_020)

  def solve_p1([], _), do: nil

  def solve_p1([number_1 | tail], two_sum) do
    number_2 = two_sum - number_1

    if Enum.member?(tail, number_2) do
      {number_1, number_2}
    else
      solve_p1(tail, two_sum)
    end
  end

  @doc """
  Find three numbers that sum to 2020
  """
  def solve_p2(arr, three_sum \\ 2020)

  def solve_p2([number_1 | tail], three_sum) do
    two_sum = three_sum - number_1
    # IO.inspect(binding())

    case solve_p1(tail, two_sum) do
      {number_2, number_3} ->
        # IO.inspect(binding())
        {number_1, number_2, number_3}

      _ ->
        solve_p2(tail, three_sum)
    end
  end
end
