PS1=$'\e[1;32m%n@%m\e[0m:\e[1;34m%~\e[0m\e[0;31m$(git_prompt_string)\e[0m$ '
RPS1=""

GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[red]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}>%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}<%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
