# Left Side Prompt
PS1='%B%F{yellow}[\
%b%F{red}%n\
%B%F{yellow}@\
%b%F{red}%m\
%B%F{yellow}] [\
%b%F{green}%~\
%B%F{yellow}]\
%F{reset}$(git_prompt_string)\
%B%F{yellow} |»\
%b%F{reset} '

# Right Side Prompt
RPS1='%B%F{yellow}[\
%b%F{red}%*::%D\
%B%F{yellow}]\
%b%F{reset}'

GIT_PROMPT_SYMBOL=" "
GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg_bold[yellow]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg_bold[red]%}>%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg_bold[cyan]%}<%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
