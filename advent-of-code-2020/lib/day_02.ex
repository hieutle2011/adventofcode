defmodule AOC2020.Day02 do
  @moduledoc """
  Module Day 2
  """

  def solve_p1(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, &reducer/2)
  end

  def solve_p2(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, &reducer_v2/2)
  end

  def reducer(line, acc) do
    [range, char, pwd] = line |> split_line()

    if valid_password?(range, char, pwd) do
      acc + 1
    else
      acc
    end
  end

  def reducer_v2(line, acc) do
    [range, char, pwd] = line |> split_line()

    if valid_password_v2?(range, char, pwd) do
      acc + 1
    else
      acc
    end
  end

  def valid_password?(range, char, pwd) do
    [lower, upper] = get_range(range)
    count = char |> count_char_in_string(pwd)
    count >= lower && count <= upper
  end

  def valid_password_v2?(range, char, pwd) do
    [first, second] = get_range(range)
    chars = String.codepoints(pwd)
    first_char = chars |> Enum.at(first - 1)
    second_char = chars |> Enum.at(second - 1)

    first_char == char != (second_char == char)
  end

  def count_char_in_string(char, pwd) do
    pwd
    |> String.codepoints()
    |> Enum.reduce(0, fn elem, acc ->
      if char == elem do
        acc + 1
      else
        acc
      end
    end)
  end

  def get_range(str) do
    str
    |> String.split("-")
    |> Enum.map(&String.to_integer(&1))
  end

  def split_line(line, pattern \\ [":", " "]) do
    line |> String.split(pattern, trim: true)
  end
end
