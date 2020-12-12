defmodule AOC2020.PointTest do
  use ExUnit.Case
  doctest AOC2020
  alias AOC2020.Point

  test "manhattan distance" do
    assert 2 = Point.new(0, 0) |> Point.get_manhattan_distance(Point.new(1, 1))
    assert 25 = Point.new(0, 0) |> Point.get_manhattan_distance(Point.new(17, 8))
  end

  describe "rotate_point" do
    test "rotate right" do
      point = Point.new(10, 4)
      assert Point.new(4, -10) == point |> Point.rotate_point({"R", 90})
      assert Point.new(-10, -4) == point |> Point.rotate_point({"R", 180})
      assert Point.new(-4, 10) == point |> Point.rotate_point({"R", 270})
      assert point == point |> Point.rotate_point({"R", 360})
    end

    test "rotate left" do
      point = Point.new(10, 4)
      assert Point.new(-4, 10) == point |> Point.rotate_point({"L", 90})
      assert Point.new(-10, -4) == point |> Point.rotate_point({"L", 180})
      assert Point.new(4, -10) == point |> Point.rotate_point({"L", 270})
      assert point == point |> Point.rotate_point({"L", 360})
    end
  end
end
