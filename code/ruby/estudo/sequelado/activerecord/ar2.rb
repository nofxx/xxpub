#!/usr/bin/env ruby
#
# 
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
:adapter => 'mysql',
:host => 'fireho.com',
:username => 'nofxx',
:password => 'rock',
:database => 'ar_ruby'
)

class Rubyist < ActiveRecord::Base
  
  
end

#Rubyist.create(:name => 'Luc Juggery', :city => "Nashville, Tenessee")   
#Rubyist.create(:name => 'Sunil Kelkar', :city => "Pune, India")   
#Rubyist.create(:name => 'Nofxxxxxxxxxx', :city => "Saixxxxxxxxxsco, USA")   
  
puts Rubyist.connected?
participant = Rubyist.find(:first)   
pa = Rubyist.find(5)
puts Rubyist.connected?
pa = Rubyist.find(6)
puts pa[:name]
puts %{#{participant.name} stays in #{participant.city}}   
  
# FIND
#Rubyist.find(:all) # returns an array of objects for all the rows fetched by SELECT * FROM people
#Rubyist.find(:all, :conditions => [ "category IN (?)", categories], :limit => 50)
#Rubyist.find(:all, :offset => 10, :limit => 10)
#Rubyist.find(:all, :include => [ :account, :friends ])
#Rubyist.find(:all, :group => "category")
  
#Rubyist.find(:first).destroy

