defmodule AOC2020.Day11Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day11

  describe ".get_board_info" do
    test "small" do
      path = "input/day_11_small.txt"
      assert %{col_count: 10, row_count: 10, board: _arr} = Day11.get_board_info(path)
    end

    test "input" do
      path = "input/day_11.txt"
      assert %{col_count: 95, row_count: 99, board: _arr} = Day11.get_board_info(path)
    end
  end

  test ".transform_board_array_to_map" do
    path = "input/day_11_small.txt"

    %{keys: _keys, map: map} =
      path
      |> Day11.get_board_info()
      |> Day11.transform_board_array_to_map()

    assert %{} = map
  end

  test ".get_adjacent_keys" do
    assert [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}] =
             Day11.get_adjacent_keys({1, 1})
  end

  test ".get_occupied_adjacent_count" do
    path = "input/day_11_small.txt"

    %{keys: _keys, map: map} =
      path
      |> Day11.get_board_info()
      |> Day11.transform_board_array_to_map()

    assert 0 = Day11.get_occupied_adjacent_count(map, {0, 0})
  end

  describe ".solve_p1" do
    test "small" do
      path = "input/day_11_small.txt"
      assert 37 = Day11.solve_p1(path)
    end

    test "input" do
      path = "input/day_11.txt"
      assert 2453 = Day11.solve_p1(path)
    end
  end

  describe ".solve_p2" do
    test "small" do
      path = "input/day_11_small.txt"
      assert 26 = Day11.solve_p2(path)
    end

    test "input" do
      path = "input/day_11.txt"
      assert 2159 = Day11.solve_p2(path)
    end
  end

  describe "get_adjacent_keys_v2" do
    test "sample" do
      path = "input/day_11_sample.txt"

      %{keys: _, map: map} =
        path
        |> Day11.get_board_info()
        |> Day11.transform_board_array_to_map()

      assert [{0, 7}, {5, 4}, {2, 1}, {7, 0}, {8, 3}, {1, 3}, {4, 8}, {4, 2}] =
               Day11.get_adjacent_keys_v2(map, {4, 3})

      assert 8 = Day11.get_occupied_adjacent_count_v2(map, {4, 3})
    end

    test "sample2 " do
      path = "input/day_11_sample_2.txt"

      %{keys: _, map: map} =
        path
        |> Day11.get_board_info()
        |> Day11.transform_board_array_to_map()

      assert [{1, 3}] = Day11.get_adjacent_keys_v2(map, {1, 1})
    end

    test "sample3 " do
      path = "input/day_11_sample_3.txt"

      %{keys: _, map: map} =
        path
        |> Day11.get_board_info()
        |> Day11.transform_board_array_to_map()

      assert [] = Day11.get_adjacent_keys_v2(map, {3, 3})
    end
  end
end
