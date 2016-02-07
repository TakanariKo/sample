
export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

# Vim bind
bindkey -v

# set history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# [user@host] 
# %n user
# %m hostname
# %T time(HH:MM)
# %* time(HH:MM:SS)
# %D date(YY-MM-DD)
# %n line feed
# %~ currret directory
# {} color : fg[color], {reset_color}
# %# user type
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# 区切り文字
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# 補完
autoload -Uz compinit
compinit

# big letter matching with small letter
zstyle ':completion:*' mathcer-list 'm:{a-z}={A-Z}'

# sude の後でコマンド名の補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \/usr/sbin /usr/bin /sbin /usr/X11R6/bin

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ^Rで履歴検索 * でワイルドカード使用を許可する
bindkey '^R' history-incremental-pattern-search-backward

source ~/Develop/z/z.sh

function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
  zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search

