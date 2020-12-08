defmodule AOC2020.Day08Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day08
  alias AOC2020.Day08.Instruction

  describe "solve p1" do
    test "small" do
      path = "input/day_08_small.txt"
      assert {:loop, map, 4} = Day08.solve_p1(path)
      assert map.count == 5
    end

    test "input" do
      path = "input/day_08.txt"
      assert {:loop, map, 629} = Day08.solve_p1(path)
      assert map.count == 2003
    end
  end

  describe "solve p2" do
    test "small" do
      path = "input/day_08_small_fix.txt"
      assert {:safe, map, _} = Day08.solve_p1(path)
      assert map.count == 8
    end

    test "input" do
      path = "input/day_08_fix.txt"
      assert {:safe, map, _} = Day08.solve_p1(path)

      # Manually try and error
      # finally fix line "jmp +343" to "nop +343"
      # at line number 165
      assert map.count == 1984
    end
  end

  describe ".make_map" do
    test "case 1" do
      instructions = ["nop +0", "acc +1", "jmp +4"]

      assert %{
               :count => 0,
               0 => %Instruction{instruction: ["nop", "+0"], visits: 0},
               1 => %Instruction{instruction: ["acc", "+1"], visits: 0},
               2 => %Instruction{instruction: ["jmp", "+4"], visits: 0}
             } = Day08.make_map(instructions)
    end
  end

  describe ".get_instruction" do
    test "case 1" do
      map = %{
        :count => 0,
        0 => %Instruction{instruction: ["nop", "+0"], visits: 0},
        1 => %Instruction{instruction: ["acc", "+1"], visits: 0}
      }

      assert %Instruction{instruction: ["nop", "+0"], visits: 0} = Day08.get_instruction(map, 0)
    end

    test "case nil" do
      map = %{
        :count => 0,
        0 => %Instruction{instruction: ["nop", "+0"], visits: 0},
        1 => %Instruction{instruction: ["acc", "+1"], visits: 0}
      }

      assert map |> Day08.get_instruction(2) |> is_nil()
    end
  end

  describe "get_next_index_and_accumulator" do
    test "nop" do
      assert {1, 0} = Day08.get_next_index_and_accumulator(["nop", "+0"], 0)
    end

    test "acc" do
      assert {2, 1} = Day08.get_next_index_and_accumulator(["acc", "+1"], 1)
    end

    test "jmp" do
      assert {6, 0} = Day08.get_next_index_and_accumulator(["jmp", "+4"], 2)
    end
  end
end
