defmodule Day1 do
  @moduledoc """
  AdventOfCode2023 Day 1 Solution.

  Link: https://adventofcode.com/2023/day/1
  """

  @number_strings ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @number_words %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def solve(text) do
    text
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&get_calibration_value/1)
    |> Enum.sum()
  end

  defp get_calibration_value(str) do
    first_int = find_starting_num(str)
    last_int = find_ending_num(str)

    first_int * 10 + last_int
  end

  defp find_starting_num(str) do
    [num] = Regex.run(~r/\d|one|two|three|four|five|six|seven|eight|nine/, str)
    num |> convert_to_int()
  end

  defp find_ending_num(str) do
    [_, num] = Regex.run(~r/.*(\d|one|two|three|four|five|six|seven|eight|nine)/, str)
    num |> convert_to_int()
  end

  defp convert_to_int(num) when num in @number_strings do
    String.to_integer(num)
  end

  defp convert_to_int(number_word) do
    Map.get(@number_words, number_word)
  end
end
