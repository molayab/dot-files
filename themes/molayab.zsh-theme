# themes/amuse.zsh-theme
# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

PROMPT='
%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info)
λ '

# Show git only if there are stashed changes.
function git_prompt_stash() {
  local stash_count="$(git stash list 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$stash_count" -gt 0 ]; then
    echo "%{$fg_bold[yellow]%}⚑ $stash_count%{$reset_color%}"
  fi
}

# Show background jobs if there are any.
function job_prompt() {
  local job_count="$(jobs | wc -l | tr -d ' ')"
  if [ "$job_count" -gt 0 ]; then
    echo " %{$fg_bold[blue]%}⚙ $job_count%{$reset_color%}"
  fi
}

RPROMPT='$(git_prompt_stash)$(job_prompt)'

VIRTUAL_ENV_DISABLE_PROMPT=0
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=" %{$fg[green]%}🐍 "
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX