# Build a Mastermind game from the command line where you have 12 turns to guess the secret code.

# V1: Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!

# V2: Refactor your code to allow the human player to choose whether they want to be the creator of the secret code or the guesser.Build it out so that the computer will guess if you decide to choose your own secret colors. You may choose to implement a computer strategy that follows the rules of the game or you can modify these rules.

require_relative('Game.rb')
require_relative('Player.rb')

############### Gameplay
g = Game.new