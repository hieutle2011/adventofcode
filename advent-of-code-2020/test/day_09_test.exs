defmodule AOC2020.Day09Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day09

  describe ".valid_next_number?" do
    test "ok" do
      arr = [35, 20, 15, 25, 47]
      num = 40
      assert {15, 25} = Day09.valid_next_number?(arr, num)
    end

    test "fail" do
      arr = [95, 102, 117, 150, 182]
      num = 127
      assert not Day09.valid_next_number?(arr, num)
    end
  end

  describe "make_queue" do
    test "1 item queue" do
      assert q = {[1], []} = Day09.make_queue([1])
      assert {{:value, 1}, {[], []}} = :queue.out(q)
    end

    test "2 item queue" do
      assert q = {[2], [1]} = Day09.make_queue([1, 2])
      assert {{:value, 1}, q} = :queue.out(q)
      assert {{:value, 2}, {[], []}} = :queue.out(q)
    end
  end

  describe ".make_list_from_preamble" do
    test "1 item list" do
      q = {[3, 2], [1]} = Day09.make_queue([1, 2, 3])
      %{next_arr: arr, new_queue: q, two_sum: target} = Day09.make_list_from_preamble(q, 1)
      assert [1] = arr
      assert {[3], [2]} = q
      assert target == 2
    end

    test "2 item list" do
      q = {[3, 2], [1]} = Day09.make_queue([1, 2, 3])
      %{next_arr: arr, new_queue: q, two_sum: target} = Day09.make_list_from_preamble(q, 2)
      assert [2, 1] = arr
      assert {[3], [2]} = q
      assert target == 3
    end

    test "preamble (3) larger than queue members" do
      q = {[3, 2], [1]} = Day09.make_queue([1, 2, 3])
      %{next_arr: arr, new_queue: q, two_sum: target} = Day09.make_list_from_preamble(q, 3)
      assert [2, 1] = arr
      assert {[3], [2]} = q
      assert target == 3
    end
  end

  describe "solve_p1" do
    test "small" do
      path = "input/day_09_small.txt"
      assert %{target_number: 127, valid: false} = Day09.solve_p1(path, 5)
    end

    test "big" do
      path = "input/day_09.txt"
      assert %{target_number: 31_161_678, valid: false} = Day09.solve_p1(path, 25)
    end
  end

  describe "solve_p2" do
    test "small" do
      path = "input/day_09_small.txt"
      assert 62 = Day09.solve_p2(path, 127)
    end

    test "big" do
      path = "input/day_09.txt"
      assert 5_453_868 = Day09.solve_p2(path, 31_161_678)
    end
  end

  describe ".start_find_contigous" do
    test "ok" do
      arr = [
        35,
        20,
        15,
        25,
        47,
        40,
        62,
        55,
        65,
        95,
        102,
        117,
        150,
        182,
        127,
        219,
        299,
        277,
        309,
        576
      ]

      assert [[[40, 47, 25, 15]]] = Day09.start_find_contigous(arr, [], 127)
    end
  end
end
