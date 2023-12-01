#!/usr/bin/env ruby
sum = 0
File.readlines('input.txt').each do |line|
  puts line
  d1, d2 = line.match(/\D*(\d)?.*(\d)\D*/i).captures
  d1 = d2 if d1.nil?
  digits = (d1.to_s + d2.to_s).to_i
  puts digits
  sum += digits
end

puts sum
