###
### local settings
###

# # Use forwarded SSH_AUTH_SOCK if available; otherwise, fall back to local 1Password agent.
if [ -z "${SSH_AUTH_SOCK:-}" ] && [ -S "$HOME/.1password/agent.sock" ]; then
    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi

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
export MISE_ENV="$(. /etc/os-release && echo "$ID")"
if [ -e /etc/dgx-release ]; then
  export MISE_ENV="${MISE_ENV:+$MISE_ENV,}dgx"
fi
eval "$(mise activate bash)"

# peco
alias g='pushd $(ghq root)/$(ghq list | peco)'
alias s='pushd $(find /mnt/sources/rhel*/sources/* -maxdepth 1 | peco)'
