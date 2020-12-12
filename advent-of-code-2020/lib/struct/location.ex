defmodule AOC2020.Location do
  @moduledoc """
  Location Module
  """
  defstruct cardinal: nil, point: nil, waypoint: nil
  alias AOC2020.Point

  @north "N"
  @east "E"
  @south "S"
  @west "W"
  @left "L"
  @right "R"
  @forward "F"

  @cardinal_map %{
    @north => %{
      0 => @north,
      90 => @east,
      180 => @south,
      270 => @west
    },
    @east => %{
      0 => @east,
      90 => @south,
      180 => @west,
      270 => @north
    },
    @south => %{
      0 => @south,
      90 => @west,
      180 => @north,
      270 => @east
    },
    @west => %{
      0 => @west,
      90 => @north,
      180 => @east,
      270 => @south
    }
  }

  def new(cardinal, x \\ 0, y \\ 0, waypoint \\ Point.new(10, 1)),
    do: %__MODULE__{cardinal: cardinal, point: Point.new(x, y), waypoint: waypoint}

  def change_waypoint(loc, {code, number} = instruction) do
    case code do
      @north ->
        waypoint = Point.new(loc.waypoint.x, loc.waypoint.y + number)
        new(loc.cardinal, loc.point.x, loc.point.y, waypoint)

      @east ->
        waypoint = Point.new(loc.waypoint.x + number, loc.waypoint.y)
        new(loc.cardinal, loc.point.x, loc.point.y, waypoint)

      @south ->
        waypoint = Point.new(loc.waypoint.x, loc.waypoint.y - number)
        new(loc.cardinal, loc.point.x, loc.point.y, waypoint)

      @west ->
        waypoint = Point.new(loc.waypoint.x - number, loc.waypoint.y)
        new(loc.cardinal, loc.point.x, loc.point.y, waypoint)

      @forward ->
        new(
          loc.cardinal,
          loc.point.x + number * loc.waypoint.x,
          loc.point.y + number * loc.waypoint.y,
          loc.waypoint
        )

      _ ->
        waypoint = loc.waypoint |> Point.rotate_point(instruction)
        new(loc.cardinal, loc.point.x, loc.point.y, waypoint)
    end
  end

  def change_location(loc, {code, number} = instruction) do
    case code do
      @north ->
        new(loc.cardinal, loc.point.x, loc.point.y + number)

      @east ->
        new(loc.cardinal, loc.point.x + number, loc.point.y)

      @south ->
        new(loc.cardinal, loc.point.x, loc.point.y - number)

      @west ->
        new(loc.cardinal, loc.point.x - number, loc.point.y)

      @forward ->
        change_location(loc, {loc.cardinal, number})

      _ ->
        new(get_new_cardinal(loc.cardinal, instruction), loc.point.x, loc.point.y)
    end
  end

  def get_new_cardinal(cardinal, {@right, number}) do
    degree = rem(number, 360)
    get_in(@cardinal_map, [cardinal, degree])
  end

  def get_new_cardinal(cardinal, {@left, number}) when number == 0 or number == 180 do
    degree = rem(number, 360)
    get_in(@cardinal_map, [cardinal, degree])
  end

  def get_new_cardinal(cardinal, {@left, number}) when number == 90 or number == 270 do
    degree = rem(number + 180, 360)
    get_in(@cardinal_map, [cardinal, degree])
  end

  def get_new_cardinal(nil, _), do: nil
end
