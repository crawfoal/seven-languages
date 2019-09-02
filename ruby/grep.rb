class Grep
  attr_reader :filename

  def self.find(phrase, filename)
    new(filename).find(phrase)
  end

  def initialize(filename)
    @filename = filename
  end

  def find(phrase)
    File.new(filename)
      .each_line
      .each_with_index
      .select { |line, lineno| line.match?(/#{phrase}/) }
      .reduce('') { |result, (line, lineno)| result << "#{lineno} #{line}"}
  end
end

