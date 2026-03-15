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

#lua
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/ash/.luarocks/share/lua/5.4/?.lua;/home/ash/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/ash/.luarocks/lib/lua/5.4/?.so'
export PATH='/home/ash/.luarocks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/ash/Android/Sdk/tools:/home/ash/Android/Sdk/platform-tools:/home/ash/Android/Sdk/emulator'

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
