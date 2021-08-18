zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
setopt RM_STAR_SILENT
setopt AUTO_CD
# setopt SHARE_HISTORY
# PROMPT_COMMAND='fc -W; fc -R'
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
alias grep="grep --colour=auto"
alias ls='\ls -lvh --color'
alias l='ls'
alias lst='ls -tr'
alias lt='lst'
alias rm='\rm -vi'
#alias -s null='> /dev/null 2>&1'
#alias clipcopy='xclip -selection clipboard'
#alias clippaste='xclip -o -selection clipboard'
# xbindkeys
DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_CLI_TELEMETRY_OPTOUT
precmd() {
	EXIT_STATUS=$?
	RPROMPT="%F{250}[%T]%f"

	if [ $EXIT_STATUS != 0 ]; then
		PS1=" %B%F{250}($EXIT_STATUS)%f"$'\t'"%F{228}%d%f %F{196}->%f%b "
	else
		PS1=" %B%F{250}($EXIT_STATUS)%f"$'\t'"%F{228}%d%f %F{119}->%f%b "
	fi
}

