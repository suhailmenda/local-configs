autoload -U colors && colors
RPROMPT="%(?.%F{010}✔.%F{009}✗)%f"
NEWLINE=$'\n'

# Function to get the current Git branch
git_branch() {
    # Check if we're inside a git repo
    git rev-parse --is-inside-work-tree &>/dev/null
    if [ $? -eq 0 ]; then
        # Get the current branch name
        local branch=$(git symbolic-ref --short HEAD)
        echo "%F{014}($branch)%f"
    fi
}

# Set up chpwd hook to update the prompt when changing directories
function update_git_branch {
    #PS1="${NEWLINE}%F{009}┏━[%f%F{010}%n%f%F{011}@%f%F{014}%m%f%F{009}]–[%f%F{010}%~%f%F{009}$(git_branch)]${NEWLINE}┗━━━▶%f%F{011}%(!.#.$)%f "

VALID="${NEWLINE}%F{009}┏━[%f%F{010}sysadmin%f%F{011}@%f%F{014}hubio%f%F{009}]–[%f%F{010}%~%f%F{white}$(git_branch)%f%F{009}]${NEWLINE}┗━━━▶%f%F{011}%(!.#.$)%f "
# INVALID="${NEWLINE}%F{009}┏━[✗%f%F{white}]–[%F{010}%n%f%F{011}@%f%F{014}%m%f %F{009}]–[%f%F{010}%~%f%F{009}$(git_branch)]${NEWLINE}┗━━━▶%f%F{011}%(!.#.$)%f "
PS1=$VALID
}

# Trigger the update_git_branch function whenever the directory changes
autoload -Uz add-zsh-hook
add-zsh-hook chpwd update_git_branch
add-zsh-hook precmd update_git_branch

# Set the prompt for the first time
update_git_branch

export PS1
export CLICOLOR=1
export LSCOLORS=gxexcxdxbxegedabagacad

if [ -z "$TMUX" ]; then
    tmux attach -t TMUX || tmux new -s TMUX
fi
alias sso="aws --profile admin-main sso login"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
alias tauth="tsh login --proxy tele.hubio.team --user suhail.menda@hubio.com"
alias tsign="tctl auth sign --user=suhail.menda@hubio.com --ttl=30m  --out ~/.aws/terraform-identity --proxy=tele.hubio.team"
eval "$(zoxide init zsh)"

# Created by `pipx` on 2025-09-21 16:56:22
export PATH="$PATH:/Users/suhailyakubmenda/.local/bin"
bindkey -v
stty erase '^H'           # tell terminal backspace = ^H
bindkey '^H' backward-delete-char
bindkey '^?' backward-delete-char
