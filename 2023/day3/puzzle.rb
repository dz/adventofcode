#!/usr/bin/env ruby

SCHEMATIC = File.readlines('input.txt').to_a.map(&:strip)
SYMBOLS = {}
PARTS = []

def run
  load_symbols
  SCHEMATIC.each_with_index do |line, y|
    check_line(line, y)
  end
  puts PARTS.map(&:to_i).sum
end

def load_symbols
  SCHEMATIC.each_with_index do |line, y|
    line.each_char.with_index do |char, x|
      if !char.match?(/(\.|[0-9])/)
        SYMBOLS["#{x},#{y}"] = true
      end
    end
  end
end

def check_line(line, y)
  # run through each character, capturing numbers along the way
  # once a number ends, check to see if it is a part number
  coords = []
  part = ""
  line.each_char.with_index do |char, x|
    if char =~ /[0-9]/
      coords.append([x, y])
      part << char
    else
      # if we were reading a part, check and log it
      if part.length != 0
        if is_part_number(coords)
          PARTS.append(part)
        end
      end
      # reset capture
      coords = []
      part = ""
    end
  end
  # capture stragglers
  if part.length != 0
    if is_part_number(coords)
      PARTS.append(part)
    end
  end
end

# given an array of coords, check symbol list
def is_part_number(coords)
  coords.map { |coords| check_coords(coords[0], coords[1]) }.any?
end

def check_coords(x, y)
  positions_to_check = [
    # top left, top, top right
    [x-1, y-1], [x, y-1], [x+1, y-1],
    # left, right
    [x-1, y], [x+1, y],
    # bottom left, bottom, bottom right
    [x-1, y+1], [x, y+1], [x+1, y+1]
  ]
  positions_to_check.map do |coords|
    SYMBOLS["#{coords[0]},#{coords[1]}"]
  end.any?
end


run
