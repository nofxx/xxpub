#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-29.
#  Copyright (c) 2007. All rights reserved.

class Fixnum
  def prime?
    ('1' * self) !~ /^1?$|^(11+?)\1+$/
  end
end