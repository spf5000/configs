# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sean/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# git support
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %F{156}[%b]'

PROMPT='%B%F{043}%n %fin %B%F{222}%~$vcs_info_msg_0_%f: '

# Auto complete and autosuggestion see:
# https://wiki.archlinux.org/index.php/Zsh#Fish-like_syntax_highlighting_and_autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#afff5f,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#d0d0d0,bold,underline"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
alias vim=nvim
