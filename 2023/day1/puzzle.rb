#!/usr/bin/env ruby
sum = 0
File.readlines('input.txt').each do |line|
  d1, d2 = line.match(/\D*(\d)?.*(\d)\D*/i).captures
  sum += ((d1 || d2).to_s + d2.to_s).to_i
end

puts sum
