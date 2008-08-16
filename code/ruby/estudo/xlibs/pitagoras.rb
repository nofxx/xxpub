#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-14.
#  Copyright (c) 2007. All rights reserved.
#  ==Lib Pitagoras
#  a = √(b² + c²)
#
# # # # #

#Simple implementation of Pitagoras
module Math
  #Recebe os lados
  #Executa a equacao e retorna
  def self.pitagoras(a,b)
  @a = a.to_f
  @b = b.to_f
  return sqrt(@a**2 + @b**2)
  end
end

pit = Math.pitagoras(36,4)
#pit = Math.sqrt(10)
puts pit