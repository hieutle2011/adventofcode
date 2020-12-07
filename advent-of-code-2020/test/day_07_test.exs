defmodule AOC2020.Day07Test do
  use ExUnit.Case
  doctest AOC2020

  alias AOC2020.Day07

  describe ".parse_line" do
    test "case 1" do
      str = "light red bags contain 1 bright white bag, 2 muted yellow bags."

      assert ["light red", "1 bright white", "2 muted yellow"] = Day07.parse_line(str)
    end

    test "case 2" do
      str = "dotted black bags contain no other bags."
      assert ["dotted black", "no other"] = Day07.parse_line(str)
    end

    test "case 3" do
      str = "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags."

      assert ["vibrant plum", "5 faded blue", "6 dotted black"] = Day07.parse_line(str)
    end
  end

  describe ".get_bag_and_quantity" do
    test "case 1" do
      str = "1 bright white"
      assert {1, "bright white"} = Day07.get_bag_and_quantity(str)
    end

    test "case 2" do
      str = "2 bright white"
      assert {2, "bright white"} = Day07.get_bag_and_quantity(str)
    end
  end

  describe "update_map" do
    test "default" do
      line_data = ["light red", "1 bright white", "2 muted yellow"]

      map = Day07.update_map(%{}, line_data)

      assert %{
               "light red" => %AOC2020.Day07.Bag{
                 belongs_to: [],
                 contains: [{2, "muted yellow"}, {1, "bright white"}]
               },
               "bright white" => %AOC2020.Day07.Bag{
                 belongs_to: ["light red"],
                 contains: []
               },
               "muted yellow" => %AOC2020.Day07.Bag{
                 belongs_to: ["light red"],
                 contains: []
               }
             } = map

      line_data_2 = ["dark orange", "3 bright white", "4 muted yellow"]

      new_map = Day07.update_map(map, line_data_2)

      assert %{
               "bright white" => %AOC2020.Day07.Bag{
                 belongs_to: ["dark orange", "light red"],
                 contains: []
               },
               "dark orange" => %AOC2020.Day07.Bag{
                 belongs_to: [],
                 contains: [{4, "muted yellow"}, {3, "bright white"}]
               },
               "light red" => %AOC2020.Day07.Bag{
                 belongs_to: [],
                 contains: [{2, "muted yellow"}, {1, "bright white"}]
               },
               "muted yellow" => %AOC2020.Day07.Bag{
                 belongs_to: ["dark orange", "light red"],
                 contains: []
               }
             } = new_map
    end
  end

  describe "make_map" do
    path = "input/day_07_small.txt"
    map = AOC2020.Day07.make_map(path)

    assert %AOC2020.Day07.Bag{
             belongs_to: ["muted yellow", "bright white"],
             contains: [{2, "vibrant plum"}, {1, "dark olive"}]
           } = map["shiny gold"]

    assert %{
             "bright white" => %AOC2020.Day07.Bag{
               belongs_to: ["dark orange", "light red"],
               contains: [{1, "shiny gold"}]
             },
             "dark olive" => %AOC2020.Day07.Bag{
               belongs_to: ["shiny gold"],
               contains: [{4, "dotted black"}, {3, "faded blue"}]
             },
             "dark orange" => %AOC2020.Day07.Bag{
               belongs_to: [],
               contains: [{4, "muted yellow"}, {3, "bright white"}]
             },
             "dotted black" => %AOC2020.Day07.Bag{
               belongs_to: ["vibrant plum", "dark olive"],
               contains: []
             },
             "faded blue" => %AOC2020.Day07.Bag{
               belongs_to: ["vibrant plum", "dark olive", "muted yellow"],
               contains: []
             },
             "light red" => %AOC2020.Day07.Bag{
               belongs_to: [],
               contains: [{2, "muted yellow"}, {1, "bright white"}]
             },
             "muted yellow" => %AOC2020.Day07.Bag{
               belongs_to: ["dark orange", "light red"],
               contains: [{9, "faded blue"}, {2, "shiny gold"}]
             },
             "shiny gold" => %AOC2020.Day07.Bag{
               belongs_to: ["muted yellow", "bright white"],
               contains: [{2, "vibrant plum"}, {1, "dark olive"}]
             },
             "vibrant plum" => %AOC2020.Day07.Bag{
               belongs_to: ["shiny gold"],
               contains: [{6, "dotted black"}, {5, "faded blue"}]
             }
           } = map
  end

  describe ".recursive_find_all_bag_outside" do
    test "small" do
      path = "input/day_07_small.txt"
      map = AOC2020.Day07.make_map(path)
      assert 4 = map |> Day07.recursive_find_all_bag_outside("shiny gold") |> Enum.count()
    end

    test "input" do
      path = "input/day_07.txt"
      map = AOC2020.Day07.make_map(path)
      assert 205 = map |> Day07.recursive_find_all_bag_outside("shiny gold") |> Enum.count()
    end
  end

  describe ".recursive_find_all_bag_inside" do
    test "small" do
      path = "input/day_07_small.txt"
      map = AOC2020.Day07.make_map(path)
      assert 32 = map |> Day07.recursive_find_all_bag_inside("shiny gold")
    end

    test "input" do
      path = "input/day_07.txt"
      map = AOC2020.Day07.make_map(path)
      assert 80_902 = map |> Day07.recursive_find_all_bag_inside("shiny gold")
    end
  end
end
