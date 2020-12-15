defmodule AOC2020.Day15Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day15

  describe "solve p1" do
    test "small" do
      assert %{spoken: 436} = Day15.solve_p1("0,3,6")
    end

    test "input" do
      assert %{spoken: 289} = Day15.solve_p1("0,8,15,2,12,1,4")
    end
  end

  describe "solve p2" do
    @tag timeout: :infinity
    @tag :pending
    test "small" do
      assert %{spoken: 175_594} = Day15.solve_p1("0,3,6", 30_000_000)
    end

    @tag timeout: :infinity
    @tag :pending
    test "input" do
      assert %{spoken: 1_505_722} = Day15.solve_p1("0,8,15,2,12,1,4", 30_000_000)
    end
  end
end
