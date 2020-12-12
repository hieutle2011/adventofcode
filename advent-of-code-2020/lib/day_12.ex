defmodule AOC2020.Day12 do
  @moduledoc """
  Module Day 12
  """

  alias AOC2020.{Location, Point}

  def solve_p1(path) do
    init_loc = Location.new("E", 0, 0)

    final_loc =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&parse_instruction(&1))
      |> Enum.reduce(init_loc, fn ins, acc ->
        acc
        |> Location.change_location(ins)
      end)

    final_loc.point |> Point.get_manhattan_distance(init_loc.point)
  end

  def solve_p2(path) do
    init_loc = Location.new("E", 0, 0)

    final_loc =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&parse_instruction(&1))
      |> Enum.reduce(init_loc, fn ins, acc ->
        acc
        |> Location.change_waypoint(ins)
      end)

    final_loc.point |> Point.get_manhattan_distance(init_loc.point)
  end

  def parse_instruction(ins) when is_binary(ins) do
    {cardinal, str} = String.split_at(ins, 1)
    {cardinal, String.to_integer(str)}
  end
end
