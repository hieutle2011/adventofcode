defmodule AOC2020.Day10Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day10

  describe ".get_array_sorted_and_info" do
    test "ok" do
      arr = [6, 12, 4]
      assert [0, 4, 6, 12, 15] = Day10.get_array_sorted_and_info(arr, 0)
    end

    test "small" do
      arr = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

      assert [0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22] =
               Day10.get_array_sorted_and_info(arr, 0)
    end
  end

  describe ".get_jolt_map_from_file" do
    test "small" do
      path = "input/day_10_small.txt"
      assert %{jolt_1: 7, jolt_3: 5} = Day10.get_jolt_map_from_file(path)
    end

    test "input" do
      path = "input/day_10.txt"
      assert %{jolt_1: 75, jolt_3: 37} = Day10.get_jolt_map_from_file(path)
    end
  end

  describe ".solve_p1" do
    test "ok" do
      path = "input/day_10.txt"

      assert 2775 ==
               path
               |> Day10.solve_p1()
    end
  end

  describe ".get_valid_next_adapters" do
    test "case 1" do
      assert [1] = Day10.get_valid_next_adapters([1, 4, 5], 0)
    end

    test "case 2 last item" do
      assert [] = Day10.get_valid_next_adapters([1, 4, 5], 5)
    end

    test "case 3 before last item" do
      assert [5] = Day10.get_valid_next_adapters([1, 4, 5], 4)
    end

    test "case 4 multi items" do
      assert [3, 4, 5] = Day10.get_valid_next_adapters([3, 4, 5], 2)
    end
  end

  describe ".make_map" do
    test "case 1" do
      arr = [0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22]

      map = Day10.make_map(arr, %{})

      assert %{
               0 => [1],
               1 => [4],
               4 => [5, 6, 7],
               5 => [6, 7],
               6 => [7],
               7 => [10],
               10 => [11, 12],
               11 => [12],
               12 => [15],
               15 => [16],
               16 => [19],
               19 => [22],
               22 => []
             } == map

      assert map[11] == [12]
    end
  end

  describe ".traverse_map" do
    test "small" do
      arr = [0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22]
      map = Day10.make_map(arr, %{})
      assert 8 == Day10.traverse_map(arr, map)
    end
  end

  describe "solve_p2" do
    test "small" do
      path = "input/day_10_small.txt"
      assert 8 == Day10.solve_p2(path)
    end

    test "larger" do
      path = "input/day_10_larger.txt"
      assert 19_208 == Day10.solve_p2(path)
    end

    test "input" do
      path = "input/day_10.txt"
      assert 518_344_341_716_992 == Day10.solve_p2(path)
    end
  end
end
