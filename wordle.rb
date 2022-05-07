#!/usr/bin/env ruby
# https://www.nytimes.com/games/wordle/

Gray = 'gray'
Yellow = 'yellow'
Green = 'green'

class Wordle
  def hint(*hint)
    position = 0
    hint.each do |hash|
      position += 1
      char = hash.keys[0]
      case hash[char]
      when Gray then
        duplicated_gray = false
        # 同じ文字でグリーンが存在する場合、
        # グレーは「存在しない」ではなく「重複しない」という意味になる
        hint.each do |hash|
          if char === hash.keys[0] then
            if hash[hash.keys[0]] === Green then
              duplicated_gray = true
            end
          end
        end
        if duplicated_gray then
          @dict = @dict.grep_v(/#{char}.*#{char}/)
        else
          @dict = @dict.grep_v(/#{char}/)
        end
      when Yellow then
        @dict = @dict.grep(/#{char}/).grep_v(/^#{'.' * (position-1)}#{char}/)
      when Green then
        @dict = @dict.grep(/^#{'.' * (position-1)}#{char}/)
      end
    end
  end

  def initialize
    @dict = []
    File.foreach('/usr/share/dict/words') do |line|
      line.chomp!
      if line.length == 5 then
        @dict.push(line.upcase)
      end
    end
  end

  def report
    @dict.each do |word|
      puts word
    end

    # 何文字めに、どの文字が何回出現しているかを格納
    occurrences = {}
    order = []

    for position in 0..4 do
      occurrences[position] = {}
      @dict.each do |word|
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
  end
end

w = Wordle.new
w.hint({A: Gray},
       {R: Gray},
       {I: Yellow},
       {S: Green},
       {E: Gray})
w.hint({K: Gray},
       {I: Green},
       {S: Gray},
       {S: Green},
       {Y: Gray})
w.report
