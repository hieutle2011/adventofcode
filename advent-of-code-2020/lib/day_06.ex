defmodule AOC2020.Day06 do
  @moduledoc """
  Module Day 6
  """

  alias AOC2020.Day06.Answers

  def solve_p1(path) do
    path
    |> parse_groups()
    |> Enum.map(&get_group_any_yes/1)
    |> Enum.sum()
  end

  def solve_p2(path) do
    path
    |> parse_groups()
    |> Enum.map(&get_group_all_yes/1)
    |> Enum.sum()
  end

  def parse_groups(path) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
  end

  def get_group_any_yes(arr) do
    arr
    |> Enum.map(&parse_individual_answer/1)
    |> Enum.reduce(%Answers{}, &group_any_yes_reducer/2)
    |> count_individual_yes()
  end

  def group_any_yes_reducer(yes, acc) do
    acc
    |> Map.merge(yes, fn _k, v1, v2 ->
      if v1 >= v2, do: v1, else: v2
    end)
  end

  def get_group_all_yes(arr) do
    arr
    |> Enum.map(&parse_individual_answer/1)
    |> Enum.reduce(
      Answers.get_an_all_yes_answer(),
      &group_all_yes_reducer/2
    )
    |> count_individual_yes()
  end

  def group_all_yes_reducer(yes, acc) do
    acc
    |> Map.merge(yes, fn _k, v1, v2 ->
      if v1 == 1 and v2 == 1, do: 1, else: 0
    end)
  end

  def parse_individual_answer(str) do
    str
    |> String.codepoints()
    |> Enum.map(&Map.put(%{}, String.to_atom(&1), 1))
    |> Enum.reduce(%Answers{}, &individual_reducer/2)
  end

  def individual_reducer(yes, acc) do
    acc |> Map.merge(yes)
  end

  def count_individual_yes(answers) do
    [_ | values] = answers |> Map.values()

    values |> Enum.sum()
  end
end
