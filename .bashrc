# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# append to the history file, don't overwrite it
#shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto -n'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

alias ll='ls -l'
alias gcc='gcc -Wall'
alias g++='g++ -Wall'
alias ctags='ctags -R --c++-kinds=+dx --fields=+aiS --extra=+q --if0=no'
alias ed='emacs'
alias scm='rlwrap mit-scheme'
alias py='python'
alias tree='tree -C --dirsfirst'

export HISTCONTROL=eraseredups:ignoredups:ignorespace;
export EDITOR='vim'
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

export COLOR_LIGHT_BLACK_BEGIN="\e[1;30m"
export COLOR_LIGHT_RED_BEGIN="\e[1;31m"
export COLOR_LIGHT_GREEN_BEGIN="\e[1;32m"
export COLOR_LIGHT_YELLOW_BEGIN="\e[1;33m"
export COLOR_LIGHT_BLUE_BEGIN="\e[1;34m"
export COLOR_LIGHT_PURPLE_BEGIN="\e[1;35m"
export COLOR_LIGHT_CYAN_BEGIN="\e[1;36m"
export COLOR_LIGHT_WHITE_BEGIN="\e[1;37m"
export COLOR_DARK_BLACK_BEGIN="\e[0;30m"
export COLOR_DARK_RED_BEGIN="\e[0;31m"
export COLOR_DARK_GREEN_BEGIN="\e[0;32m"
export COLOR_DARK_YELLOW_BEGIN="\e[0;33m"
export COLOR_DARK_BLUE_BEGIN="\e[0;34m"
export COLOR_DARK_PURPLE_BEGIN="\e[0;35m"
export COLOR_DARK_CYAN_BEGIN="\e[0;36m"
export COLOR_DARK_WHITE_BEGIN="\e[0;37m"
export COLOR_END="\e[0m"

function get_git_branch()
{
    # '\xe2\x86\x92' => '→'
    git branch --no-color 2>/dev/null | sed -n 's/^\* \(.*\)/ \xe2\x86\x92 \1/'p
}
export -f get_git_branch

# add a '$' in the front of 'PS1' to display unicode characters
export PS1=$"\[$COLOR_LIGHT_GREEN_BEGIN\]\u\[$COLOR_END\]@\[$COLOR_LIGHT_RED_BEGIN\]\h\[$COLOR_END\]:\[$COLOR_LIGHT_BLUE_BEGIN\]\W\[$COLOR_END\]\[$COLOR_LIGHT_CYAN_BEGIN\]\$(get_git_branch)\[$COLOR_END\]\$ "

export LESS_TERMCAP_mb=$'\e[05;34m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;34m'       # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[44;33m'       # begin standout-mode
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;33m'       # begin underline

alias byr='LANG=en_US.GBK; expect -c "spawn telnet bbs.byr.cn;interact timeout 300 {send \"\\014\"}"'
alias byr6='LANG=en_US.GBK; expect -c "spawn telnet bbs6.byr.cn;interact timeout 300 {send \"\\014\"}"'
alias smth='LANG=en_US.GBK; expect -c "spawn telnet bbs.newsmth.net;interact timeout 300 {send \"\\014\"}"'

stty -ixoff -ixon 2>/dev/null # disable ctrl-s
#setxkbmap -option ctrl:swapcaps # controled by gnome

# ------------ work related ----------------

umask 0022

if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git
fi

user=`who am i | awk '{print $1}'`
if [ -x '/opt/meituan/vim/bin/vim' ]; then
    alias vi="/opt/meituan/vim/bin/vim -u /home/$user/.vimrc"
    alias vim="/opt/meituan/vim/bin/vim -u /home/$user/.vimrc"
    alias vimdiff="/opt/meituan/vim/bin/vimdiff -u /home/$user/.vimrc"
fi

alias q='telnet data-search11 11233'

export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=.:$HOME/bin:$LD_LIBRARY_PATH

# ----- #

for ((i = 1; i <= 21; ++i)); do
    name=`printf "%02d" $i`
    alias $name="ssh data-search"$name
done

for ((i = 1; i <= 30; ++i)); do
    name=`printf "%02d" $i`
    alias q$name="ssh dataapp-search-qs"$name
done

for ((i = 1; i <= 10; ++i)); do
    name=`printf "%02d" $i`
    alias i$name="ssh dataapp-index"$name
done

for ((i = 1; i <= 20; ++i)); do
    name=`printf "%02d" $i`
    alias b$name="ssh dataapp-search-bs"$name
done

for ((i = 1; i <= 24; ++i)); do
    name=`printf "%02d" $i`
    alias xb$name="ssh dx-dataapp-search-bs"$name
done

for ((i = 1; i <= 10; ++i)); do
    name=`printf "%02d" $i`
    alias t$name="ssh dataapp-test"$name
done
