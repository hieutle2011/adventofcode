defmodule AOC2020.Day07BagTest do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day07.Bag

  describe "init bag" do
    test "default" do
      assert %Bag{contains: [], belongs_to: []} = %Bag{}
    end
  end
end
