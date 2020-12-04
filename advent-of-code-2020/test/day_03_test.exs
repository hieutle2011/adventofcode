defmodule AOC2020.Day03Test do
  use ExUnit.Case
  doctest AOC2020

  test "solve_p1" do
    path = "input/day_03.txt"
    assert 189 = AOC2020.Day03.solve_p1(path)
  end

  test "solve_p2" do
    path = "input/day_03.txt"
    assert 1_718_180_100 = AOC2020.Day03.solve_p2(path)
  end

  test ".get_input_size" do
    path = "input/day_03.txt"
    %{h: height, w: width, lines: lines} = AOC2020.Day03.get_input_size(path)
    assert height == 323
    assert width == 31
    assert Enum.count(lines) == height
  end

  describe ".valid_move_down?" do
    test "valid" do
      cur_pos = {0, 0}
      slope = %{d: 1}
      size = %{h: 2}

      assert AOC2020.Day03.valid_move_down?(cur_pos, slope, size)
    end

    test "invalid" do
      cur_pos = {0, 0}
      slope = %{d: 2}
      size = %{h: 1}

      assert AOC2020.Day03.valid_move_down?(cur_pos, slope, size) == false
    end
  end

  describe ".move_right" do
    test "within width" do
      cur_pos = {0, 0}
      slope = %{r: 2}
      size = %{w: 5}

      assert {2, 0} == AOC2020.Day03.move_right(cur_pos, slope, size)
    end

    test "within width next 1" do
      cur_pos = {2, 0}
      slope = %{r: 2}
      size = %{w: 5}

      assert {4, 0} == AOC2020.Day03.move_right(cur_pos, slope, size)
    end

    test "outside width next 2" do
      cur_pos = {4, 0}
      slope = %{r: 2}
      size = %{w: 5}

      assert {1, 0} = AOC2020.Day03.move_right(cur_pos, slope, size)
    end

    test "outside width next 2 (edge)" do
      cur_pos = {4, 0}
      slope = %{r: 2}
      size = %{w: 6}

      assert {0, 0} = AOC2020.Day03.move_right(cur_pos, slope, size)
    end

    test "input situation" do
      cur_pos = {30, 0}
      slope = %{r: 3}
      size = %{w: 31}

      assert {2, 0} = AOC2020.Day03.move_right(cur_pos, slope, size)
    end
  end

  describe ".move_down" do
    test "ok" do
      cur_pos = {0, 0}
      slope = %{d: 2}

      assert {0, 2} == AOC2020.Day03.move_down(cur_pos, slope)
    end
  end

  describe ".move" do
    test "ok" do
      cur_pos = {0, 0}
      slope = %{r: 1, d: 1}
      size = %{h: 2, w: 2}

      assert {:ok, new_pos} = AOC2020.Day03.move(cur_pos, slope, size)
      assert new_pos == {1, 1}
    end

    test "ok right one time within" do
      cur_pos = {0, 0}
      slope = %{r: 4, d: 1}
      size = %{h: 3, w: 8}

      assert {:ok, new_pos} = AOC2020.Day03.move(cur_pos, slope, size)
      assert new_pos == {4, 1}
    end

    test "reach bottom" do
      cur_pos = {0, 0}
      slope = %{r: 1, d: 2}
      size = %{h: 1, w: 1}

      assert {:stop, cur_pos} = AOC2020.Day03.move(cur_pos, slope, size)
    end
  end

  describe ".tree?" do
    test "0,0" do
      pos = {0, 0}
      lines = ["..#", "..."]
      assert AOC2020.Day03.tree?(pos, lines) == false
    end

    test "2,0" do
      pos = {2, 0}
      lines = ["..#", "..."]
      assert AOC2020.Day03.tree?(pos, lines)
    end
  end
end
