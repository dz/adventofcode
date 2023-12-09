#!/usr/bin/env ruby

CARDS = []
INPUT = "input.txt"

class Card
  attr_reader :score

  def initialize(id, winning, numbers)
    @id = id
    @winning = winning
    @numbers = numbers
    @matches = 0
    @score = 0
    score_card
  end

  private
  def score_card
    @matches = (@winning & @numbers).length
    @score = 2**(@matches-1) if @matches > 0
    puts "Scoring #{@id}\nMatches: #{@matches} Score: #{score}\nWinning: #{@winning.to_s}\nNumbers: #{@numbers.to_s}\n\n"
  end
end

def run
  load_cards
  total = CARDS.reduce(0) do |sum, card|
    sum + card.score
  end

  puts "Total: #{total}"
end

def load_cards
  File.readlines(INPUT).each do |card|
    id, winning, numbers = card.match(/Card\D+(\d+):([0-9 ]+)\|([0-9 ]+)/i).captures
    winning = winning.split(" ").map(&:strip).map(&:to_i)
    numbers = numbers.split(" ").map(&:strip).map(&:to_i)
    CARDS.push(Card.new(id, winning, numbers))
  end
end


run
