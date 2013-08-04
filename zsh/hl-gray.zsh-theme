author: vincent178
# URL: http://www.vincent178.com/
# Repo: https://github.com/andyfleming/oh-my-zsh
#
# Created on: May 31, 2013
# Last modified on:May 31, 2013



if URL[ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
  local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
$FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
if which rvm-prompt &> /dev/null; then
    RPROMPT='$my_gray ruby $(~/.rvm/bin/rvm-prompt i v g) %{$reset_color%}'
    else
        if which rbenv &> /dev/null; then
              RPROMPT='$my_gray ruby $(rbenv version | sed -e "s/ (set.*$//") %{$reset_color%}'
                fi
                fi



# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]["
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075]]%{$reset_color%}"
