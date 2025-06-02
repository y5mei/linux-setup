export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/depot_tools # Add depot_tools to PATH, downoad from here: https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
zstyle ':omz:update' mode auto      # update automatically without asking

plugins=(
  git
  fzf
  zsh-autosuggestions
  fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# Settings for fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
# Enable fzf tab completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=bg+:#282a36,fg:#f8f8f2,hl:#bd93f9,info:#50fa7b,prompt:#ff79c6,spinner:#ffb86c,marker:#ff5555"