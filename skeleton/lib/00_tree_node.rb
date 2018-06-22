class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def value
    @value
  end

  def children
    @children
  end

  def parent=(node)
    @parent.children.delete(self) if @parent != nil
    @parent = node
    return nil if node == nil
    unless node.children.include?(self)
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Is not parent" unless @children.include?(child_node)
    child_node.parent = nil if child_node.is_a?(PolyTreeNode)
  end

  def dfs(target_value)
    return self if target_value == @value
    @children.each do |child|
      temp_node = child.dfs(target_value)
      return temp_node if temp_node.is_a?(PolyTreeNode)
    end
    nil
  end

  def bfs(target_value)
    current_nodes = [self]
    until current_nodes.empty?
      return current_nodes[0] if current_nodes[0].value == target_value
      current_nodes += current_nodes.shift.children
    end
    nil
  end

end
