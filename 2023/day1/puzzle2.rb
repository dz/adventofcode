#!/usr/bin/env ruby
sum = 0

word_map = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9
}

File.readlines('input.txt').each do |line|
  d1, d2 = line.match(/\D*(\d)?.*(\d)\D*/i).captures
  sum += ((d1 || d2).to_s + d2.to_s).to_i
end
puts "digits+words: #{sum}"
