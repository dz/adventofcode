#!/usr/bin/env ruby

RED = 12
GREEN = 13
BLUE = 14

def simulate_games
  games = read_games('input.txt')

  # part 1
  possible_ids = []
  games.each do |game|
    if game[:drawings].map {|d| possible_draw(d) }.all?
      possible_ids.append(game[:id])
    end
  end
  puts "Part 1 sum: #{possible_ids.sum}"

  #part 2
  powers_sum = games.map do |game|
    minimum_draw(game[:drawings])
  end.sum

  puts "Part 2 sum: #{powers_sum}"
end

def minimum_draw(drawings)
  colors = [:r, :g, :b]
  return colors.map { |color| drawings.map { |d| d[color] }.max }.reduce(:*)
end

def possible_draw(d)
  d[:r] <= RED && d[:g] <= GREEN && d[:b] <= BLUE
end

def read_games(path)
  File.readlines(path).map do |line|
    parse_game(line)
  end
end

def parse_game(line)
  game_id, results = line.match(/Game (\d+)\:(.*)/i).captures
  drawings = []
  results.delete(' ').delete(',').split(";").each do |drawing|
    get_color = lambda {|color| (drawing.match(/\s*(\d+)\s*#{color}/i)&.captures&.first || 0).to_i }
    drawings.append({r: get_color.('red'), g: get_color.('green'), b: get_color.('b')})
  end
  return {
    id: game_id.to_i,
    drawings: drawings
  }
end

simulate_games
