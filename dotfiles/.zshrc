# Reference: http://zsh.sourceforge.net/Doc/Release/index.html
# ========================================
# Author: Theerawat Kiatdarakun
#
# Welcome to .zshrc
# executed when creating interactive shell
# I put everything interactive here
# ========================================
local line_str="----------------------------------------"
# Aliases ================================
alias    ...="cd ../.."
alias    ls='ls --color'
alias    sl="ls"
alias    2change-brightness="xrandr --output LVDS-1 --brightness"
function 2change-tab_title { echo -en "\e]2;$1\a" }
alias    2copy-file_to_clipboard="xclip -sel clip"
alias    2display-filesize="du -sh ./*"
alias    2edit-.tmux.conf="vim ~/.tmux.conf && tmux source-file ~/.tmux.conf"
alias    2edit-.zshrc="vim ~/.zshrc && source ~/.zshrc"
[ -d ~/Git/dotfiles ] &&
alias    2edit-dotfiles="vim ~/Git/dotfiles"
[ -d ~/Git/scripts ] &&
alias    2edit-scripts="vim ~/Git/scripts"
function 2goto-symlink { cd $(dirname $(readlink $1)) }
alias    2logout="pkill -u $USER"
function 2run {
	$1 > /dev/null 2>&1 &
	disown
}
function 2start-tor-browser {
	~/Applications/tor-browser_en-US/Browser/start-tor-browser > /dev/null 2>&1 &
	disown
}
function git-status-all { for x in *; do echo $line_str && echo "Folder name: ${x}" && echo $line_str && git --work-tree=$x --git-dir=$x/.git status; done }

# OS specific
if [[ $(lsb_release -a | grep 'Void Linux' | wc -l) != '0' ]]
then
	alias vim='gvim -v'

	alias 2install-pkg='sudo xbps-install'
	alias 2query-pkg='xbps-query -Rs'
	alias 2remove-pkg='sudo xbps-remove'
	alias 2start-internet='sudo wpa_supplicant -B -D wext -i wlp3s0 -c /etc/wpa_supplicant/wpa_supplicant.conf'
	alias 2update-os='sudo xbps-install -Su'
fi
# ----------------------------------------
# History ================================
HISTFILE=~/.zsh_history
HISTSIZE=1000 # max entries in current-session memory
SAVEHIST=1000 # max entries in HISTFILE
setopt incappendhistory # immediately append to history file, not waiting until shell exits
setopt sharehistory # share history across terminals
# ----------------------------------------
# Keybinding ============================
bindkey "\e[3~" delete-char
# function zle-line-init () { echoti smkx }
# function zle-line-finish () { echoti rmkx }
# zle -N zle-line-init
# zle -N zle-line-finish
# ----------------------------------------
# LS_COLORS ==============================
# get and reset default value
eval $(dircolors | head -1)
LS_COLORS=$(echo $LS_COLORS | sed -e 's/=[^=]*:/=0:/g')
# remap and export
LS_COLORS=$LS_COLORS'di=1;30;107:tw=1;30;107:ow=1;30;107:'
LS_COLORS=$LS_COLORS'ln=1;36:'
LS_COLORS=$LS_COLORS'*.7z=35:*.bz=35:*.bz2=35:*.gz=35:*.rar=35:*.tar=35:*.zip=35:'
export LS_COLORS
# ----------------------------------------
# Prompt =================================
# pick emoji
local emojis=('$' '( °Д°) ' '( •̀ω•́)つ' '(´＿- `)' '(๑•﹏•)⋆*' '( °Д°) ┻━┻' '(ﾉ´ヮ´)ﾉ*' 'ʕ •ᴥ•ʔ' '(˘ ³˘)♥' '(っ˘з(˘⌣˘)' '(ɔˆз(ˆ⌣ˆc)' '( ˘⌣˘)♡' '(¬_¬ )')
local emoji=$emojis[$(($RANDOM % ${#emojis[@]} + 1))]
# pick color of the day
local day=$(date +%u) # Mon(1)-Sun(7)
local colors=(11 165 046 208 014 129 196); local color=$colors[day]
local colors_light=(227 213 121 180 123 099 124); local color_light=$colors_light[day]
# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '(%a'$'\UE0A0''%b)' # used when git detected and e.g. rebase/merge conflict
zstyle ':vcs_info:*' formats '(%F{'$color_light'}%n/%r'$'\UE0A0''%b%f)' # used when git detected and actionformats is inactive
setopt PROMPT_SUBST
precmd () { vcs_info }
# modify prompt
PROMPT='%F{'$color_light'}%n@'$HOST':%F{'$color'}%0 %1~%f'
PROMPT='%B'$PROMPT'%(!.(root).)'\$vcs_info_msg_0_'%b%(60l.'$'\n''.)'${emoji}' '
# PROMPT='%F{'$color_light'}%n@'$HOST'%f(%D{%L:%M}):%F{'$color'}%0 %1~%f'
# PROMPT='%B'$PROMPT'%(!.(root).)'\$vcs_info_msg_0_'%b%(60l.'$'\n''.) '
# ----------------------------------------
# Tab Completion =========================
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# ----------------------------------------
##########################################
#=========== external config =============
##########################################
