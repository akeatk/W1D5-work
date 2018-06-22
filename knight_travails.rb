require_relative "skeleton/lib/00_tree_node"

class KnightPathFinder
attr_reader :move_tree

  def initialize(start_pos = [0, 0])
    @move_tree = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
    build_move_tree
  end

  def new_move_positions(initial_pos)
    KnightPathFinder.valid_moves(initial_pos).select do |pos|
      pos[0] < 8 &&
      pos[1] < 8 &&
      pos[0] >= 0 &&
      pos[1] >= 0 &&
      @visited_positions.none? { |el| pos == el }
    end
  end

  def build_move_tree
    possible_moves = [@move_tree]
    until possible_moves.empty?
      current_node = possible_moves.shift
      new_move_positions(current_node.value).each do |pos|
        temp_node = PolyTreeNode.new(pos)
        temp_node.parent = current_node
        @visited_positions << pos
        possible_moves << temp_node
      end
    end
  end

  def self.valid_moves(pos)
    x, y = pos
    result = []
    result << [x - 2, y - 1]
    result << [x - 2, y + 1]
    result << [x - 1, y - 2]
    result << [x - 1, y + 2]
    result << [x + 1, y - 2]
    result << [x + 1, y + 2]
    result << [x + 2, y - 1]
    result << [x + 2, y + 1]
  end

  def find_path(end_pos)
    trace_back_array = []
    end_node = @move_tree.bfs(end_pos)
    until trace_back_array[0] == @visited_positions[0]
      trace_back_array.unshift(end_node.value)
      end_node = end_node.parent
    end
    trace_back_array
  end
end


kfp = KnightPathFinder.new
p kfp.find_path([7,6])
p kfp.find_path([6,2])
