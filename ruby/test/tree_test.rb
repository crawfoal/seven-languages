require 'test/unit'
require_relative '../tree'

class TreeTest < Test::Unit::TestCase
  def setup
    @tree = Tree.new("Ruby", [Tree.new("Reia"), Tree.new("MacRuby")])
  end

  def test_visit
    @tree.visit { |node| assert_equal "Ruby", node.node_name }
  end

  def test_visit_all
    visits = %w(Ruby Reia MacRuby)
    @tree.visit_all { |node| assert_equal visits.shift, node.node_name }
  end

  def test_shortcut_initialization
    input = {
      'grandpa' => {
        'dad' => {
          'child 1' => {},
          'child 2' => {}
        },
        'uncle' => {
          'child 3' => {},
          'child 4' => {}
        }
      }
    }

    tree = Tree.new(input)

    visits = ['grandpa', 'dad', 'child 1', 'child 2', 'uncle', 'child 3',
              'child 4']
    tree.visit_all { |node| assert_equal visits.shift, node.node_name }
  end
end

