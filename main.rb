# Build a Mastermind game from the command line where you have 12 turns to guess the secret code.

# V1: Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!

require_relative('Game.rb')
require_relative('Player.rb')

############### Gameplay
g = Game.new