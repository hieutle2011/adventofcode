defmodule AOC2020.Day04Test do
  use ExUnit.Case
  doctest AOC2020

  @line_1 "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"
  @line_4 "hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"

  @invalid_line_1 "eyr:1972 cid:100\nhcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926"
  @invalid_line_2 "iyr:2019\nhcl:#602927 eyr:1967 hgt:170cm\necl:grn pid:012533040 byr:1946"
  @invalid_line_3 "hcl:dab227 iyr:2012\necl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277"
  @invalid_line_4 "hgt:59cm ecl:zzz\neyr:2038 hcl:74454a iyr:2023\npid:3556412378 byr:2007"

  @valid_line_1 "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\nhcl:#623a2f"

  @pp_1 [
    "ecl:gry",
    "pid:860033327",
    "eyr:2020",
    "hcl:#fffffd",
    "byr:1937",
    "iyr:2017",
    "cid:147",
    "hgt:183cm"
  ]

  describe ".solve_p1" do
    test "small" do
      path = "input/day_04_small.txt"
      assert 2 == path |> AOC2020.Day04.solve_p1()
    end

    test "input" do
      path = "input/day_04.txt"
      assert 264 == path |> AOC2020.Day04.solve_p1()
    end
  end

  describe ".solve_p2" do
    test "small" do
      path = "input/day_04_small.txt"
      assert 2 == path |> AOC2020.Day04.solve_p2()
    end

    test "input" do
      path = "input/day_04.txt"
      assert 224 == path |> AOC2020.Day04.solve_p2()
    end
  end

  describe ".valid_passport_p2?" do
    test "valid 1" do
      passport =
        @valid_line_1
        |> AOC2020.Day04.process_line()
        |> AOC2020.Day04.make_passport_map()

      assert AOC2020.Day04.valid_passport_p2?(passport)
    end

    test "invalid 1" do
      passport =
        @invalid_line_1
        |> AOC2020.Day04.process_line()
        |> AOC2020.Day04.make_passport_map()

      assert AOC2020.Day04.valid_passport_p2?(passport) == false
    end

    test "invalid 2" do
      passport =
        @invalid_line_2
        |> AOC2020.Day04.process_line()
        |> AOC2020.Day04.make_passport_map()

      assert AOC2020.Day04.valid_passport_p2?(passport) == false
    end

    test "invalid 3" do
      passport =
        @invalid_line_3
        |> AOC2020.Day04.process_line()
        |> AOC2020.Day04.make_passport_map()

      assert AOC2020.Day04.valid_passport_p2?(passport) == false
    end

    test "invalid 4" do
      passport =
        @invalid_line_4
        |> AOC2020.Day04.process_line()
        |> AOC2020.Day04.make_passport_map()

      assert AOC2020.Day04.valid_passport_p2?(passport) == false
    end
  end

  test ".get_passports_from_input" do
    path = "input/day_04_small.txt"
    passports = AOC2020.Day04.get_passports_from_input(path)
    assert [_ | _] = passports
    assert passports |> Enum.count() == 4
  end

  describe ".process_line" do
    test "case 1" do
      fields = AOC2020.Day04.process_line(@line_1)

      assert fields |> Enum.count() == 8
    end

    test "case 4" do
      fields = AOC2020.Day04.process_line(@line_4)

      assert fields |> Enum.count() == 6
    end
  end

  describe ".make_passport_map" do
    test "case 1" do
      assert %{} = @pp_1 |> AOC2020.Day04.make_passport_map()
    end
  end

  describe ".valid_passport?" do
    test "case 1" do
      map_1 = %{
        "byr" => "1937",
        "cid" => "147",
        "ecl" => "gry",
        "eyr" => "2020",
        "hcl" => "#fffffd",
        "hgt" => "183cm",
        "iyr" => "2017",
        "pid" => "860033327"
      }

      assert AOC2020.Day04.valid_passport?(map_1)
    end

    test "case 2" do
      map_2 = %{
        "byr" => "1929",
        "cid" => "350",
        "ecl" => "amb",
        "eyr" => "2023",
        "hcl" => "#cfa07d",
        "iyr" => "2013",
        "pid" => "028048884"
      }

      assert AOC2020.Day04.valid_passport?(map_2) == false
    end

    test "case 3" do
      map_3 = %{
        "byr" => "1931",
        "ecl" => "brn",
        "eyr" => "2024",
        "hcl" => "#ae17e1",
        "hgt" => "179cm",
        "iyr" => "2013",
        "pid" => "760753108"
      }

      assert AOC2020.Day04.valid_passport?(map_3)
    end

    test "case 4" do
      map_4 = %{
        "ecl" => "brn",
        "eyr" => "2025",
        "hcl" => "#cfa07d",
        "hgt" => "59in",
        "iyr" => "2011",
        "pid" => "166559648"
      }

      assert AOC2020.Day04.valid_passport?(map_4) == false
    end
  end

  describe "byr" do
    test "valid" do
      assert AOC2020.Day04.valid_byr?("2002")
    end

    test "invalid" do
      assert AOC2020.Day04.valid_byr?("2003") == false
    end
  end

  describe "hgt" do
    test "valid" do
      assert AOC2020.Day04.valid_hgt?("60in")
    end

    test "valid 2" do
      assert AOC2020.Day04.valid_hgt?("190cm")
    end

    test "invalid" do
      assert AOC2020.Day04.valid_hgt?("190in") == false
    end

    test "invalid 2" do
      assert AOC2020.Day04.valid_hgt?("190") == false
    end
  end

  describe "hcl" do
    test "valid" do
      assert AOC2020.Day04.valid_hcl?("#123abc")
    end

    test "invalid" do
      assert AOC2020.Day04.valid_hcl?("#123abz") == false
    end

    test "invalid 2" do
      assert AOC2020.Day04.valid_hcl?("123abc") == false
    end
  end

  describe "ecl" do
    test "valid" do
      assert AOC2020.Day04.valid_ecl?("brn")
    end

    test "invalid" do
      assert AOC2020.Day04.valid_ecl?("wat") == false
    end
  end

  describe "pid" do
    test "valid" do
      assert AOC2020.Day04.valid_pid?("000000001")
    end

    test "invalid" do
      assert AOC2020.Day04.valid_pid?("0123456789") == false
    end
  end

  describe "within_range" do
    test "valid" do
      assert AOC2020.Day04.within_range(2, 1, 3)
    end

    test "invalid 1" do
      assert AOC2020.Day04.within_range(0, 1, 3) == false
    end

    test "invalid 2" do
      assert AOC2020.Day04.within_range(4, 1, 3) == false
    end
  end
end
