### Taken from Barry Clark's bashstrap (https://github.com/barryclark/bashstrap.git)

### Aliases

# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
alias s='open -a "Sublime Text"'
alias e='emacs -nw'
alias rm='rm -i'
alias cfalogin='ssh -Y bcook@mars.cfa.harvard.edu'
alias scptunnel='ssh -N -f -L 2200:cfa0.cfa.harvard.edu:22 bcook@login.cfa.harvard.edu'
alias acrobat='/Applications/Adobe\ Acrobat\ XI\ Pro/Adobe\ Acrobat\ Pro.app/Contents/MacOS/AdobeAcrobat'
alias openauth='~/bcook-openauth/bcook-openauth.sh &'
alias glog='git log --oneline'
alias help_tunnel="cat ~/tunneling_help.txt"
function odyssey() {
    openauth
    ssh -Y ody
}
function notebook() {
    jupyter notebook $1
}

# added by Anaconda 2.0.1 installer
export OLDPATH="$PATH"
export OLDPYTHONPATH="$PYTHONPATH"

# added by Miniconda2 4.3.21 installer
#export PATH="/Users/bcook/miniconda2/bin:/Users/bcook/scripts:/opt/local/bin:/opt/local/sbin:$PATH"
#export PYTHONPATH="/Users/bcook/miniconda2/bin:/Users/bcook/miniconda2/lib:/Users/bcook/miniconda2/lib/python2.7/site-packages:/Users/bcook/scripts:/Users/bcook/pCMDs/pixcmd:/Users/bcook/dynesty:$PYTHONPATH"

export PATH="/Users/bcook/anaconda/bin:/Users/bcook/scripts:/opt/local/bin:/opt/local/sbin:$PATH"
export PYTHONPATH="/Users/bcook/anaconda/bin:/Users/bcook/anaconda/lib:/Users/bcook/anaconda/lib/python2.7/site-packages:/Users/bcook/scripts:/Users/bcook/pCMDs/pixcmd:/Users/bcook/pCMDs/pcmdpy/:/Users/bcook/dynesty:$PYTHONPATH:."

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -laFh ${colorflag}" # all files, in long format
alias lt="ls -latFh ${colorflag}" # all files, in long format, sorted by date
alias lsd='ls -lFh ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts to my Code folder in my home directory
alias code="cd ~/Code"
alias sites="cd ~/Code/sites"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git
# You must install Git first - ""
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'


### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
#    tput sgr0 >>>> Not sure what this does, but if uncommented makes scp fail
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
	BLACK=$(tput setaf 190)
	MAGENTA=$(tput setaf 9)
	ORANGE=$(tput setaf 172)
	GREEN=$(tput setaf 184)
	PURPLE=$(tput setaf 141)
	WHITE=$(tput setaf 244)
	else
	BLACK=$(tput setaf 190)
	MAGENTA=$(tput setaf 5)
	ORANGE=$(tput setaf 4)
	GREEN=$(tput setaf 2)
	PURPLE=$(tput setaf 1)
	WHITE=$(tput setaf 7)
	fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    BLACK="\033[01;30m"
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
    #echo ""
}
function parse_git_branch() {
    repo=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
    branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/")
    [[ $repo ]] && echo "$repo/$branch"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡  "

export PS1="\[${BOLD}${MAGENTA}\]\u\[$WHITE\] @ \[$ORANGE\]MacBook \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

##
# Your previous /Users/bcook/.bash_profile file was backed up as /Users/bcook/.bash_profile.macports-saved_2015-04-02_at_15:39:49
##
