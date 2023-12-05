defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  @sample_text File.read!("./inputs/day_4/sample.txt")
  @input_text File.read!("./inputs/day_4/input.txt")
  @sample_card "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

  test "part 1 is correct" do
    assert Day4.solve_part_1(@sample_text) == 13
    assert Day4.solve_part_1(@input_text) == 23235
  end

  test "part 2 is correct" do
    assert Day4.solve_part_2(@sample_text) == 30
    assert Day4.solve_part_2(@input_text) == 5_920_640
  end

  test "get_card_numbers is correct" do
    assert Card.get_card_numbers(@sample_card) == [
             ["41", "48", "83", "86", "17"],
             ["83", "86", "6", "31", "17", "9", "48", "53"]
           ]
  end
end
