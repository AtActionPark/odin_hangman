require_relative 'lib/hangman'

def load_game
  content = File.open('games/saved_game.yaml', 'r') {|file| file.read }
  YAML.load(content)
end

puts "Type NEW or LOAD"
input = gets.chomp

if input == "NEW" 
  h = Hangman.new
else
  h = load_game
  h.resume_game
end



