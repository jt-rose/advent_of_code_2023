defmodule Day4 do
  @moduledoc """
  AdventOfCode2023 Day 4 Solution.

  Link: https://adventofcode.com/2023/day/4
  """

  def solve_part_1(text) do
    text
    |> String.split("\n")
    |> Enum.map(&get_card_numbers/1)
    |> Enum.map(&filter_winning_numbers/1)
    |> Enum.map(&get_score/1)
    |> Enum.sum()
  end

  def solve_part_2(text) do
    card_list_info =
      text
      |> String.split("\n")
      |> Enum.map(&get_card_numbers/1)
      |> Enum.map(&filter_winning_numbers/1)

    repetitions = List.duplicate(1, length(card_list_info))

    count_total_cards(card_list_info, 0, repetitions)
  end

  # recurse through card info and update current and future repetitions of cards
  def count_total_cards([], count, _reps), do: count

  def count_total_cards([card_info | card_info_list], count, [rep | repetitions]) do
    len = length(card_info)

    updated_reps = update_cycles(repetitions, rep, len)
    count_total_cards(card_info_list, count + rep, updated_reps)
  end

  # update how many times each of the next cards will appear
  def update_cycles(repetitions, _multiplier, 0), do: repetitions

  def update_cycles(repetitions, multiplier, len) do
    repetitions
    |> List.update_at(len - 1, &(&1 + multiplier))
    |> update_cycles(multiplier, len - 1)
  end

  # extract the winning numbers and user numbers from the card text
  def get_card_numbers(card_info) do
    card_info
    |> String.replace(~r/Card\s+\d+\:/, "")
    |> String.split("\|")
    |> Enum.map(fn items -> Regex.scan(~r/\d+/, items) |> List.flatten() end)
  end

  # return a list of user numbers that were winners
  def filter_winning_numbers([winning_nums, user_nums]) do
    Enum.filter(user_nums, fn x -> x in winning_nums end)
  end

  # update overall score based on score formula in AOC instructions
  def get_score(matching_cards) do
    Enum.reduce(matching_cards, 0, fn _x, acc -> max(acc * 2, 1) end)
  end
end
