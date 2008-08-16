#!/usr/bin/env ruby
#
#  Created by nofxx on 2007-10-04.
#  Copyright (c) 2007. All rights reserved.


class SvnMain
  def cria(nome)
    msvn = system("svnadmin create /var/www/zem/svn/" + nome)
  end

  def apaga(nome)
    msvn = system("rm -rf /var/www/zem/svn/" + nome)
  end
end

svnm = SvnMain.new
todo = gets

foi = svnm.apaga(todo)


puts foi

