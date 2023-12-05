defmodule Day4 do
  @moduledoc """
  AdventOfCode2023 Day 4 Solution.

  Link: https://adventofcode.com/2023/day/4
  """

  def solve_part_1(text) do
    text
    |> String.split("\n")
    |> Enum.map(&Card.init/1)
    |> Enum.reduce(0, fn card, acc -> get_score(card.wins) + acc end)
  end

  def solve_part_2(text) do
    text
    |> String.split("\n")
    |> Enum.map(&Card.init/1)
    |> count_total_cards(0)
  end

  # calculate card score based on rules of AOC part 1
  def get_score(wins, score \\ 0) do
    if wins == 0 do
      score
    else
      new_score = max(score * 2, 1)
      get_score(wins - 1, new_score)
    end
  end

  # recurse through card info and update frequencies of cards
  def count_total_cards([], count), do: count

  def count_total_cards([%{wins: wins, frequency: fr} | card_list], count) do
    updated_card_list = update_frequencies(card_list, wins, fr)
    count_total_cards(updated_card_list, count + fr)
  end

  # update frequencies of cards in card list
  def update_frequencies(card_list, 0, _frequency), do: card_list

  def update_frequencies(card_list, wins, frequency) do
    card_list
    |> List.update_at(wins - 1, fn card -> %{card | frequency: card.frequency + frequency} end)
    |> update_frequencies(wins - 1, frequency)
  end
end

defmodule Card do
  @moduledoc """
  Stores the amount of wins a card has, as well as the frequency it comes up
  As cards become multiplies based on the rules of AoC  Day 4 part 2
  The frequency value will increase and be used when calculating the frequencies
  of other cards that come after it
  """
  defstruct wins: 0, frequency: 1

  def init(card_text) do
    card_text
    |> get_card_numbers
    |> filter_winning_numbers
    |> format_card
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

  # creates a new Card based on the amount of winning numbers
  def format_card(winning_numbers) do
    %Card{wins: length(winning_numbers)}
  end
end
