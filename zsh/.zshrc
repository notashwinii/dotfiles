# Debug log with absolute path
echo "Debug: Loading zshrc at $(date)" >> /home/ash/zsh_debug.log

# Theme
fpath=(/home/ash/.config/zsh/plugins/typewritten $fpath)
autoload -U promptinit; promptinit
prompt typewritten

# Completion settings
zstyle :compinstall filename '/home/ash/.config/zsh/zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# Aliases
alias rm='trash'
alias remove='\rm -rf'

# History settings
HISTFILE=/home/ash/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000

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
