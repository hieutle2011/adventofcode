defmodule AOC2020.Day03 do
  @moduledoc """
  Module Day 3
  """

  @tree "#"
  @slopes [%{r: 1, d: 1}, %{r: 3, d: 1}, %{r: 5, d: 1}, %{r: 7, d: 1}, %{r: 1, d: 2}]

  @doc """
  Find the times we encounter tree with slope {right 3, down 1}
  """
  def solve_p1(path) do
    cur_pos = {0, 0}
    slope = %{r: 3, d: 1}
    size = get_input_size(path)

    move_recursive(cur_pos, slope, size, 0)
  end

  @doc """
  Multiply together the number of trees encountered on each of the listed slopes
  """
  def solve_p2(path) do
    cur_pos = {0, 0}
    size = get_input_size(path)

    @slopes
    |> Enum.reduce(1, fn slope, acc ->
      acc * move_recursive(cur_pos, slope, size, 0)
    end)
  end

  def move_recursive(cur_pos, slope, %{lines: lines} = size, count \\ 0) do
    case move(cur_pos, slope, size) do
      {:ok, pos} ->
        if tree?(pos, lines) do
          move_recursive(pos, slope, size, count + 1)
        else
          move_recursive(pos, slope, size, count)
        end

      {:stop, _} ->
        count
    end
  end

  def get_input_size(path) do
    [line_0 | _] =
      lines =
      path
      |> File.read!()
      |> String.split("\n")

    %{
      h: lines |> Enum.count(),
      w: line_0 |> String.codepoints() |> Enum.count(),
      lines: lines
    }
  end

  def move(cur_pos, slope, size) do
    if valid_move_down?(cur_pos, slope, size) do
      {:ok,
       {
         move_right(cur_pos, slope, size),
         move_down(cur_pos, slope)
       }}
    else
      {:stop, cur_pos}
    end
  end

  def valid_move_down?({_, y}, %{d: down}, %{h: height}) do
    y + down < height
  end

  def move_down({_, y}, %{d: down}), do: y + down

  def move_right({x, _}, %{r: right}, %{w: width}) do
    if x + right <= width - 1, do: x + right, else: rem(x + right, width - 1) - 1
  end

  def tree?({x, y}, lines) do
    lines |> Enum.at(y) |> String.codepoints() |> Enum.at(x) == @tree
  end
end
