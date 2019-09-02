require 'test/unit'
require_relative '../grep'

class GrepTest < Test::Unit::TestCase
  def test_multiple_lines_found
    results = Grep.find('rose', fixture_path('fox_in_socks.txt'))

    expected_results = <<~TEXT
      81 Sue sews rose on Slow Joe Crow's clothes.
      87 Crow's rose grows some.
    TEXT
    assert_equal expected_results, results
  end

  def test_one_line_found
    results = Grep.find('hate', fixture_path('fox_in_socks.txt'))

    expected_results = <<~TEXT
      90 I hate this game, sir.
    TEXT
    assert_equal expected_results, results
  end

  def test_no_lines_found
    results = Grep.find('mountain', fixture_path('fox_in_socks.txt'))

    assert_equal '', results
  end

  private

  def fixture_path(filename)
    File.join(__dir__, 'fixtures', filename)
  end
end

