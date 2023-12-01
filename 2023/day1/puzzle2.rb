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
  first, last = nil
  first_value, last_value = nil
  word_map.flatten.each do |match|
    # first occurance
    lposition = line.index(match.to_s)
    if first.nil? || (lposition && lposition < first)
      first = lposition
      first_value = match
    end
    # last occurnce
    rposition = line.rindex(match.to_s)
    if last.nil? || (rposition && rposition > last)
      last = rposition
      last_value = match
    end
  end
  # noromalize to stringified digit
  first_digit = (word_map[first_value] || first_value).to_s
  last_digit = (word_map[last_value] || last_value).to_s
  sum += (first_digit + last_digit).to_i
end

puts "digits+words: #{sum}"
