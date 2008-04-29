#  
# 
#      BASHRC *UNIX (98% da mafia)
# 
# # # 
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# PATHS
# #
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/home/nofxx/scripts"
export EDITOR="vim"

# PS1
# #
#PS1=’[\u@\h \W]\$ ‘
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\] '
#PS1="\n\[\033[0;34m\]:: \#\$\\[\e[m\]\[\033[34m\] : \u@\h @ \[\033[39m\]\w \[\033[38m\]: \$(/bin/ls -1 |
#/usr/bin/wc -l | /usr/bin/sed 's: ::g') : \[\033[38m\]\$(/bin/ls -lah |
#/usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\033[0m\]\n:: \[\033[0m\]"
PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \e[m\]'
#PS1='\[\e[0;32m\]\h\[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\] '

# # ALIAS
# # # 
#
# SYS
# #
alias sys="vmstat 3"
alias h='history'
alias md5='md5sum'
alias x="startx"
alias xi='sudo vi'

# CD
alias c='cd ..'
alias ..='cd ..' 
alias ...='cd ../..' 
alias ....='cd ../../..'
alias .....='cd ../../../..'

# SERVICE
# #
alias rc='sudo /etc/rc.d/'
alias sservice='sudo /sbin/service'
alias inid='sudo /etc/init.d/'

# SSH
# #
alias sshpkey='cat ~/.ssh/id_rsa.pub | ssh $1 "cat - >> ~/.ssh/authorized_keys2"'
alias sshx='ssh $1 -p 22223'

# LS
# #
alias ls='ls --color=auto'
alias lss='ls -rhS'
alias lst='ls -rht'
alias ll="ls -lh"
alias la="ls -a"
alias l='ls -lah'
alias lla="ls -lah"
alias exit="clear; exit"
export LS_COLORS="di=31;1:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1"

# SED
# #
alias dog='sed "/ *#/d; /^ *$/d"'

# ARCHLINUX
# #
alias p="pacman"
alias y="yaourt"
alias atp="xargs sudo pacman -S <"
alias aty="xargs sudo yaourt -S <"
alias xpac="pacman -Sl | cut -d' ' -f2 | grep "
alias xup="sudo pacman -Syu"
alias ys="sudo yaourt -Syu --aur"

# AIRCRACK
# #
alias ard="sudo airdriver-ng"
alias arm="sudo airmon-ng"
alias ardo="sudo airdriver-ng loaded"
alias ardu="sudo airdriver-ng unload"

# NETWORK
# #
alias ix="sudo ifconfig"
alias iw="sudo iwconfig"
   
# DISK
# #
alias duso="sudo du -xh --block-size=1024K | sort -nr | head -20"
alias disco="du -sch /*"
alias uso="du -h --max-depth=1"

# TAR
# #
alias pac='tar cvf'
alias pacz='tar czvf'
alias upac='tar xvf'
alias upacz='tar xvzf'

# GIT
# #
alias gitouch='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
alias gitup='git pull'
alias gitci='git commit -a -m'
alias gitco='git clone'
alias gita='git add'
alias gitb='git branch'
alias gitc='git checkout'

# SVN
# # 
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
# #
alias irb='irb --readline -r irb/completion -rubygems' 
function cdgem {
  cd /usr/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}
   
# RAILS
# # 
alias ss='script/server &' # start up the beast
alias sc='script/console' # obvious
alias sw='script/server webrick'
alias sg='script/generate'
alias a='autotest -rails' # makes autotesting even quicker

alias mongs='mongrel_rails cluster::configure -e production -N 3 -c $(pwd) --user mongrel --group mongrel -p'


# # FUNCTIONS
# # # 
# 

#myip - finds your current IP if your connected to the internet
myip ()
{
	lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk ‘{ print $4 }’ | sed ‘/^$/d; s/^[ ]*//g; s/[ ]*$//g’
}

#clock - A bash clock that can run in your terminal window.
clock ()
{
	while true;do
		clear;
		echo “===========”;
		date +”%r”;
		echo “===========”;
		sleep 1;
	done
}

#netinfo - shows network information for your system
netinfo ()
{
	echo “————— Network Information —————”
	/sbin/ifconfig | awk /’inet addr/ {print $2}’
	/sbin/ifconfig | awk /’Bcast/ {print $3}’
	# /sbin/ifconfig | awk /’inet addr/ {print $4}’
	/sbin/ifconfig | awk /’HWaddr/ {print $4,$5}’
#	myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed ‘/^$/d; s/^[ ]*//g; s/[ ]*$//g’ `
	echo
#	echo “${myip}”
	echo “—————————————————”
}

#shot - takes a screenshot of your current window
shot ()
{
	import -w root -quality 75 “$HOME/shot-$(date +%s).png”
}

#translate ()
# {
#	TRANSLATED=`lynx -dump “http://dictionary.reference.com/browse/${1}” | grep -i -m 1 -w “Portuguese (Brazil):” | sed ’s/^[ \t]*//;s/[ \t]*$//’`
#	if [[ ${#TRANSLATED} != 0 ]] ;then
#		echo “\”${1}\” in ${TRANSLATED}”
#	else
#		echo “Sorry, I can not translate \”${1}\” to Portuguese (Brazil)”
#	fi
#}

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
