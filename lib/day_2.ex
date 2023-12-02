defmodule Day2 do
  @moduledoc """
  AdventOfCode2023 Day 2 Solution.

  Link: https://adventofcode.com/2023/day/2
  """
  @blue_count_regex ~r/(\d+) blue/
  @red_count_regex ~r/(\d+) red/
  @green_count_regex ~r/(\d+) green/

  @type max_colors :: %{blue: integer(), red: integer(), green: integer()}

  @spec solve_part_1(binary(), max_colors()) :: integer()
  def solve_part_1(text, max_colors) do
    text
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn game -> map_valid_game_id(game, max_colors) end)
    |> Enum.sum()
  end

  @spec solve_part_2(binary()) :: integer()
  def solve_part_2(text) do
    text
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&get_minimum_req_power/1)
    |> Enum.sum()
  end

  def map_valid_game_id(game, max_colors) do
    [_, game_id] = Regex.run(~r/Game (\d+)/, game)
    blue_count = map_color_results(game, @blue_count_regex)
    red_count = map_color_results(game, @red_count_regex)
    green_count = map_color_results(game, @green_count_regex)

    invalid_blues = is_invalid_game?(blue_count, Map.get(max_colors, :blue))
    invalid_reds = is_invalid_game?(red_count, Map.get(max_colors, :red))
    invalid_greens = is_invalid_game?(green_count, Map.get(max_colors, :green))

    if invalid_blues or invalid_reds or invalid_greens do
      0
    else
      String.to_integer(game_id)
    end
  end

  def get_minimum_req_power(game) do
    blue_count = map_color_results(game, @blue_count_regex) |> Enum.max()
    red_count = map_color_results(game, @red_count_regex) |> Enum.max()
    green_count = map_color_results(game, @green_count_regex) |> Enum.max()

    blue_count * red_count * green_count
  end

  def map_color_results(game, regex) do
    Regex.scan(regex, game)
    |> Enum.map(fn [_, count] -> String.to_integer(count) end)
  end

  def is_invalid_game?(color_results, max) do
    Enum.any?(color_results, fn x -> x > max end)
  end
end
