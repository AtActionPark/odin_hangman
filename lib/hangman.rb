class Hangman
  require 'yaml'

  attr_reader :win
  attr_reader :lost
  attr_reader :word

  def initialize
    @word = ""
    @guess = []
    @false_letters = [""]
    @win = false
    @lost = false
    @remaining_turns = 10
    pick_word
    game_loop
  end

  def pick_word
    @text = File.open("5desk.txt", "r").readlines
   
    while !@word.length.between?(5,12) do
      @word = @text[rand(@text.size)][0..-2].downcase
    end

    @word.split('').each do |l|
      @guess << "_"
    end
  end

  def pick_letter
    puts "Please pick a letter"
    @letter = gets.chomp
    if @letter == "1"
      save_game
    end

    @letter_found = false
    @word.split('').each_with_index do |l,i|
      if @letter == l 
        @guess[i] = l 
        @letter_found = true
      end
    end
    if !@letter_found
      @false_letters << @letter
      @remaining_turns -=1
    end
    puts @guess.join(' ') + "     Remaining turns: #{@remaining_turns}  |  " + "Wrong letters : " + @false_letters.join(" ")
  end

  def check_state
    @win = !@guess.include?("_")
    @lost = @remaining_turns <1
  end

  def save_game
    Dir.mkdir('games') unless Dir.exist? 'games'
    @filename = 'games/saved_game.yaml'
    File.open(@filename, 'w') do |file|
      file.puts YAML.dump(self)
    end
    puts "Game saved as #{@filename}"
    exit
  end

  def resume_game
    puts @guess.join(' ') + "     Remaining turns: #{@remaining_turns}  |  " + "Wrong letters : " + @false_letters.join(" ")
    game_loop
  end


  def game_loop
    while !@win   && !@lost  do
      puts "Input a letter or press 1 to save"
      pick_letter
      check_state
    end

    if !@guess.include?("_")
      puts "you won" 
    else
      puts "you lost"
      puts "the word was #{@word}"
    end
  end
end


