#!/usr/bin/env ruby

INPUT = "input.txt"

class Card
  attr_reader :score, :matches, :id

  @@cards = {}

  def self.create_copies!
    @@cards.keys.each do |id|
      @@cards[id].first.create_copies!
    end
  end

  def self.cards
    @@cards
  end

  def initialize(id, winning, numbers)
    @id = id
    @winning = winning
    @numbers = numbers
    @matches = (@winning & @numbers).length
    @score = 0
    @@cards[@id] ||= []
    @@cards[@id] << self
  end

  def initialize_clone(other)
    @@cards[other.id] ||= []
    @@cards[other.id] << other
  end

  def local_score
    s = 0
    s = 2**(@matches-1) if @matches > 0
    return s
  end

  def create_copies!
    (@id+1..@id+@matches).each do |id|
      @@cards[id].first.clone.create_copies!
    end
  end
end

def run
  load_cards!
  Card.create_copies!
  total = Card.cards.values.flatten.length
  puts "Total: #{total}"
end

def load_cards!
  File.readlines(INPUT).each do |card|
    id, winning, numbers = card.match(/Card\D+(\d+):([0-9 ]+)\|([0-9 ]+)/i).captures
    winning = winning.split(" ").map(&:strip).map(&:to_i)
    numbers = numbers.split(" ").map(&:strip).map(&:to_i)
    Card.new(id.strip.to_i, winning, numbers)
  end
end


run
