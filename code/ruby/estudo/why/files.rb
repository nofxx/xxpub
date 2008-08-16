Dir.mkdir('/Users/nofxx/sandbox', 755)  unless Dir.new('/Users/nofxx/sandbox')

Dir.chdir('/Users/nofxx/sandbox')

                                    
file = File.new( 'dyngen.rb', 'w')