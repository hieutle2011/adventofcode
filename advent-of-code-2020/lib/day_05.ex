defmodule AOC2020.Day05 do
  @moduledoc """
  Module Day 4
  """

  @doc """
  Find the largest seat id
  """
  def solve_p1(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce({1_000, 0, []}, &reducer_p1/2)
  end

  def reducer_p1(codes, {minimum, maximum, ids}) do
    id = get_seat_id(codes)
    max_id = if id >= maximum, do: id, else: maximum
    min_id = if id <= minimum, do: id, else: minimum
    {min_id, max_id, [id | ids]}
  end

  @doc """
  Solution for part 2. Find missing id where id+1 and id-1 in the list
  """
  def find_my_seat_id(path) do
    {minimum, maximum, ids} = AOC2020.Day05.solve_p1(path)
    for id <- minimum..maximum, condition?(id, ids), do: id
  end

  def condition?(id, ids) do
    Enum.member?(ids, id - 1) and Enum.member?(ids, id + 1) and not Enum.member?(ids, id)
  end

  def get_seat_id(codes) when byte_size(codes) == 10 do
    {row_codes, column_codes} = codes |> String.split_at(7)
    find_row(row_codes) * 8 + find_column(column_codes)
  end

  def find_row(codes) when byte_size(codes) == 7 do
    recursive_find(codes, 0, 127)
  end

  def find_column(codes) when byte_size(codes) == 3 do
    recursive_find(codes, 0, 7)
  end

  def recursive_find(codes, minimum, maximum) do
    {code, rest} = codes |> String.next_codepoint()

    case code |> get_binary_point(minimum, maximum) do
      {:cont, {min_val, max_val}} -> recursive_find(rest, min_val, max_val)
      {:stop, final} -> final
    end
  end

  def get_binary_point(code, minimum, maximum) when code == "F" or code == "L" do
    upper = round((maximum + minimum) / 2) - 1

    if minimum == upper do
      {:stop, minimum}
    else
      {:cont, {minimum, upper}}
    end
  end

  def get_binary_point(code, minimum, maximum) when code == "B" or code == "R" do
    lower = round((maximum + minimum) / 2)

    if maximum == lower do
      {:stop, maximum}
    else
      {:cont, {lower, maximum}}
    end
  end
end
