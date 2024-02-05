require_relative('Player.rb')

class Game
  attr_accessor :players

  def initialize ()
    @players = []
    @guesses = []
    @turn_no = 0
    @secret = Array.new(4, "0")
    
    self.setup_game
    self.setup_code
    self.game_play
  end

  def setup_game()
    puts "Welcome to Mastermind!"
    puts "\n"
    ### For V2
    # puts "Please enter the Code Maker's name:"
    # codemaker = Player.new(gets.chomp.capitalize, "M", false)
    # codemaker = Player.new("Computer", "M", false)
    # @players << codemaker
    # puts "\n"
    puts "Please enter your name:"
    codebreaker = Player.new(gets.chomp.capitalize, "B", true)
    @players << codebreaker
    puts "\n"
    ### For V2
    # puts "Welcome Code Maker #{codemaker.name} and Code Breaker #{codebreaker.name}!"
    puts "Welcome Code Breaker #{codebreaker.name}!"
    puts "\n"
    puts "In this game only the digits 1 - 9 are used. There are no duplicates & no blanks."
    # # # >>>>>> Easier Testing
    # codemaker = Player.new("Computer", "M", false)
    # @players << codemaker
    # codebreaker = Player.new("Breaker", "B", true)
    # @players << codebreaker
  end

  def setup_code
    @secret = ("1".."9").to_a.shuffle.slice(0,4)
  end

  def draw_board
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

  def game_play
    while @turn_no < 12 do
      self.draw_board
      self.request_guess
      @turn_no += 1
    end

    puts "Game over. You lose!" if @turn_no == 12 
  end

  def request_guess
    puts "Enter your 4 digit guess."
    guess = gets.chomp.split("")
    validate_guess(guess)
  end

  def validate_guess(guess)
    if guess.filter { |x| x.match?(/[1-9]/) }.length != 4
      puts "Check your guess. It should be 4 digits from 1 to 9 only. Try again!"
      self.request_guess
    else
      check_guess(guess)
    end
  end

  private 
  def check_guess(guess)
    if guess == @secret 
      puts "You Win!"
      exit
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
  
  def self 
    @@all
  end
end