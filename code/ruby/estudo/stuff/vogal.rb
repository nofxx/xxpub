#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-21.
#  Copyright (c) 2007. All rights reserved.

require 'string_ext' # => uma vez
# load 'string_ext' # => nao funciona.. huahauhauha

$:.push '/Volumes/xx'
$:.each { |d| puts d } # => bonito mostrador de $PATH $: eh um array



puts "This is a test".vogal.join('-')

