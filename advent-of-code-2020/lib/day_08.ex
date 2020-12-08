defmodule AOC2020.Day08 do
  @moduledoc """
  Module Day 8
  """

  alias AOC2020.Day08.Instruction

  def solve_p1(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> make_map()
    |> execute()
  end

  def execute(map, current_index \\ 0) do
    case get_instruction(map, current_index) do
      nil ->
        # current index not in map -> safely terminate
        [last_index | _] = map.last_index
        {:safe, map, last_index}

      current_ins ->
        {next_index, next_acc} =
          get_next_index_and_accumulator(current_ins.instruction, current_index)

        if current_ins.visits == 0 do
          # update map
          map =
            map
            |> Map.put(current_index, %{current_ins | visits: current_ins.visits + 1})
            |> Map.put(:count, map.count + next_acc)
            |> Map.put(:last_index, [current_index | Map.get(map, :last_index, [])])

          # continue recursively
          execute(map, next_index)
        else
          # visited once => stop
          [last_index | _] = map.last_index
          {:loop, map, last_index}
        end
    end
  end

  def get_next_index_and_accumulator(["nop", _step_str], current_index) do
    {current_index + 1, 0}
  end

  def get_next_index_and_accumulator(["acc", step_str], current_index) do
    {current_index + 1, String.to_integer(step_str)}
  end

  def get_next_index_and_accumulator(["jmp", step_str], current_index) do
    {current_index + String.to_integer(step_str), 0}
  end

  def get_instruction(map, index), do: map[index]

  def make_map(instructions) do
    instructions
    |> Enum.with_index()
    |> Enum.reduce(%{:count => 0}, &make_map_reducer/2)
  end

  def make_map_reducer({str, index}, acc) do
    instruction = %Instruction{instruction: parse_line(str)}
    acc |> Map.put(index, instruction)
  end

  def parse_line(str), do: str |> String.split(" ")
end
