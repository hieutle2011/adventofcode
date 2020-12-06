defmodule AOC2020.Day05Test do
  use ExUnit.Case
  doctest AOC2020

  test "solve p1" do
    path = "input/day_05.txt"
    assert {_89, 888, _ids} = AOC2020.Day05.solve_p1(path)
  end

  test "solve p2" do
    path = "input/day_05.txt"
    assert [522] = AOC2020.Day05.find_my_seat_id(path)
  end

  describe ".get_binary_point" do
    test "F cont" do
      assert {:cont, {minimum, maximum}} = AOC2020.Day05.get_binary_point("F", 0, 127)
      assert minimum == 0
      assert maximum == 63
    end

    test "F final" do
      assert {:stop, final} = AOC2020.Day05.get_binary_point("F", 44, 45)
      assert final == 44
    end

    test "B" do
      assert {:cont, {minimum, maximum}} = AOC2020.Day05.get_binary_point("B", 0, 63)
      assert minimum == 32
      assert maximum == 63
    end

    test "B final" do
      assert {:stop, final} = AOC2020.Day05.get_binary_point("B", 4, 5)
      assert final == 5
    end
  end

  describe ".recursive_find" do
    test "FBFBBFF" do
      assert 44 == AOC2020.Day05.recursive_find("FBFBBFF", 0, 127)
    end

    test "RLR" do
      assert 5 == AOC2020.Day05.recursive_find("RLR", 0, 8)
    end
  end

  test ".find_row" do
    assert 44 == AOC2020.Day05.find_row("FBFBBFF")
  end

  test ".find_column" do
    assert 5 == AOC2020.Day05.find_column("RLR")
  end

  describe ".get_seat_id" do
    test "case 1" do
      assert 357 == AOC2020.Day05.get_seat_id("FBFBBFFRLR")
    end

    test "case 2" do
      assert 567 == AOC2020.Day05.get_seat_id("BFFFBBFRRR")
    end
  end
end
