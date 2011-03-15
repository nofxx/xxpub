#
#
#  ZSH
#
##################################################################
#
# Sources:
# https://github.com/garybernhardt/dotfiles/tree/master/.zsh/func
# http://dzen.geekmode.org/wiki/wiki.cgi/-main/ZshConfiguration
# https://github.com/ryanb/dotfiles/blob/master/zshrc
#
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath
autoload -Uz compinit
compinit

#
#  Completion
#
# allow approximate
#zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle :compinstall filename '/home/nofxx/.zshrc'

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=10000000

#
#  Keys
#
bindkey '^BKP' backward-delete-word
bindkey '^D' exit
bindkey -e
bindkey '^[^[[D' backward-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

bindkey '^[^N' newtab
bindkey '^?' backward-delete-char

#
#  Options
#
eval `dircolors -b`
# Don't expand files matching:
fignore=(.o .c~ .old .pro)

# cd opt | autopushd pushdminus pushdsilent pushdtohome
setopt autocd # foo -> cd foo
setopt cdablevars
setopt pushd_ignore_dups
# job control | auto_resume notify check_jobs
setopt nohup
setopt ignoreeof
setopt long_list_jobs
setopt interactivecomments
# history
setopt nobanghist
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_ignore_dups
# dunno
setopt noclobber
setopt promptsubst
setopt sh_word_split

#
#  Prompt
#
# Load the prompt theme system
autoload -U promptinit
promptinit
# Use the wunjo prompt theme
# prompt wunjo
prompt grb

#
#  Alias
#
alias mem="free -m"
alias sys="vmstat 3"
alias wtf="dstat -ycdgmnplr"
alias h='history'
alias md5='md5sum'
alias x="startx"
alias _='sudo'

# Dir Stack
alias pu='pushd'
alias po='popd'
alias d='dirs -v'

# CD
alias c='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# SERVICE
alias rc='sudo /etc/rc.d/'
alias sservice='sudo /sbin/service'
alias inid='sudo /etc/init.d/'

# SSH
alias sshpkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat - >> ~/.ssh/authorized_keys2"'
alias sshx='ssh $1 -p 22223'

# LS
alias ls='ls --color=auto'
alias lss='ls -rhS'
alias lst='ls -rht'
alias ll="ls -lh"
alias la="ls -a"
alias l='ls -lah'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias f='find |grep'
alias lla="ls -lah"
alias exit="clear; exit"

# SED
alias dog='sed "/ *#/d; /^ *$/d"'

# ARCHLINUX
alias p="pacman"
alias y="yaourt"
alias atp="xargs sudo pacman -S <"
alias aty="xargs sudo yaourt -S <"
alias xpac="pacman -Sl | cut -d' ' -f2 | grep "
alias xup="sudo pacman -Syu"
alias ys="sudo yaourt -Syu --aur"

# AIRCRACK
alias ard="sudo airdriver-ng"
alias arm="sudo airmon-ng"
alias ardo="sudo airdriver-ng loaded"
alias ardu="sudo airdriver-ng unload"

# NETWORK
alias ix="sudo ifconfig"
alias iw="sudo iwconfig"

# DISK
alias duso="sudo du -xh --block-size=1024K | sort -nr | head -20"
alias disco="du -sch /*"
alias uso="du -h --max-depth=1"

# TAR
alias pac='tar cvf'
alias pacz='tar czvf'
alias upac='tar xvf'
alias upacz='tar xvzf'

# GIT
alias gitouch='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
alias gx='git status'
alias gp='git push'
alias gu='git up'
alias gitci='git commit -a -m'
alias gitco='git clone'
alias gita='git add'
alias gitb='git branch'
alias gitrbc='git rebase --continue'
alias gitc='git checkout'
alias gitcm='gitc master'
alias gitcx='gitc fxx'
alias github="firefox \`git config -l | grep 'remote.origin.url' | sed -En \
  's/remote.origin.url=git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'\`"
alias svnclean='rm -rf `find . -name .svn`'

# RUBY
alias 9="rvm use 1.9.2"
alias 8="rvm use ree"
alias r3="rvm use 1.9.1@rails3"
alias r="ruby -v && gem env | grep gems"

# RAILS
alias r=rails
alias rs='rspec spec'
alias ss='rails s &' # start up the beast
alias sc='rails c'  # obvious
alias aa='autospec &'
alias aaa='AUTOFEATURE=true autospec &'
alias doom='rake db:drop && rake db:create && rake db:drop RAILS_ENV="test" && rake db:create RAILS_ENV="test" && rake db:migrate && rake db:seed && rake db:migrate RAILS_ENV="test"'
alias doomtest='rake db:drop RAILS_ENV="test" && rake db:create RAILS_ENV="test" && rake db:migrate RAILS_ENV="test"'
alias rr='touch tmp/restart.txt'

alias countcommand='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g L='less'
alias -g M='more'
alias -g H='head'
alias -g T='tail'

function e { emacs "$@"& }

function cdgem {
  cd /usr/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

#
#  Export Vars
#
export EDITOR="emacs"
export BROWSER=links
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"
export LS_COLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export NPM_HOME=~/.node
export MAGLEV_HOME=~/.maglev

export PATH="$NPM_HOME/bin:$MAGLEV_HOME/bin:$PATH:/usr/local/bin:/usr/local/sbin:/home/nofxx/scripts:/usr/local/cuda/bin" # :/home/nofxx/.rvm/bin"

# # PS1 and PS2
# export PS1="$(print '%{\e[1;34m%}%n%{\e[0m%}'):$(print '%{\e[0;34m%}%~%{\e[0m%}')$ "
# export PS2="$(print '%{\e[0;34m%}>%{\e[0m%}')"
