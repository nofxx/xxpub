##########################################################################
#
#
#                                        BASH PROFILE - OS X
#
#

# UNIX COMMON
# #
source ~/.bashrc


# PATH
# #
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:/opt/local/lib/postgresql83/bin"

#LS
# #
#alias ls='ls --color=auto'
alias ls='ls -FaG'  #mas isso eh um bichona doutor...
alias ll='ls -lh'
alias la='ls -lha'
export LS_OPTIONS='--color=auto'
#export LSCOLORS="DxGxcxdxCxegedabagacad"
export LSCOLORS="CxfxcxdxbxCgCdabagacad"
#export LSCOLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"
#eval `dircolors`

# BASHPROFILE
# #
alias ebash='mate ~/.bash_profile &'
alias rbash='source ~/.bash_profile' 

# MD5
# #
alias md5sum='openssl dgst -md5'
alias md5='md5sum'

# PORT
# #
alias p='sudo port search'
alias y='sudo port install'
alias ys='sudo port selfupdate'
 
# TEXTMATE 
# #
alias e='mate . &' # open current dir
alias et='mate CHANGELOG README app/* config/ db/ lib/ spec/ stories/ public/ test/ vendor/ &' # open current dir assuming rails
alias xman='man -cP mate $1'
#set MANPAGER='/usr/bin/mate'

# Make bash check it's window size after a process completes
shopt -s checkwinsize
