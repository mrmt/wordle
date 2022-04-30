#!/usr/bin/env ruby
# https://www.nytimes.com/games/wordle/

dict = []

File.foreach('/usr/share/dict/words') do |line|
  line.chomp!
  if line.length == 5 then
    dict.push(line.upcase)
  end
end

dict = dict.grep(/R/)
dict = dict.grep(/A/)
dict = dict.grep(/I/)
dict = dict.grep(/S/)
dict = dict.grep(/E/)

dict.each do |word|
  puts word
end

# 何文字めに、どの文字が何回出現しているかを格納
occurrences = {}
order = []

for position in 0..4 do
  occurrences[position] = {}
  dict.each do |word|
    char = word.slice(position)
    if occurrences[position][char] == nil then
      occurrences[position][char] = 1
    else
      occurrences[position][char] += 1
    end
  end

  order[position] = []
  occurrences[position].keys.sort do |a, b|
    occurrences[position][b] <=> occurrences[position][a]
  end.each do |char|
    order[position].push(char);
  end
end

loop do
  buf = []
  for position in 0..4 do
    if char = order[position].shift then
      buf.push(sprintf('%4d %s', occurrences[position][char], char))
    else
      buf.push('      ')
    end
  end

  s = buf.join('  ')
  if s.match(/^\s+$/) then
    exit
  end
  puts s
end
