#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-27.
#  Copyright (c) 2007. All rights reserved.
#
#
#
# r   ->  read-only
# r+  ->  read-write <-pointer start of line
# w   ->  write-only - apaga tudo ou cria
# w+  ->  read-write - mas new cria ou apaga
# a   ->  write append pointer end ->
# a+  ->  read-write append pointer end ->
# b   ->  binary only for WIN$HIT

Path = Dir::pwd + File::SEPARATOR
xfile = Path + File.join('var','file.txt')
cxfile = Path + File.join('var','csv.txt')
xxfile = File.join('..','assets','m.xml')
log = File.join('var','logdoido.log')
logg = File.join('var','logmtodoido.log')

eo = <<EOF
Hora Certa 
Nofxx Horas Certas
A hora certa eh:
EOF
puts File.mtime(log)-Time.now
def to_k(i)
  i/1000
end
def pt(x='')
  print "\n\n---------------- #{x}\n\n\n"
end
def tt
  print "\n---\n"
end

# open => abre fecha - code block.. bom pra coisa rapida
# new => retorna objeto - referencia... bom no scope do scope

#File.open(xfile).each{ |l| puts l }
#File.new(xfile, 'r').each{ |l| puts l }

f = File.new(xfile, 'r')
#puts f.gets
f.close

pt "size"

puts "Arquivo tem #{File.size(xfile)} B"
puts "Arquivo tem #{File.size(cxfile)} B"
puts "Arquivo tem #{to_k(File.size(xxfile))} kB"
puts "Arquivo tem #{to_k(File.size(log))} kB"

class Mfile
  attr_reader :handle
  def initialize(filename)
    if File.exist?(filename)
      @handle = File.new(filename, 'r')
    else
      return false
    end
  end
  
  def finish
    @handle.close
  end
end

t = Mfile.new(xfile)
puts t.handle.gets # => que nem um pop() MODIFICA
puts t.handle.gets
puts
t.handle.each_line{ |l| puts l }
pt "object file"

#File.open(xfile).each_byte{ |b| print "-> #{b} <-" }
t.handle.each_byte{ |b| puts b } # => non funf
#puts t.f.size
t.finish


# File.open(cxfile).each(','){ |l| puts l }
pt "cx"

cx = Mfile.new(cxfile)
x =  cx.handle.read(4) # => handle -4 ! ! !
puts cx.handle.each(','){ |l| puts l } # => modifica
puts cx.handle.each_byte{ |b| puts b } # => dae nao sobra nda

pt "cx"

File.open(cxfile) do |f|
  2.times { puts f.getc }
end

pt "readlines"

puts File.open(cxfile).readlines.join("--")

pt "shortcuts" # => bom pr arquivos pequenos

data = File.read(cxfile)
arradata = File.readlines(cxfile)

p data, arradata
puts data

pt 'posição'

cxx = Mfile.new(cxfile)
puts cxx.handle.pos
puts cxx.handle.gets
puts cxx.handle.pos
cxx.handle.pos = 0
puts cxx.handle.pos
puts cxx.handle.gets
puts cxx.handle.pos

tt

f = File.open(cxfile)
f.pos = 11
puts f.gets
puts f.pos


pt "writing"


class Mkfile
  attr_accessor :file
  def initialize(ref)
    if File.exist?(ref)
      File.open(ref, 'a') do |f|
        f.puts "Passei aqui:" + Time.now.to_s
      end
    else
      File.open(ref, 'w') do |f| # => destroi
        f.puts "X HEADER since: " + Time.now.to_s
      end
    end
  end
end


f = File.open(log, 'r+')
f.putc "X" # => XLINHA 1 put CHAR
f.write "X.X"
f.puts "LINHA 1"
puts f.gets
f.puts "LINHA 2"
puts f.gets

f.putc "X" # => coloca especifico
f.write "1.2.3.4" # => toda hora ..overwrites

f.close

pt "renaming"

# File.rename

pt "hora"

t = File.mtime(log)
puts t.hour

novis = Mkfile.new('var/novo')


f = File.new(log, 'r')
catch(:end) do
  loop do
    throw :end if f.eof?
    fx = f.gets
  end
end
f.close

pt "Dirs"

Dir.chdir('pasta/outrapasta')
puts Dir::pwd
puts Dir.pwd

tudo = Dir.entries(Path) # => ARRAY
p tudo


Dir.foreach(Path) do |e|
  begin
    puts "Arquivo: #{e.inspect} Class: #{e.class.to_s} "
    
  rescue Errno::ENOENT
    next
  end
end

puts Dir[Path+"*"]

Dir.mkdir('novo', 0755) # => 0777 0775... octal soh unix
Dir.delete('novo') # => Dir.unlink.. Dir.rmdir

require 'tmpdir'
puts Dir.tmpdir

tempfilename = File.join(Dir.tmpdir, "xx.dat")
tempfile = File.new(tempfilename, 'w')
tempfile.puts "Temporary" + Time.now.to_s
tempfile.close
File.delete(tempfilename)

require 'tempfile'
f = Tempfile.new('xx')
f.puts "oi temp"
puts f.path
f.close

require 'csv'
CSV.open(cxfile, 'r') do |p|
  p p
  puts p[2]
end

ppl = CSV.read(cxfile)
procuris = ppl.find{ |p| p[0] =~ /Marc/ }
p procuris


