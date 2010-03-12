#!/usr/bin/env ruby
require "rubygems"
require "mq"
require "json"

# def has_vhost?(name)
#   !!(`rabbitmqctl list_vhosts` =~ /^#{name}$/)
# end

# def create_vhost(name)
#   return if has_vhost?(name)
#   puts "Creating vhost #{name}"
#   `rabbitmqctl add_vhost #{name}`
# end

# create_vhost(:roll)




AMQP.start(:host => "localhost") do #, :vhost => "roll") do

  def log *args
    p [ Time.now, *args ]
  end

   AMQP.logging = true

  amq = MQ.new
  EM.add_periodic_timer(1){
    log :sending, 'ping'
    amq.queue('one').publish([1,2].join(","))
  }

  amq = MQ.new
  amq.queue('one').subscribe{ |msg|
    puts "received #{ msg}"

     log 'one', :received, msg, :sending, 'pong'
     amq.queue('two').publish('pong')
   }

   amq = MQ.new
   amq.queue('two').subscribe{ |msg|
     log 'two', :received, msg
   }


end

