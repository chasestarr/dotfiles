alias v='nvim'
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..='cd ..'
alias ~="cd ~"

# https://github.com/ogham/exa
alias l='exa -l --git'
alias ll='exa -al --git'

alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias ga='git add'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --stat'
alias gc='git commit'
alias ggo='git checkout -b'
alias gu='git reset HEAD~' # undo last commit

# Print each PATH entry on a separate line
alias echopath='echo -e ${PATH//:/\\n}'

alias png='ping 8.8.8.8'

export EDITOR='vim';
export LESS_TERMCAP_md="${yellow}";
export MANPAGER='less -X';

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": v $(fzf);'

function mkd() {
  mkdir -p "$@" && cd "$_";
}

function vv() {
  local filename=$(fzf)
  v $filename
}
