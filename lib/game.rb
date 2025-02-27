class Game

attr_accessor :board, :player_1, :player_2

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],

     ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.find do |winner|
      @board.cells[winner[0]] == @board.cells[winner[1]] &&
      @board.cells[winner[1]] == @board.cells[winner[2]] &&
      (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
  end
end

def draw?
  @board.full? && !won?
end

def over?
  won? || draw?
end

def winner
  if win_combo = won?
    @winner = @board.cells[win_combo.first]
  end
end

def turn
  puts "It's #{current_player.token}'s turn."
   @user_input = current_player.move(@board).to_i
   if @board.valid_move?(@user_input.to_s)
     board.update(@user_input, current_player)
   else
     puts "This move is invalid. Please try again"
     turn
   end
end

def play
  while !over?
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end

end

end
