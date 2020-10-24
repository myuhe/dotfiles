autoload -U compinit
compinit

export LANG=ja_JP.UTF-8
export SCALA_HOME=/usr/lib/scala
export PATH=$PATH:$SCALA_HOME/bin
export QT_IM_MODULE='xim'
export EDITOR="emacs"
export XDG_DATA_HOME="$HOME/.local"

GIT_DISCOVERY_ACROSS_FILESYSTEM="true"

## プロンプトの設定
autoload -U colors
colors

# PROMPT2='[%n]> ' 
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'

# PROMPT="%{${fg[yellow]}%}[%n@%m][%d]%~%{${reset_color}%} $ "

PROMPT="%{${fg[yellow]}%}[%d]${reset_color}%}
→ "


setopt cdable_vars

setopt extended_glob
## 補完候補を一覧表示
setopt auto_list
## 重複するコマンドが記憶されるとき、古い方を削除する。
setopt hist_ignore_dups
# ディレクトリ名を入力するだけで移動
setopt auto_cd 
# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd 
setopt pushd_ignore_dups
bindkey -e
setopt nobeep
##補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types 
# コマンド訂正
setopt correct 
# 補完候補を詰めて表示する
setopt list_packed 
# 履歴を共有する。
setopt share_history
# パスの補完を高速化
# http://lethalman.blogspot.com/2009/10/speeding-up-zsh-completion.html
zstyle ':completion:*' accept-exact '*(N)'
##"^"で上のディレクトリに移動する
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
# bindkey '^K' cdup


##export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'


# Java
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

# Android
export ANDROID_SDK_HOME=~/android/sdk
export PATH=$PATH:$ANDROID_SDK_HOME/tools

#エイリアス
alias shut='sudo shutdown -h now'
alias ls='ls --color=auto'
alias api='sudo apt-get install'
alias apu='sudo apt-get update && sudo apt-get upgrade'
alias apa='sudo apt-get autoremove'
alias apr='sudo apt-get remove'
alias ec='emacsclient -nw -c'
alias sec='sudo emacsclient -nw -c '
alias ecx="emacsclient -n -c"
alias secx="sudo emacsclient -n -c"

alias yau='yaourt -Syua'
alias par='sudo pacman -R'
alias yas='yaourt -S'
alias ya='yaourt'

alias eh='perl /home/yuhei/Documents/perl/ehgm2.pl'
alias ehp='perl /home/yuhei/Documents/perl/ehgm2.pl -P /home/yuhei/Documents/perl/ProxyList.txt'

# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# bindkey "^J" history-beginning-search-backward-end
# bindkey "^K" history-beginning-search-forward-end

HISTFILE=~/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 

setopt autoremoveslash
unsetopt sh_word_split

is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
cmd=$(whence "$cmd")
    done
echo "$cmd"
}


if ! is_screen_or_tmux_running && shell_has_started_interactively; then
for cmd in tmux tscreen screen; do
if whence $cmd >/dev/null 2>/dev/null; then
            $(resolve_alias "$cmd")
            break
fi
done
fi
 
# completion
setopt auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*' menu select
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access false
# 補完侯補をEmacsのキーバインドで動き回る
zstyle ':completion:*:default' menu select=1
# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## psでパスとか他の情報も表示
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _list _history

zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## auto-fu.zsh stuff.
##source ~/.zsh/auto-fu.zsh
{ . ~/.zsh/auto-fu; auto-fu-install; }
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=red,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
##zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
zstyle ':auto-fu:var' disable magic-space

zle-line-init () {auto-fu-init;}; zle -N zle-line-init

# ZSH Directory Bookmarks
dotfiles=/home/yuhei/Documents/dotfiles_myuhe/

# zsh 4.3.10 以降じゃないと動かないと思う
# bindkey '^R' history-incremental-pattern-search-backward
# bindkey '^S' history-incremental-pattern-search-forward

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
fi

function percol-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        percol --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N percol-select-history

bindkey '^R' percol-select-history
bindkey -M afu '^R' percol-select-history


# percol で z / autojump のようにディレクトリ高速ジャンプ - Slip Ahead Logging <http://stillpedant.hatenablog.com/entry/percol-cd-history>
# cd 履歴を記録
typeset -ga chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file # cd 履歴の記録先ファイル
function chpwd_record_history() {
echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions+=chpwd_record_history
 
# percol を使って cd 履歴の中からディレクトリを選択
# 過去の訪問回数が多いほど選択候補の上に来る
function percol_get_destination_from_history() {
sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
sed -e 's/^[ ]*[0-9]*[ ]*//' | \
sed -e s"/^${HOME//\//\\/}/~/" | \
percol | xargs echo
}
 
# percol を使って cd 履歴の中からディレクトリを選択し cd するウィジェット
function percol_cd_history() {
local destination=$(percol_get_destination_from_history)
if [ -n "$destination" ]; then
echo
cd ${destination/#\~/${HOME}}
echo "\033[31m=>\033[0m \033[036m$destination\033[0m"
fi
zle reset-prompt
}
zle -N percol_cd_history
 
# percol を使って cd 履歴の中からディレクトリを選択し，現在のカーソル位置に挿入するウィジェット
function percol_insert_history() {
local destination=$(percol_get_destination_from_history)
if [ $? -eq 0 ]; then
local new_left="${LBUFFER} ${destination} "
BUFFER=${new_left}${RBUFFER}
CURSOR=${#new_left}
fi
zle reset-prompt
}
zle -N percol_insert_history
 
# C-x ; でディレクトリに cd
# C-x i でディレクトリを挿入
bindkey '^x^x' percol_cd_history
bindkey '^xi' percol_insert_history


# auto-fu.zsh を使っているのなら以下も
bindkey -M afu '^x^x' percol_cd_history
bindkey -M afu '^xi' percol_insert_history

# added by travis gem
[ -f /home/yuhei/.travis/travis.sh ] && source /home/yuhei/.travis/travis.sh

if [[ "$TERM" == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi
