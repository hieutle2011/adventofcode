defmodule AOC2020.Day07 do
  @moduledoc """
  Module Day 7
  """

  alias AOC2020.Day07.Bag

  def recursive_find_all_bag_outside(map, key) do
    direct_belong = Map.get(map, key).belongs_to

    indirect =
      direct_belong
      |> Enum.reduce([], fn elem, acc ->
        case recursive_find_all_bag_outside(map, elem) do
          [] -> acc
          indirect_contains -> indirect_contains ++ acc
        end
      end)

    direct_belong
    |> Enum.concat(indirect)
    |> Enum.uniq()
  end

  def recursive_find_all_bag_inside(map, key) do
    case Map.get(map, key).contains do
      [] ->
        0

      insides ->
        insides
        |> Enum.reduce(0, fn {count, color}, acc ->
          count + acc + recursive_find_all_bag_inside(map, color) * count
        end)
    end
  end

  def parse_line(line) do
    line
    |> String.split([" contain ", " bag", " bags", ".", ", "], trim: true)
  end

  def get_bag_and_quantity(str) do
    [quantity, type_bag_str] =
      str
      |> String.split(" ", parts: 2)

    {String.to_integer(quantity), type_bag_str}
  end

  def update_map(map, [_, "no other"]), do: map

  def update_map(map, [target | bags]) do
    target_bag = Map.get(map, target, %Bag{})
    map = map |> Map.put(target, target_bag)

    map =
      bags
      |> Enum.reduce(map, fn bag, acc ->
        {_num, color} = contain = get_bag_and_quantity(bag)

        belong = Map.get(acc, color, %Bag{})

        # updating ...
        belong = %{belong | belongs_to: [target | belong.belongs_to]}
        target_bag = %{acc[target] | contains: [contain | acc[target].contains]}

        acc
        |> Map.put(target, target_bag)
        |> Map.put(color, belong)
      end)

    map
  end

  def make_map(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn elem, acc ->
      update_map(acc, elem)
    end)
  end
end
