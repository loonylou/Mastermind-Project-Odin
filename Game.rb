require_relative('Player.rb')

class Game
  def initialize()
    @players = []
    @guesses = []
    @turn_no = 0
    @secret = Array.new(4, "0")
    
    self.setup_game
    self.setup_secret_code
    # puts 'secret: ' + @secret.to_s # testing
    self.game_play
  end

  def setup_game()
    puts "**********************"
    puts "Welcome to Mastermind!"
    puts "\n"
    puts "Which role do you want to play as?"
    puts "Code Maker - type 1"
    puts "Code Breaker - type 2"
    role = gets.chomp

    if role == "1"
      puts "Welcome Code Maker. Please enter your name:"
      codebreaker = Player.new("Computer", "B")
      codemaker = Player.new(gets.chomp.capitalize, "M")
      @players << codebreaker
      @players << codemaker
    else
      puts "Welcome Code Breaker. Please enter your name:"
      codemaker = Player.new("Computer", "M") 
      codebreaker = Player.new(gets.chomp.capitalize, "B")
      @players << codemaker
      @players << codebreaker
    end

    puts "\n"
    puts "Welcome Code Maker #{codemaker.name} and Code Breaker #{codebreaker.name}!"
    puts "\n"
    puts "In this game only the digits 1 - 9 are used. There are no duplicates & no blanks."
    puts "\n"
  end

  def setup_secret_code()
    if @players[0].role == "M"
      @secret = ("1".."9").to_a.shuffle.slice(0,4)
    else
      puts "Please enter your secret code. It should be 4 digits from 1 to 9 only. Blanks are not allowed. Duplicates are not allowed."
      puts "\n"
      human_code = gets.chomp.split("")
      if validate_code(human_code, 's') == true
        @secret = human_code 
      else 
        puts "Error! Try again!"
        puts "\n"
        self.setup_secret_code
      end
    end
  end 

  def draw_board()
    puts "\n"
    puts "**** MASTERMIND ****"
    puts "\n"
    puts Array.new(4, "0").to_s
    puts "\n"
    
    @guesses.each_with_index do |guess, index|
      puts (index.to_i + 1).to_s + " of 12 : " + guess.to_s
    end

    puts "\n"
  end

  def game_play()
    while @turn_no < 12 do
      draw_board()
      request_guess_code()
      @turn_no += 1
    end

    breaker_loses_game() if @turn_no == 12 
  end

  def request_guess_code()
    if @players[0].role == "B"
      guess = ("1".."9").to_a.shuffle.slice(0,4)
      check_guess(guess)
    else
      puts "Enter your 4 digit guess."
      guess = gets.chomp.split("")

      if validate_code(guess, 'g') == true 
        check_guess(guess)
      else
        puts "Error! Codes are 4 digits from 1 to 9. Try again!"
        request_guess_code()
      end
    end 
  end

  def validate_code(code, type) # Type s = secret & g = guess
    length_nums_blank_check = code.filter { |x| x.match?(/[1-9]/) }.length

    if length_nums_blank_check == 4 
      if type == "g" # guess
        return true
      else # secret
        code.uniq.length == 4 ? true : false
      end
    else
      return false
    end
  end

  private def check_guess(guess)
    if guess == @secret
      breaker_wins_game()
    else 
      result = guess.map.with_index do |v, i|
        @secret.include?(v) ? v == @secret[i] ? v : "?" : "0"  
      end
      @guesses[@turn_no] = { 
        "guess" => guess,
        "result" => result
      }
    end
  end

  private def breaker_wins_game() 
    if @players[1].role == "B"
      puts "Congratulations " + @players[1].name + "! You beat the Computer."
      exit
    else
      puts @players[1].name + ' you have been beaten by the Computer. Better luck next time!'
      exit
    end
  end

  private def breaker_loses_game() 
    if @players[1].role == "B"
      puts @players[1].name + ' you have been beaten by the Computer. Better luck next time!'
      exit
    else
      puts "Congratulations " + @players[1].name + "! You beat the Computer."
      exit
    end
  end
  
  def self 
    @@all
  end
end