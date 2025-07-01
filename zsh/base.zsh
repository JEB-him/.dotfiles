# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ===Some alias created by Jeb===
alias tmp='cd ~/TMP/'
alias ggdb='gdb -tui'
alias pcmr='sudo reflector --country China --sort rate --protocol https --latest 20 --save /etc/pacman.d/mirrorlist'
alias h='history 0'
alias hibernate='sudo systemctl hibernate'

# === 一些快捷键 ===

if [[ -o interactive ]]; then
  echo "Binding a key map for lazygit."
fi
# lazygit
function lazygit-widget() {
  lazygit
  zle reset-prompt
}
zle -N lazygit-widget
bindkey '^g' lazygit-widget
echo 'set the fucking lazygit!'


# 设置默认编辑器
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +IndentLinesDisable +Man!'
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

# 通用别名
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l --color=auto'
alias l.='ls -d .* --color=auto'
alias cgvim='nvim ~/.vim/vimrc'
alias cgzsh='nvim ~/.zshrc'

# 设置 PATH
export PATH="$HOME/.local/bin:$PATH"

# 设置代理
alias setproxy="export http_proxy=http://127.0.0.1:7897/; export https_proxy=http://127.0.0.1:7897/; echo 'Set proxy successfully'"
alias unsetproxy="unset http_proxy; unset https_proxy; echo 'Unset proxy successfully'"

# npm 代理
alias setnpmproxy="npm config set proxy http://127.0.0.1:7897; npm config set https-proxy http://127.0.0.1:7897; echo 'Set npm proxy successfully'"
alias unsetnpmproxy="npm config delete proxy; npm config delete https-proxy; echo 'Unset npm proxy successfully'"

# 配置 TWOUC 数据库信息
export OUC_SQL_HOST="47.104.90.193"
export OUC_SQL_NAME="ouc_sql"
export OUC_SQL_USER="ouc_user"
export OUC_SQL_PASSWORD="GhaHChrB2658"

# Pyenv 配置
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# 010 Editor 路径
export PATH="$PATH:/home/jebhim/my_packages/010editor"

# Anaconda 配置
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=true

# Conda 惰性加载
__conda_loaded=false
function conda() {
  if [ "$__conda_loaded" = false ]; then
    # 首次调用时再运行 shell hook
    __conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    eval "$__conda_setup"
    unset __conda_setup
    __conda_loaded=true
  fi
  # 真正执行 conda 命令
  command conda "$@"
}

# zsh plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# AI Alias
alias ag="aichat --role Jh --session default"
alias rd="aichat --role reader --session default"
alias translate="aichat --role translator --session defualt"

# Set Zsh history saving
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# g++ quickly build
alias qbuild="g++ *.cpp -o main -std=c++20 -g -Wall -Wextra -Wpedantic -Wconversion"

alias qbuildr="qbuild && ./main"

# Configure for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# 设置 clangd 编码风格
export CLANGD_FLAGS="--fallback-style=Google"
