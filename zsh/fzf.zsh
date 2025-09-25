export FZF_DEFAULT_OPTS="--style=full --bind=ctrl-t:top,change:top --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2>/dev/null | head -500'"
export FZF_DEFAULT_COMMAND='fd'
export FZF_COMPLETION_TRIGGER='\'

# 导入 fzf 准备好的 zshrc
source <(fzf --zsh)
