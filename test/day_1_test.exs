defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  @sample_text File.read!("./inputs/day_1.txt")

  test "gets the correct sum" do
    assert Day1.solve(@sample_text) == 54473
  end
end
