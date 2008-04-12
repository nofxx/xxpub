##########################################################################
#
#
#                                        BASH PROFILE - OS X
#
#


##########
#   PATH
#
#
export PATH="$PATH:/opt/local/bin:/opt/local/sbin"

###########
#   PROMPT 
#
#

PS1="\n\[\033[0;34m\]:: \#\$\\[\e[m\]\[\033[34m\] : \u@\h @ \[\033[39m\]\w \[\033[38m\]: \$(/bin/ls -1 |
/usr/bin/wc -l | /usr/bin/sed 's: ::g') : \[\033[38m\]\$(/bin/ls -lah |
/usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\033[0m\]\n:: \[\033[0m\]"

PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \e[m\]'
 
###########
#   ALIAS 
#
#

# SSH
alias sshpkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat - >> ~/.ssh/authorized_keys2"'
alias sshx='ssh $1 -p 22223'

#LS
alias l='ls -lah'
#alias ls='ls --color=auto'
alias ls='ls -FaG'  #mas isso eh um bichona doutor...
alias ll='ls -lh'
alias la='ls -lha'
export LS_OPTIONS='--color=auto'
#export LSCOLORS="DxGxcxdxCxegedabagacad"
export LSCOLORS="CxfxcxdxbxCgCdabagacad"
#export LSCOLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"
#eval `dircolors`


alias h='history' 

# CD
alias c='cd ..'
alias ..='cd ..' 
alias ...='cd ../..' 
alias ....='cd ../../../'

alias ebash='mate ~/.bash_profile &'
alias rbash='source ~/.bash_profile' 

# DISK
alias df='df -kh'
alias du='du -kc'

# MD5
alias md5sum='openssl dgst -md5'
alias md5='md5sum'
alias xi='sudo vi'

# PORT
alias p='sudo port search'
alias y='sudo port install'
alias ys='sudo port selfupdate'

# TAR
alias pac='tar cvf'
alias pacz='tar czvf'
alias upac='tar xvf'
alias upacz='tar xvzf'
 
# TEXTMATE 
alias e='mate . &' # open current dir
alias et='mate README app/ config/ db/ lib/ public/ test/ vendor/plugins &' # open current dir assuming rails

# SVN 
export SVN_EDITOR="vi +1 --tempfile"
alias sup='svn up' 
alias sst='svn st' # local file changes
alias sstu='svn st -u' # remote repository changes
alias si='svn commit' # commit
# removes all .svn folders from directory recursively
alias svnclear='find . -name .svn -print0 | xargs -0 rm -rf' 
# adds all unadded files
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add' 
alias saa='svnaddall'
 
# RUBY 
alias irb='irb --readline -r irb/completion -rubygems' 
function cdgem {
  cd /usr/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}
 
# RAILS 
alias ss='mongrel_rails start' # start up the beast
alias sc='script/console' # obvious
alias a='autotest -rails' # makes autotesting even quicker
# 
# see http://railstips.org/2007/5/31/even-edgier-than-edge-rails
function edgie() { 
  ruby ~/rails/trunk/railties/bin/rails $1 && cd $1 && ln -s ~/rails/trunk vendor/rails && mate . 
}
 
 
# Make bash check it's window size after a process completes
shopt -s checkwinsize
