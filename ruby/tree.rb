class Tree
  attr_accessor :children, :node_name

  # Builds a tree using one of two approaches. One method is to supply a hash
  # representing the tree structure, e.g.
  #   Tree.new('grandpa' => { 'dad' => { 'child 1' => {}, 'child 2' => {} } })
  # Alternatively, you can supply the root node name and the children, e.g.
  #   Tree.new('grandpa', [
  #     Tree.new('dad', [Tree.new('child 1'), Tree.new('child 2')])
  #   ])
  def initialize(name_or_hash, children=[])
    #  TODO: look at a cleaner way to make the following decision
    #  <02-09-19, Amanda>
    if name_or_hash.respond_to?(:keys) && name_or_hash.respond_to?(:values)
      hash_tree = HashTree.new(name_or_hash)
      @node_name = hash_tree.root_name
      @children = hash_tree.children
    else
      @children = children
      @node_name = name_or_hash
    end
  end

  def visit_all(&block)
    visit &block
    children.each { |c| c.visit_all &block }
  end

  def visit(&block)
    block.call self
  end

  def inspect
    children_s = children.map(&:inspect).join(', ')
    "<Tree:#{object_id} children=[#{children_s}] node_name=\"#{node_name}\" >"
  end

  class HashTree
    #  TODO: check to make sure the structure is right, e.g. just one root
    #  node <02-09-19, Amanda>
    def initialize(hash)
      @hash = hash
    end

    def to_h
      @hash
    end

    def to_tree
      Tree.new(root, children)
    end

    def children
      sub_trees.map do |sub_tree|
        sub_tree.tail == {} ? Tree.new(sub_tree.root) : Tree.new(sub_tree.to_h)
      end
    end

    def root
      @hash.keys.first
    end
    alias_method :root_name, :root

    def tail
      @hash.values.first
    end

    def sub_trees
      tail.keys.collect { |sub_root| HashTree.new(tail.slice(sub_root)) }
    end
  end
end

