require_relative 'player'
require_relative 'board'

class Game
  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
    loop do
      @board.display
      valid_move = false #tracks if player's move is valid

      until valid_move # loop continues until the player makes a valid move
        move = @current_player.get_move # asks the current player for their move
        position = map_move_to_position(move) #Converts the player's move (1-9) into row and column indices

        if position && @board.place_move(position[0], position[1], @current_player.marker) #access row and column index
          valid_move = true # checks if the move is valid and places it on the board. If successful, valid_move is set to true
        else
          puts "Invalid move. Please try again."
        end
      end

      if @board.winner?
        puts "#{@current_player.name} wins!"
        break
      end
      switch_players
    end
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def map_move_to_position(move)
    position_map = {
      1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2]
    }
    position_map[move]
  end
end

player1 = Player.new("Player 1", "X")
player2 = Player.new("Player 2", "O")
game = Game.new(player1, player2)
game.play
