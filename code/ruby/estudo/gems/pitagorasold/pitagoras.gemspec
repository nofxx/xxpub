require 'rubygems' 
spec = Gem::Specification.new do |s| 
  s.name = 'pitagoras' 
  s.version = '0.0.1' 
  s.summary = "Pitagoras pra todos!" 
  s.files = Dir.glob("**/**/**") 
  s.test_files = Dir.glob("test/*_test.rb") 
  s.autorequire = 'pitagoras' 
  s.author = "Nofxx" 
  s.email = "x@nofxx.com" 
  s.has_rdoc = false 
  s.required_ruby_version = '>= 1.8.4' 
end