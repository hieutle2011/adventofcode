defmodule AOC2020.Point do
  @moduledoc """
  Point module (2 dimensional point)
  """
  defstruct x: 0, y: 0

  def new(x \\ 0, y \\ 0), do: %__MODULE__{x: x, y: y}

  def get_manhattan_distance(point_a, point_b) do
    abs(point_a.x - point_b.x) + abs(point_a.y - point_b.y)
  end

  def rotate_point(point, {"R", number}) do
    case rem(number, 360) do
      0 ->
        point

      90 ->
        new(point.y, -point.x)

      180 ->
        point |> rotate_point({"R", 90}) |> rotate_point({"R", 90})

      270 ->
        point |> rotate_point({"R", 90}) |> rotate_point({"R", 90}) |> rotate_point({"R", 90})
    end
  end

  def rotate_point(point, {"L", number}) do
    case rem(number, 360) do
      0 ->
        point

      90 ->
        new(-point.y, point.x)

      180 ->
        point |> rotate_point({"L", 90}) |> rotate_point({"L", 90})

      270 ->
        point |> rotate_point({"L", 90}) |> rotate_point({"L", 90}) |> rotate_point({"L", 90})
    end
  end
end
