export PATH="/home/ash/.nvm/versions/node/v22.16.0/bin:$PATH"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx

export ANDROID_HOME=$HOME/Android/Sdk  # Note: 'Sdk' with capital 'S', not 'sdk'
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

# Debug log with absolute path
echo "Debug: Loading zshrc at $(date)" >> /home/ash/zsh_debug.log
eval "$(starship init zsh)"


# Completion settings
zstyle :compinstall filename '/home/ash/.config/zsh/zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# Aliases
alias rm='trash'
alias remove='\rm -rf'
alias lg='lazygit'
alias histsort='$HOME/.config/zsh/histsort'
alias hon="~/.config/scripts/hotspot.sh start"
alias hoff="~/.config/scripts/hotspot.sh stop"
alias qr="~/.config/scripts/hotspot.sh qr"
alias gpus='ssh -i ~/.ssh/safeskool-key.pem ubuntu@ec2-3-220-201-68.compute-1.amazonaws.com'
alias cpus='ssh -i ~/.ssh/safeskool-key.pem ubuntu@ec2-52-203-120-27.compute-1.amazonaws.com'
alias ss='xrandr --output HDMI-1-2 --scale-from 1920x1080 --transform 1.5,0,0,0,1.5,0,0,0,1 --output HDMI-1-2 --mode 1920x1080 --same-as eDP-1'
# History settings
HISTFILE=/home/ash/.config/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000

# Plugins
if [ -f /home/ash/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /home/ash/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    echo "Syntax highlighting loaded" >> /home/ash/zsh_debug.log
else
    echo "Syntax highlighting plugin not found" >> /home/ash/zsh_debug.log
fi

if [ -f /home/ash/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /home/ash/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    echo "Autosuggestions loaded" >> /home/ash/zsh_debug.log
else
    echo "Autosuggestions plugin not found" >> /home/ash/zsh_debug.log
fi

echo "zshrc finished loading at $(date)" >> /home/ash/zsh_debug.log

export ROFI_CONFIG_PATH="$HOME/.config/rofi/rounded-nord-dark.rasi"

# Neovim alias
alias nv='nvim'
source /usr/share/nvm/init-nvm.sh

# Zellij aliases
alias zl='zellij list-sessions'
alias za='zellij attach'
alias zdel='zellij delete-all-sessions'
eval "$(zoxide init zsh)"



# Created by `pipx` on 2025-06-28 11:03:10
export PATH="$PATH:/home/ash/.local/bin"
export PATH=$PATH:$(go env GOPATH)/bin


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# opencode
export PATH=/home/ash/.opencode/bin:$PATH

. "$HOME/.local/bin/env"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - zsh)"
export PATH="$HOME/.cargo/bin:$PATH"

# Keep machine-local credentials out of the public dotfiles repository.
[[ -r "$HOME/.config/zsh/secrets.zsh" ]] && source "$HOME/.config/zsh/secrets.zsh"
export PATH="$HOME/.pyenv/bin:$PATH"

alias cursor='CODEX_HOME=$HOME/.codex-cursor cursor'

# Personal Claude account. Keep its login and settings isolated from JClaude,
# clear any gateway overrides, and forward every CLI option (including --chrome).
claude-ash() {
  command env \
    -u ANTHROPIC_BASE_URL \
    -u ANTHROPIC_AUTH_TOKEN \
    -u CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY \
    CLAUDE_CONFIG_DIR="$HOME/.claude-ash" \
    claude "$@"
}

# Separate Claude account. Keep its login and settings isolated from Claude Ash,
# clear any gateway overrides, and forward every CLI option.
jclaude() {
  command env \
    -u ANTHROPIC_BASE_URL \
    -u ANTHROPIC_AUTH_TOKEN \
    -u CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY \
    CLAUDE_CONFIG_DIR="$HOME/.claude-jclaude" \
    claude "$@"
}

# kimi-code
export PATH="/home/ash/.kimi-code/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/ash/.local/bin:$PATH"

# Gemini-powered Antigravity QA lanes
agy-smoke() {
  command agy --model 'Gemini 3.6 Flash (High)' --agent gemini-fast-qa --sandbox "$@"
}

agy-qa() {
  command agy --model 'Gemini 3.1 Pro (High)' --agent gemini-visual-qa --sandbox "$@"
}
export PATH="$HOME/.cargo/bin:$PATH"
