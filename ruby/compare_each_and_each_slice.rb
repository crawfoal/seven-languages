a = (1..16).collect { rand(100) }

s = []
a.each do |n|
  s << n
  p(s) && s = [] if s.length == 4
end

a.each_slice(4) { |s| p s }

