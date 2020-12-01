defmodule AOC2020.Day01Test do
  use ExUnit.Case
  doctest AOC2020

  test "day 01 part 01" do
    path = "input/day_01.txt"

    arr =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer(&1))

    {number_1, number_2} = AOC2020.Day01.solve_p1(arr)

    assert number_1 == 1_359
    assert number_2 == 661
    assert number_1 * number_2 == 898_299
  end

  test "day 01 part 02" do
    path = "input/day_01.txt"

    arr =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer(&1))

    {number_1, number_2, number_3} = AOC2020.Day01.solve_p2(arr)

    assert number_1 == 354
    assert number_2 == 1369
    assert number_3 == 297
    assert number_1 + number_2 + number_3 == 2_020
    assert number_1 * number_2 * number_3 == 143_933_922
  end
end
