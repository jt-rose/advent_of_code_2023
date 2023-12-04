defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  @sample_text File.read!("./inputs/day_2.txt")

  @max_colors %{
    blue: 14,
    green: 13,
    red: 12
  }

  test "part 1 is correct" do
    assert Day2.solve_part_1(@sample_text, @max_colors) == 1734
  end

  test "part 2 is correct" do
    assert Day2.solve_part_2(@sample_text) == 70387
  end

  def sample_2() do
    "Game 1: 4 green, 3 blue, 11 red; 7 red, 5 green, 10 blue; 3 green, 8 blue, 8 red; 4 red, 12 blue; 15 red, 3 green, 10 blue"
  end
end
