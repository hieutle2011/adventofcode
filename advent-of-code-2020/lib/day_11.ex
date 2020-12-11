defmodule AOC2020.Day11 do
  @moduledoc """
  Module Day 11
  """

  @emtpy "L"
  @occupied "#"
  @floor "."

  def get_board_info(path) do
    arr =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))

    %{board: arr, row_count: Enum.count(arr), col_count: arr |> Enum.at(0) |> Enum.count()}
  end

  def transform_board_array_to_map(board, map \\ %{}) do
    result =
      for i <- 0..(board.row_count - 1), j <- 0..(board.col_count - 1) do
        val = get_in(board.board, [Access.at(i), Access.at(j)])
        map |> Map.put({i, j}, val)
      end
      |> Enum.reduce(%{}, fn map, acc -> acc |> Map.merge(map) end)

    %{keys: Map.keys(result), map: result}
  end

  def solve_p1(path) do
    %{keys: keys, map: map} =
      path
      |> get_board_info()
      |> transform_board_array_to_map()

    %{round: _rounds, latest: latest} = recursive_travel(keys, map)
    get_occupied_count(latest, keys)
    # rounds |> Enum.count()
  end

  def recursive_travel(keys, initial_map, rounds \\ []) do
    change_map = get_changing_seat_map(keys, initial_map)
    updated_map = apply_rule(keys, initial_map, change_map)

    if continue_changing?(change_map, keys) do
      recursive_travel(keys, updated_map, [change_map | rounds])
    else
      %{round: rounds, latest: updated_map}
    end
  end

  def continue_changing?(map, keys) do
    keys
    |> Enum.reduce(false, fn key, acc ->
      acc or map[key]
    end)
  end

  def apply_rule(keys, initial_map, change_map) do
    keys
    |> Enum.reduce(%{}, fn key, acc ->
      acc =
        cond do
          initial_map[key] == @emtpy and change_map[key] -> acc |> Map.put(key, @occupied)
          initial_map[key] == @occupied and change_map[key] -> acc |> Map.put(key, @emtpy)
          initial_map[key] == @floor -> acc |> Map.put(key, @floor)
          true -> acc |> Map.put(key, initial_map[key])
        end

      acc
    end)
  end

  def get_changing_seat_map(keys, map) do
    keys
    |> Enum.reduce(%{}, fn key, acc ->
      seat = map[key]
      occupied_count = get_occupied_adjacent_count(map, key)

      acc =
        case seat do
          @emtpy -> acc |> Map.put(key, become_occupied?(seat, occupied_count))
          @occupied -> acc |> Map.put(key, become_empty?(seat, occupied_count))
          @floor -> acc |> Map.put(key, false)
        end

      acc
    end)
  end

  def get_occupied_count(map, keys) do
    keys
    |> Enum.map(&map[&1])
    |> Enum.filter(&(&1 == @occupied))
    |> Enum.count()
  end

  def get_occupied_adjacent_count(map, key) do
    get_adjacent_keys(key)
    |> Enum.map(&map[&1])
    |> Enum.filter(&(&1 == @occupied))
    |> Enum.count()
  end

  def get_adjacent_keys({i, j}) do
    [
      {i - 1, j - 1},
      {i, j - 1},
      {i + 1, j - 1},
      {i - 1, j},
      {i + 1, j},
      {i - 1, j + 1},
      {i, j + 1},
      {i + 1, j + 1}
    ]
  end

  def become_occupied?(@emtpy, occupied_count)
      when is_number(occupied_count) do
    occupied_count == 0
  end

  def become_empty?(@occupied, occupied_count) when is_number(occupied_count) do
    occupied_count >= 4
  end

  def never_change?(@floor), do: true

  @doc """
  become_empty_v2 for part 2
  """
  def become_empty_v2?(@occupied, occupied_count) when is_number(occupied_count) do
    occupied_count >= 5
  end

  def solve_p2(path) do
    %{keys: keys, map: map} =
      path
      |> get_board_info()
      |> transform_board_array_to_map()

    %{round: _rounds, latest: latest} = recursive_travel_v2(keys, map)
    get_occupied_count(latest, keys)
  end

  def recursive_travel_v2(keys, initial_map, rounds \\ []) do
    change_map = get_changing_seat_map_v2(keys, initial_map)
    updated_map = apply_rule(keys, initial_map, change_map)

    if continue_changing?(change_map, keys) do
      recursive_travel_v2(keys, updated_map, [change_map | rounds])
    else
      %{round: rounds, latest: updated_map}
    end
  end

  def get_changing_seat_map_v2(keys, map) do
    keys
    |> Enum.reduce(%{}, fn key, acc ->
      seat = map[key]
      occupied_count = get_occupied_adjacent_count_v2(map, key)

      case seat do
        @emtpy -> acc |> Map.put(key, become_occupied?(seat, occupied_count))
        @occupied -> acc |> Map.put(key, become_empty_v2?(seat, occupied_count))
        @floor -> acc |> Map.put(key, false)
      end
    end)
  end

  def get_occupied_adjacent_count_v2(map, key) do
    get_adjacent_keys_v2(map, key)
    |> Enum.map(&map[&1])
    |> Enum.filter(&(&1 == @occupied))
    |> Enum.count()
  end

  # todo
  def get_adjacent_keys_v2(map, {i, j}) do
    []
    |> get_first_adjacent_north(map, {i, j - 1})
    |> get_first_adjacent_south(map, {i, j + 1})
    |> get_first_adjacent_west(map, {i - 1, j})
    |> get_first_adjacent_east(map, {i + 1, j})
    |> get_first_adjacent_north_east(map, {i + 1, j - 1})
    |> get_first_adjacent_north_west(map, {i - 1, j - 1})
    |> get_first_adjacent_south_east(map, {i + 1, j + 1})
    |> get_first_adjacent_south_west(map, {i - 1, j + 1})
  end

  def get_first_adjacent_north(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_north(acc, map, {i, j - 1})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_south(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_south(acc, map, {i, j + 1})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_west(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_west(acc, map, {i - 1, j})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_east(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_east(acc, map, {i + 1, j})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_north_east(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_north_east(acc, map, {i + 1, j - 1})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_north_west(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_north_west(acc, map, {i - 1, j - 1})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_south_east(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_south_east(acc, map, {i + 1, j + 1})
      _ -> [key | acc]
    end
  end

  def get_first_adjacent_south_west(acc, map, {i, j} = key) do
    case Map.get(map, key) do
      nil -> acc
      @floor -> get_first_adjacent_south_west(acc, map, {i - 1, j + 1})
      _ -> [key | acc]
    end
  end
end
