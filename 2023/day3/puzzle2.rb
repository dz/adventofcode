#!/usr/bin/env ruby

SCHEMATIC = File.readlines('input.txt').to_a.map(&:strip)
RATIOS = {}
GEARS = []

def run
  load_ratios
  SCHEMATIC.each_with_index do |line, y|
    check_line(line, y)
  end
  puts GEARS.map(&:to_i).sum
end

def log_ratios(coords, ratio)
  coords.each do |coord|
    RATIOS["#{coord[0]},#{coord[1]}"] = ratio
  end
end

def load_ratios
  coords = []
  ratio = ""
  SCHEMATIC.each_with_index do |line, y|
    line.each_char.with_index do |char, x|
      if char =~ /[0-9]/
        coords.append([x, y])
        ratio << char
      else
        if ratio.length != 0
          log_ratios(coords, ratio)
        end
        # reset capture
        coords = []
        ratio = ""
      end
    end
    # capture stragglers
    if ratio.length != 0
      log_ratios(coords, ratio)
    end
  end
end

def check_line(line, y)
  line.each_char.with_index do |char, x|
    if char == "*"
      ratio = ratio_for_gear(x, y)
      if ratio
        GEARS << ratio
      end
    end
  end
end

def ratio_for_gear(x, y)
  positions_to_check = [
    # top left, top, top right
    [x-1, y-1], [x, y-1], [x+1, y-1],
    # left, right
    [x-1, y], [x+1, y],
    # bottom left, bottom, bottom right
    [x-1, y+1], [x, y+1], [x+1, y+1]
  ]
  ratios = positions_to_check.map do |coords|
    RATIOS["#{coords[0]},#{coords[1]}"]
  end.uniq.compact.map(&:to_i)

  if ratios.length == 2
    return ratios.reduce(&:*)
  end
end

run
