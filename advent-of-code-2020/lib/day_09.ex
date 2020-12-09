defmodule AOC2020.Day09 do
  @moduledoc """
  Module Day 9
  """

  alias AOC2020.Day01

  @doc """
  What is the first number which is not the sum of two of the `preamble` numbers before it?
  """
  def solve_p1(path, preamble) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> make_queue()
    |> get_mapping_number_result(preamble, [])
    |> Enum.filter(&(&1.valid == false))
    |> Enum.reverse()
    |> Enum.at(0)
  end

  @doc """
  Add together the smallest and largest number in this contiguous range
  """
  def solve_p2(path, target) do
    result =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> start_find_contigous([], target)
      |> List.flatten()

    Enum.max(result) + Enum.min(result)
  end

  @doc """
  Find sub_arrays `result` where sum all members equal to the  `sum_target`
  """
  def start_find_contigous(arr, result, sum_target, min_elem \\ 2)

  def start_find_contigous([], result, _sum_target, _min_elem), do: result

  def start_find_contigous([_head | tail] = arr, result, sum_target, min_elem) do
    case find_contigous_arr_where_sum(arr, [], [], sum_target, min_elem) do
      {:ok, [_ | _] = acc} ->
        start_find_contigous(tail, [acc | result], sum_target, min_elem)

      _ ->
        start_find_contigous(tail, result, sum_target, min_elem)
    end
  end

  def find_contigous_arr_where_sum([], _sub_arr, acc, _, _), do: {:ok, acc}

  def find_contigous_arr_where_sum(arr, sub_arr, acc, 0, min_elem) do
    # all items in sub_arr have sum equal original sum_target
    original_sum_target = Enum.sum(sub_arr)

    case Enum.count(sub_arr) >= min_elem do
      true ->
        find_contigous_arr_where_sum(arr, [], [sub_arr | acc], original_sum_target, min_elem)

      false ->
        find_contigous_arr_where_sum(arr, [], acc, original_sum_target, min_elem)
    end
  end

  def find_contigous_arr_where_sum([head | tail], sub_arr, acc, sum_target, min_elem) do
    cond do
      sum_target - head >= 0 ->
        # run with reduced array tail and substract target
        find_contigous_arr_where_sum(tail, [head | sub_arr], acc, sum_target - head, min_elem)

      sum_target - head < 0 ->
        # run with original sum_target
        original_sum_target = Enum.sum(sub_arr) + sum_target
        find_contigous_arr_where_sum(tail, [], acc, original_sum_target, min_elem)
    end
  end

  def get_mapping_number_result({[], []}, _preamble, arr), do: arr

  def get_mapping_number_result(queue, preamble, arr) do
    %{next_arr: target_arr, new_queue: new_queue, two_sum: two_sum} =
      make_list_from_preamble(queue, preamble)

    case valid_next_number?(target_arr, two_sum) do
      false ->
        get_mapping_number_result(new_queue, preamble, [
          %{target_number: two_sum, valid: false} | arr
        ])

      tuple ->
        get_mapping_number_result(new_queue, preamble, [
          %{target_number: two_sum, valid: true, numbers: tuple} | arr
        ])
    end
  end

  def valid_next_number?(arr, num) do
    case Day01.solve_p1(arr, num) do
      nil -> false
      pair -> pair
    end
  end

  def make_queue(arr) do
    arr
    |> Enum.reduce(:queue.new(), fn elem, q -> :queue.in(elem, q) end)
  end

  def make_list_from_preamble(queue, number) do
    {[head | tail], _} =
      1..(number + 1)
      |> Enum.reduce({[], queue}, fn _, acc ->
        {arr, q} = acc

        case :queue.out(q) do
          {{:value, value}, q} ->
            {[value | arr], q}

          _ ->
            acc
        end
      end)

    {{:value, _}, new_queue} = :queue.out(queue)

    %{next_arr: tail, new_queue: new_queue, two_sum: head}
  end
end
