#
# BASHRC *NIX
#
#   nofxx - 2009
#
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
source /etc/profile

export PATH=/usr/local/cuda/bin:$PATH
#export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
export PAGER="most"
#
# PATHS
#
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/home/nofxx/scripts" # :/home/nofxx/.rvm/bin"
export EDITOR="emacs"
export HISTCONTROL=erasedups #rimuove i duplicati
export HISTFILESIZE=1000000000
export HISTSIZE=10000000        #size of history
shopt -s histappend
alias countcommand='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# -- start rip config -- #
RIPDIR="$HOME/.rip"
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$PATH:$RIPDIR/active/bin"
export RIPDIR RUBYLIB PATH
# -- end rip config -- #


#
# PS1
#
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
#PS1="\u@\h \w\$(parse_git_branch) $ "
#PS1='[\u@\h \W]\$ '
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\] '
#PS1="\n\[\033[0;34m\]:: \#\$\\[\e[m\]\[\033[34m\] : \u@\h @ \[\033[39m\]\w \[\033[38m\]: \$(/bin/ls -1 |
#/usr/bin/wc -l | /usr/bin/sed 's: ::g') : \[\033[38m\]\$(/bin/ls -lah |
#/usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\033[0m\]\n:: \[\033[0m\]"
#PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;36m\]\w $(parse_git_branch)\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \e[m\]'
#PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\] '
PS1='\[\e[0;32m\]\u::\h\[\e[m\] \[\e[1;37m\]\w\[\e[m\] $(parse_git_branch) \[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\] '

#
# ALIAS
#

#
# SYS
#
alias sys="vmstat 3"
alias h='history'
alias md5='md5sum'
alias x="startx"

#
# CD
alias c='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#
# SERVICE
alias rc='sudo /etc/rc.d/'
alias sservice='sudo /sbin/service'
alias inid='sudo /etc/init.d/'

#
# SSH
alias sshpkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat - >> ~/.ssh/authorized_keys2"'
alias sshx='ssh $1 -p 22223'

#
# LS
alias ls='ls --color=auto'
alias lss='ls -rhS'
alias lst='ls -rht'
alias ll="ls -lh"
alias la="ls -a"
alias l='ls -lah'
alias lla="ls -lah"
alias exit="clear; exit"
export LS_COLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"

#
# SED
alias dog='sed "/ *#/d; /^ *$/d"'

#
# ARCHLINUX
#
alias p="pacman"
alias y="yaourt"
alias atp="xargs sudo pacman -S <"
alias aty="xargs sudo yaourt -S <"
alias xpac="pacman -Sl | cut -d' ' -f2 | grep "
alias xup="sudo pacman -Syu"
alias ys="sudo yaourt -Syu --aur"

#
# AIRCRACK
#
alias ard="sudo airdriver-ng"
alias arm="sudo airmon-ng"
alias ardo="sudo airdriver-ng loaded"
alias ardu="sudo airdriver-ng unload"

#
# NETWORK
#
alias ix="sudo ifconfig"
alias iw="sudo iwconfig"

#
# DISK
#
alias duso="sudo du -xh --block-size=1024K | sort -nr | head -20"
alias disco="du -sch /*"
alias uso="du -h --max-depth=1"

function e { emacs "$@"& }

#
# TAR
#
alias pac='tar cvf'
alias pacz='tar czvf'
alias upac='tar xvf'
alias upacz='tar xvzf'

#
# GIT
#
alias gitouch='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
alias gx='git status'
alias gitup='git pull'
alias gitci='git commit -a -m'
alias gitco='git clone'
alias gita='git add'
alias gitb='git branch'
alias gitc='git checkout'
alias gitcm='gitc master'
alias gitcx='gitc fxx'
alias github="firefox \`git config -l | grep 'remote.origin.url' | sed -En \
  's/remote.origin.url=git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'\`"
alias svnclean='rm -rf `find . -name .svn`'

#
# RUBY
#
alias 9="rvm use 1.9.1"
alias 8="rvm use ree"
alias r3="rvm use 1.9.1@rails3"
alias r="ruby -v && gem env | grep gems"

function cdgem {
  cd /usr/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

export GEMDIR=`gem env gemdir`

gemdoc() {
    firefox $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc

#
# RAILS
#
alias ss='script/server &' # start up the beast
alias sc='script/console'  # obvious
alias sg='script/generate' # this on is free
alias aa='autospec &'
alias ca='cucumber -f pretty features&'
alias aaa='AUTOFEATURE=true autospec &'
alias sd='script/server mongrel --debugger'
alias sb='script/dbconsole'
alias mongs='mongrel_rails cluster::configure -e production -N 3 -c $(pwd) --user mongrel --group mongrel -p'
alias doom='rake db:drop && rake db:create && rake db:drop RAILS_ENV="test" && rake db:create RAILS_ENV="test" && rake db:migrate && rake db:seed && rake db:migrate RAILS_ENV="test"'
alias doomtest='rake db:drop RAILS_ENV="test" && rake db:create RAILS_ENV="test" && rake db:migrate RAILS_ENV="test"'
alias rr='touch tmp/restart.txt'

#
# FUNCTIONS
#
#myip - finds your current IP if your connected to the internet
myip ()
{
    lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g'
}

#clock - A bash clock that can run in your terminal window.
clock ()
{
    while true;do
        clear;
        echo ===========;
        date +%r;
        echo ===========;
        sleep 1;
    done
}

#netinfo - shows network information for your system
netinfo ()
{
    echo “————— Network Information —————”
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo
    echo “${myip}”
    echo ""
}

#shot - takes a screenshot of your current window
shot ()
{
    import -w root -quality 75 "$HOME/shot-$(date +%s).png"
}

translate ()
{
    TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "Portuguese (Brazil):" | sed 's/^[ \t]*//;s/[ \t]*$//'`
    if [[ ${#TRANSLATED} != 0 ]] ;then
        echo "\"${1}\" in ${TRANSLATED}"
    else
        echo "Sorry, I can not translate \"${1}\""
    fi
}

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


export MAGLEV_HOME=/home/nofxx/git/maglev
export PATH=$MAGLEV_HOME/bin:$PATH

if [[ -s /home/nofxx/.rvm/scripts/rvm ]] ; then source /home/nofxx/.rvm/scripts/rvm ; fi
