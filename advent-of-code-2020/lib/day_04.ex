defmodule AOC2020.Day04 do
  @moduledoc """
  Module Day 4
  """

  @optional_field "cid"
  @line_seperator [" ", "\n"]
  @eye_colors ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def solve_p1(path) do
    path
    |> get_passports_from_input()
    |> Enum.reduce(0, fn pp, acc ->
      if valid_passport?(pp), do: acc + 1, else: acc
    end)
  end

  def solve_p2(path) do
    path
    |> get_passports_from_input()
    |> Enum.reduce(0, fn pp, acc ->
      if valid_passport_p2?(pp), do: acc + 1, else: acc
    end)
  end

  def valid_passport?(passport) do
    keys = passport |> Map.keys()

    case Enum.count(keys) do
      8 ->
        true

      7 ->
        # if keys contain optional key -> lack mandatory key -> false
        if Enum.member?(keys, @optional_field), do: false, else: true

      _ ->
        false
    end
  end

  def valid_passport_p2?(passport) do
    keys = passport |> Map.keys()

    case Enum.count(keys) do
      8 ->
        all_fields_valid?(passport)

      7 ->
        if Enum.member?(keys, @optional_field), do: false, else: all_fields_valid?(passport)

      _ ->
        false
    end
  end

  def all_fields_valid?(passport) do
    valid_byr?(Map.get(passport, "byr")) and
      valid_iyr?(Map.get(passport, "iyr")) and
      valid_eyr?(Map.get(passport, "eyr")) and
      valid_hgt?(Map.get(passport, "hgt")) and
      valid_hcl?(Map.get(passport, "hcl")) and
      valid_ecl?(Map.get(passport, "ecl")) and
      valid_pid?(Map.get(passport, "pid"))
  end

  def valid_byr?(str) do
    case enough_digit?(str, 4) do
      false -> false
      num -> within_range(num, 1920, 2002)
    end
  end

  def valid_iyr?(str) do
    case enough_digit?(str, 4) do
      false -> false
      num -> within_range(num, 2010, 2020)
    end
  end

  def valid_eyr?(str) do
    case enough_digit?(str, 4) do
      false -> false
      num -> within_range(num, 2020, 2030)
    end
  end

  def within_range(num, min, max) do
    min <= num and num <= max
  end

  def valid_hgt?(str) do
    {num, scale} = str |> Integer.parse()

    case scale do
      "cm" ->
        within_range(num, 150, 193)

      "in" ->
        within_range(num, 59, 76)

      _ ->
        false
    end
  end

  def valid_hcl?(str) do
    regex = ~r/#([0-9a-f]){6}/
    str =~ regex
  end

  def valid_ecl?(str), do: @eye_colors |> Enum.member?(str)

  def valid_pid?(str) do
    case str |> enough_digit?(9) do
      false -> false
      _ -> true
    end
  end

  def enough_digit?(str, length) when byte_size(str) == length do
    case str |> Integer.parse() do
      {number, _} -> number
      :error -> false
    end
  end

  def enough_digit?(_, _), do: false

  def get_passports_from_input(path) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&process_line(&1))
    |> Enum.map(&make_passport_map(&1))
  end

  def process_line(line) do
    line |> String.split(@line_seperator)
  end

  def make_passport_map(arr) do
    arr
    |> Enum.reduce(%{}, fn elem, acc ->
      [key, value] = elem |> String.split(":")
      Map.put(acc, key, value)
    end)
  end
end
