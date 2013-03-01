# ZSH Theme emulating the Fish shell's default prompt.

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo ':'
  #echo '○'
}

local user_color='magenta'; [ $UID -eq 0 ] && user_color='red'

#PROMPT='%n@%m %{$fg[$user_color]%}%~%{$reset_color%}%(!.#.>) '
#PROMPT='λ|%m %{$fg[$user_color]%}%2~%{$reset_color%}$(prompt_char) '
PROMPT='λ|%m %{$fg[$user_color]%}%2~%{$reset_color%}%(!.#.:) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT='${return_status}$(git_prompt_info) $(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ± "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[magenta]%} ○"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"