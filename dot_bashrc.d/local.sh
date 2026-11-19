###
### local settings
###

if ! [[ "$PATH" =~ "$HOME/devel/bin" ]]; then
    PATH="$PATH:$HOME/devel/bin"
fi
export PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

shopt -s histappend
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=99999
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

if [[ "$TERM" = "xterm-ghostty" ]]; then
	export TERM=xterm-256color
fi

export EDITOR=vim
export GOPATH=${HOME}/devel

alias otpcopy="otp.py | xclip -selection c"
alias otpecho="otp.py ; echo"
alias open=xdg-open
alias vpnup="sudo nmcli c up '1 - Red Hat Global VPN' --ask"

alias rmbak='rm *~ \#*'

# mise
eval "$(mise activate bash)"

# peco
alias g='pushd $(ghq root)/$(ghq list | peco)'
alias s='pushd $(find /mnt/sources/rhel*/sources/* -maxdepth 1 | peco)'
