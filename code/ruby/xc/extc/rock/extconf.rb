require 'mkmf'

abort "need stdio.h" unless have_header("stdio.h")

dir_config('rock')
create_makefile("rock")
