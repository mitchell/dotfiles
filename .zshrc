# --- History ---
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000

# --- Options ---
setopt autocd
setopt sharehistory
setopt histignoredups
setopt histignorealldups
setopt histsavenodups
bindkey -v

# --- Completion ---
zstyle :compinstall filename '/home/m/.zshrc'
autoload -Uz compinit
compinit

# --- Aliases ---
alias ls='lsd'
alias ll='ls -l'
alias la='ls -lA'
alias o='opencode run --thinking'
alias oc='opencode'
alias sctl='sudo systemctl'
alias uctl='systemctl --user'

# --- Keybinds ---
bindkey '.,' open-nvim
bindkey ',l' clear-screen
bindkey ',r' fzf-history-widget
bindkey ',f' fzf-file-widget
bindkey ',c' fzf-cd-widget

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# --- Functions ---
function open-nvim { nvim; }
zle -N open-nvim open-nvim

function m {
	local tmp cwd
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd <"$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# --- Prompt Configuration ---
prompt_char='>'

function set_prompt {
	local branch
	branch="$(git branch --show-current 2>/dev/null)"

	if [[ "$PWD" == "$HOME" ]]; then
		PROMPT="%F{magenta}%~%f $prompt_char "
	elif [[ "$branch" != '' ]]; then
		PROMPT="%F{magenta}%~%f ($branch)
$prompt_char "
	else
		PROMPT="%F{magenta}%~%f
$prompt_char "
	fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

function set_prompt_char {
	local old
	old=$prompt_char

	if [[ $KEYMAP == vicmd && $REGION_ACTIVE != 0 ]]; then
		prompt_char='v'
	elif [[ $KEYMAP == vicmd ]]; then
		prompt_char='<'
	else
		prompt_char='>'
	fi

	if [[ $prompt_char != "$old" ]]; then
		set_prompt
		zle reset-prompt
	fi
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget line-pre-redraw set_prompt_char

# --- External Tools & Plugins ---
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
