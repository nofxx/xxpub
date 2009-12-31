require "rubygems"
require "relaxdb"

RelaxDB.configure :host => "localhost", :port => 5984, :design_doc => "app"
RelaxDB.use_db "jah_scratch"

RelaxDB.enable_view_creation # creates views when class definition is executed

class Server < RelaxDB::Document
  property :name
  property :addr
  property :user
  property :ping


 property :state, :default => "awaiting_response",
    :validator => lambda { |s| %w(accepted rejected awaiting_response).include? s }




end


s = Server.new(:name => "S1", :addr => "10.1.1.1").save!

puts Server.all
