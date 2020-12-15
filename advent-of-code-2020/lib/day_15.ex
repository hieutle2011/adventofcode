defmodule AOC2020.Day15 do
  @moduledoc """
  Module Day 15
  """
  def get_arr_with_index(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.with_index(1)
  end

  def solve_p1(str, target_turn \\ 2020) do
    arr =
      str
      |> get_arr_with_index()

    start_len = arr |> Enum.count()

    {turn_map, _count_map} =
      arr
      |> init_map()
      |> iterate_turns(start_len, target_turn)

    turn_map[target_turn]
  end

  def init_map(arr) do
    arr
    |> Enum.reduce({%{}, %{}}, fn {num, turn}, acc ->
      {turn_map, count_map} = acc

      # turn_map
      last_turn_map = Map.get(turn_map, turn - 1)

      new_turn_map =
        if is_nil(last_turn_map) do
          %{spoken: num, recent: nil}
        else
          %{spoken: num, recent: Map.get(last_turn_map, :spoken)}
        end

      new_turn_map = Map.put(turn_map, turn, new_turn_map)

      # count_map
      this_num_map = Map.get(count_map, num)

      new_count_map =
        if is_nil(this_num_map) do
          %{first_time: true, turns: [turn]}
        else
          %{first_time: false, turns: [turn | Map.get(this_num_map, :turns)]}
        end

      new_count_map = Map.put(count_map, num, new_count_map)

      {new_turn_map, new_count_map}
    end)
  end

  def iterate_turns(init_tuple, start, stop) do
    (start + 1)..(stop + 1)
    |> Enum.reduce(init_tuple, fn turn, {acc_turn_map, acc_count_map} ->
      prev_turn = get_in(acc_turn_map, [turn - 1])
      prev_spoken = Map.get(acc_count_map, prev_turn.spoken)

      if prev_spoken.first_time do
        this_turn_spoken = 0
        new_turn = %{spoken: this_turn_spoken, recent: prev_turn.spoken}
        # update turn_map
        new_turn_map = acc_turn_map |> Map.put(turn, new_turn)

        zero = Map.get(acc_count_map, this_turn_spoken)
        [latest_turn_of_zero | _] = zero.turns

        # update count_map
        new_count_map =
          acc_count_map
          |> Map.put(this_turn_spoken, %{first_time: false, turns: [turn | [latest_turn_of_zero]]})

        {new_turn_map, new_count_map}
      else
        [latest | [pre_latest | _]] = prev_spoken.turns
        this_turn_spoken = latest - pre_latest

        # update turn_map
        new_turn = %{spoken: this_turn_spoken, recent: prev_turn.spoken}
        new_turn_map = acc_turn_map |> Map.put(turn, new_turn)
        spoken_turns = get_in(acc_count_map, [this_turn_spoken, :turns])

        # update count_map
        new_count_map =
          case List.wrap(spoken_turns) do
            [] ->
              acc_count_map |> Map.put(this_turn_spoken, %{first_time: true, turns: [turn]})

            [last | _] ->
              acc_count_map
              |> Map.put(this_turn_spoken, %{first_time: false, turns: [turn | [last]]})
          end

        {new_turn_map, new_count_map}
      end
    end)
  end
end
