require 'rubygems'  
require 'active_record'  
require 'yaml'  
 
dbconfig = YAML::load(File.open('database.yml'))  
ActiveRecord::Base.establish_connection(dbconfig)

class Users < ActiveRecord::Base; end

c = Users.create(:name => "madsdsdsdsdsdsdfffffffffffrco", :idade => 160)

t = Users.find :all

p t.inspect

class Roles < ActiveRecord::Base; end

x = Roles.create(:name => "3ddadadadada", :valor => 10)

p Roles.find :all

#p Roles.methods