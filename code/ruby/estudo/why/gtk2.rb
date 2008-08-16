#!/usr/bin/env ruby
 
#Hello World in Ruby =D~~
 
require 'gtk2'
 
def callback(widget)
  puts "Hello again - #{widget.label}(#{widget}) was pressed."
end
 
window = Gtk::Window.new
window.title = "Hello Buttons"
window.border_width = 10
window.signal_connect('delete_event') do
  Gtk.main_quit
  false
end
 
box1 = Gtk::HBox.new(false, 0)
 
window.add(box1)
button1 = Gtk::Button.new("Button 1")
button1.signal_connect( "clicked" ) do |w|
  callback(w)
end
 
box1.pack_start(button1, true, true, 0)
 
button2 = Gtk::Button.new("Button 2")
 
button2.signal_connect("clicked") do |w|
  callback(w)
end
 
box1.pack_start(button2, true, true, 0)
 
# Você ainda pode chamar esses aqui ok noob =D
#   button1.show
#   button2.show
#   box1.show
#   window.show
window.show_all
Gtk.main