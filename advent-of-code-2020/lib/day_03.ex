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

  @doc """
  While moving until reaching the bottom, count the number of encountered trees along the way.
  """
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

  @doc """
  Takes a path to an input file. Returns a map contains the size (height and width) and array of lines of the input file.
  """
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

  @doc """
  Returns a tupple with new position after the move, or current position if the move is invalid

  Take 3 arguments consists of current position, the slope of move, and size of the forest
  """
  def move(cur_pos, slope, size) do
    if valid_move_down?(cur_pos, slope, size) do
      {:ok, cur_pos |> move_right(slope, size) |> move_down(slope)}
    else
      {:stop, cur_pos}
    end
  end

  @doc """
  Checks if moving down is valid (cannot below the height)
  """
  def valid_move_down?({_, y}, %{d: down}, %{h: height}) do
    y + down < height
  end

  @doc """
  Returns the position after moving down
  """
  def move_down({x, y}, %{d: down}), do: {x, y + down}

  @doc """
  Returns the position after moving right. Move right can expand forever.
  """
  def move_right({x, y}, %{r: right}, %{w: width}) do
    new_x = if x + right <= width - 1, do: x + right, else: rem(x + right, width - 1) - 1
    {new_x, y}
  end

  @doc """
  Checks whether the position in lines is a tree (equal # character).
  """
  def tree?({x, y}, lines) do
    lines |> Enum.at(y) |> String.codepoints() |> Enum.at(x) == @tree
  end
end
