defmodule AOC2020.Day06Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day06.Answers

  describe ".solve_p1" do
    test ".small" do
      path = "input/day_06_small.txt"
      assert 11 == AOC2020.Day06.solve_p1(path)
    end

    test ".input" do
      path = "input/day_06.txt"
      assert 6726 == AOC2020.Day06.solve_p1(path)
    end
  end

  describe ".solve_p2" do
    test ".small" do
      path = "input/day_06_small.txt"
      assert 6 == AOC2020.Day06.solve_p2(path)
    end

    test ".input" do
      path = "input/day_06.txt"
      assert 3316 == AOC2020.Day06.solve_p2(path)
    end
  end

  test ".parse_individual_answer" do
    str = "ab"
    assert %Answers{a: 1, b: 1} = AOC2020.Day06.parse_individual_answer(str)
  end

  describe ".count_individual_yes" do
    test "a: 1" do
      answers = %Answers{a: 1}
      assert 1 == AOC2020.Day06.count_individual_yes(answers)
    end

    test "a\nb\nc" do
      str = "a\nb\nc"

      assert [1, 1, 1] ==
               str
               |> String.split("\n")
               |> Enum.map(&AOC2020.Day06.parse_individual_answer/1)
               |> Enum.map(&AOC2020.Day06.count_individual_yes/1)
    end
  end

  describe "get_group_any_yes" do
    test "case 0" do
      arr = ["abc"]
      assert 3 == AOC2020.Day06.get_group_any_yes(arr)
    end

    test "case 1" do
      arr = ["a", "b", "c"]
      assert 3 == AOC2020.Day06.get_group_any_yes(arr)
    end

    test "case 2" do
      arr = ["ab", "ac"]
      assert 3 == AOC2020.Day06.get_group_any_yes(arr)
    end
  end

  describe "get_group_all_yes" do
    test "case 0" do
      arr = ["abc"]
      assert 3 == AOC2020.Day06.get_group_all_yes(arr)
    end

    test "case 1" do
      arr = ["a", "b", "c"]
      assert 0 == AOC2020.Day06.get_group_all_yes(arr)
    end

    test "case 2" do
      arr = ["ab", "ac"]
      assert 1 == AOC2020.Day06.get_group_all_yes(arr)
    end
  end
end
