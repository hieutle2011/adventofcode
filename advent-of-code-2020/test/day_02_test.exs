defmodule AOC2020.Day02Test do
  use ExUnit.Case
  doctest AOC2020

  describe ".split_line" do
    test "default" do
      assert ["4-8", "g", "ggtxgtgb"] = AOC2020.Day02.split_line("4-8 g: ggtxgtgb")
    end

    test "custom arg" do
      assert ["4-8 g", " ggtxgtgb"] = AOC2020.Day02.split_line("4-8 g: ggtxgtgb", ":")
    end
  end

  describe ".valid_password" do
    test "valid 1-3 a: abcde" do
      assert AOC2020.Day02.valid_password?("1-3", "a", "abcde")
    end

    test "invalid 1-3 b: cdefg" do
      assert not AOC2020.Day02.valid_password?("1-3", "b", "cdefg")
    end
  end

  describe ".valid_password_v2" do
    test "valid 1-3 a: abcde" do
      assert AOC2020.Day02.valid_password_v2?("1-3", "a", "abcde")
    end

    test "invalid 1-3 b: cdefg" do
      assert not AOC2020.Day02.valid_password_v2?("1-3", "b", "cdefg")
    end

    test "invalid 2-9 c: ccccccccc" do
      assert not AOC2020.Day02.valid_password_v2?("2-9", "c", "ccccccccc")
    end
  end

  describe ".count_char_in_string" do
    test "count = 1" do
      assert 1 == AOC2020.Day02.count_char_in_string("a", "abcde")
    end

    test "count = 0" do
      assert 0 == AOC2020.Day02.count_char_in_string("z", "abcde")
    end
  end

  describe ".get_range" do
    test "ok" do
      assert [4, 8] == AOC2020.Day02.get_range("4-8")
    end
  end

  test "day 02 part 01" do
    path = "input/day_02.txt"

    assert 383 == AOC2020.Day02.solve_p1(path)
  end

  test "day 02 part 02" do
    path = "input/day_02.txt"

    assert 272 == AOC2020.Day02.solve_p2(path)
  end
end
