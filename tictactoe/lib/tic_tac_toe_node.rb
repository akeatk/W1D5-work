require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @mark = next_mover_mark
    @prev_move = prev_move_pos
  end

  def losing_node?(evaluator)
    enemy_mark = :x
    enemy_mark = :o if evaluator == :x
    return true if @board.winner == enemy_mark
    children.each do |next_move|
      return false unless next_move.losing_node?(evaluator)
    end
    true
  end

  def winning_node?(evaluator)
    return true if @board.winner == evaluator
    children.each do |next_move|
      return true if next_move.winning_node?(evaluator)
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result_array = []
    3.times do |row|
      3.times do |col|
        if @board.empty?([row, col])
          next_possible_board = @board.dup[[row,col]] = @mark
          next_mark = :x
          next_mark = :o if @mark == :x
          prev_move_pos = [row, col]
          result_array << TicTacToeNode.new(next_possible_board, next_mark, prev_move_pos)
        end
      end
    end
    result_array
  end
end
