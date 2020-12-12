defmodule AOC2020.Day12Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day12

  describe "solve p1" do
    test "small" do
      path = "input/day_12_small.txt"
      assert 25 = Day12.solve_p1(path)
    end

    test "input" do
      path = "input/day_12.txt"
      assert 362 = Day12.solve_p1(path)
    end
  end

  describe "solve p2" do
    test "small" do
      path = "input/day_12_small.txt"
      assert 286 = Day12.solve_p2(path)
    end

    test "input" do
      path = "input/day_12.txt"
      assert 29_895 = Day12.solve_p2(path)
    end
  end
end
