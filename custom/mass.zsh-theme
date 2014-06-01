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
GIT_PROMPT_AHEAD="%{$fg[red]%}>%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}<%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}●%{$reset_color%}"
