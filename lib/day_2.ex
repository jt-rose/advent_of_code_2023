defmodule Day2 do
  @moduledoc """
  AdventOfCode2023 Day 2 Solution.

  Link: https://adventofcode.com/2023/day/2
  """

  @regex_map %{
    blue: ~r/(\d+) blue/,
    red: ~r/(\d+) red/,
    green: ~r/(\d+) green/
  }

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

  # define default color values
  def map_valid_game_id(game, max_colors, colors \\ [:blue, :red, :green])

  # define success case and extract game id
  def map_valid_game_id(game, _max_colors, []) do
    [_, game_id] = Regex.run(~r/Game (\d+)/, game)
    String.to_integer(game_id)
  end

  # check for valid color amount, abort with 0 if invalid
  def map_valid_game_id(game, max_colors, [color | colors]) do
    regex = Map.get(@regex_map, color)
    max_allowed = Map.get(max_colors, color)
    count = map_color_results(game, regex)

    if is_invalid_game?(count, max_allowed) do
      0
    else
      map_valid_game_id(game, max_colors, colors)
    end
  end

  # extract integer counts for each color in a game
  def map_color_results(game, regex) do
    Regex.scan(regex, game)
    |> Enum.map(fn [_, count] -> String.to_integer(count) end)
  end

  # check if invalid color amount present
  def is_invalid_game?(color_results, max) do
    Enum.any?(color_results, fn x -> x > max end)
  end

  # get power of minimally required amount for each color
  def get_minimum_req_power(game) do
    %{
      blue: blue_regex,
      red: red_regex,
      green: green_regex
    } = @regex_map

    blue_count = map_color_results(game, blue_regex) |> Enum.max()
    red_count = map_color_results(game, red_regex) |> Enum.max()
    green_count = map_color_results(game, green_regex) |> Enum.max()

    blue_count * red_count * green_count
  end
end
