defmodule AOC2020.Day10 do
  @moduledoc """
  Module Day 10
  """

  @doc """
  Get sorted array of the charging outlet, built-in adapter and
  the rest adapters in arr
  """
  def get_array_sorted_and_info(arr, outlet) do
    built_in = Enum.max(arr) + 3
    Enum.sort([outlet | [built_in | arr]])
  end

  def get_multipli_jolt_1_and_3(%{jolt_1: a, jolt_3: b}), do: a * b

  @doc """
  Find the number of 1-jolt differences multiplied by the number of 3-jolt differences.
  """
  def solve_p1(path) do
    path
    |> get_jolt_map_from_file()
    |> get_multipli_jolt_1_and_3()
  end

  def get_jolt_map_from_file(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> get_array_sorted_and_info(0)
    |> get_jolt_map(%{})
  end

  @doc """
  Make the map to count the number of jolt_1, jolt_2 and jolt_3
  """
  def get_jolt_map([], map) do
    map
  end

  def get_jolt_map([_ | []], map) do
    map
  end

  def get_jolt_map(
        [first | [second | _] = sub_arr],
        map
      ) do
    diff = second - first

    my_update_map =
      case diff do
        1 ->
          map |> Map.put(:jolt_1, Map.get(map, :jolt_1, 0) + 1)

        2 ->
          map |> Map.put(:jolt_2, Map.get(map, :jolt_2, 0) + 1)

        3 ->
          map |> Map.put(:jolt_3, Map.get(map, :jolt_3, 0) + 1)

        _ ->
          map
      end

    if diff <= 3 do
      get_jolt_map(sub_arr, my_update_map)
    else
      # stop immidiately
      get_jolt_map([], map)
    end
  end

  def get_valid_next_adapters(arr, adapter) do
    [adapter + 1, adapter + 2, adapter + 3]
    |> MapSet.new()
    |> MapSet.intersection(MapSet.new(arr))
    |> MapSet.to_list()
  end

  @doc """
  Loop recursively through array, update the map with value is the list of next adapters for the key.
  """
  def make_map([], map), do: map

  def make_map([head | tail], map) do
    next_apdaters =
      tail
      |> get_valid_next_adapters(head)

    map = map |> Map.put(head, next_apdaters)
    make_map(tail, map)
  end

  @doc """
  Loop through the array in reverse order, create the new map for each key (item in the array),
  value is the sum of values from every previous keys.

  Return value with key `0` from the newly created map.
  """
  def traverse_map(arr, map) do
    arr
    |> Enum.reverse()
    |> Enum.reduce(%{}, fn num, acc ->
      case map |> Map.get(num) do
        [] ->
          Map.put(acc, num, 1)

        [prev | []] ->
          Map.put(acc, num, acc[prev])

        [prev_1 | [prev_2 | []]] ->
          Map.put(acc, num, acc[prev_1] + acc[prev_2])

        [prev_1 | [prev_2 | [prev_3 | []]]] ->
          Map.put(acc, num, acc[prev_1] + acc[prev_2] + acc[prev_3])
      end
    end)
    |> Map.get(0)
  end

  @doc """
  Find the total number of distinct ways you can arrange the adapters (from input file)
  to connect the charging outlet to your device.
  """
  def solve_p2(path) do
    arr =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer(&1))
      |> get_array_sorted_and_info(0)

    map = make_map(arr, %{})
    traverse_map(arr, map)
  end
end
