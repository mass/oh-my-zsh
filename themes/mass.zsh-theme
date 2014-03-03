PS1=$'%{$fg_bold[yellow]%}[%{$fg_bold[red]%}%n%{$fg_bold[yellow]%}@%{$fg_bold[red]%}%m%{$fg_bold[yellow]%}] [%{$fg_bold[red]%}%~%{$fg_bold[yellow]%}] [%{$reset_color%}$(git_prompt_string)%{$fg_bold[yellow]%}] $%{$reset_color%} '
RPS1='%{$fg_bold[yellow]%}[%{$fg_bold[red]%}%T - %D%{$fg_bold[yellow]%}]%{$reset_color%}'

GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX="%{$fg_bold[green]%}{%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg_bold[green]%}}%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}>%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}<%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
