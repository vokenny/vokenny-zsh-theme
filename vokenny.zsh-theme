# Vokenny's Theme

## README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/powerline/fonts)
#
# My personal theme largely based on [agnoster's theme](https://github.com/agnoster/agnoster-zsh-theme)
#
# It's a personalised and stripped-back version:
# 1. Colors - I use Tomorrow Night Blue themes in iTerm2 and VSCode, so the prompt colours are chosen with that in mind
# 2. Pre-pending a date & time stamp in the prompt
# 3. Removing a lot of the extra info that I didn't want/need

### ZSH PROMPT CUSTOMISATION

## Segments of the prompt, default order declaration
typeset -aHg PROMPT_SEGMENTS=(
  prompt_time
  prompt_dir
  prompt_git
  prompt_end
)

## Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=black
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
NEWLINE=$'\n'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

## Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Time: formatted date & time stamp when the command executed, e.g. Web 29 Dec - 16:30:05
prompt_time() {
  prompt_segment yellow $PRIMRY_FG '%{$fg_bold[black]%} %D{%a%e %b - %r'
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue $PRIMARY_FG ' %~ '
}

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} $PLUSMINUS"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color $PRIMARY_FG
    print -n " $ref"
  fi
}

## Main prompt
prompt_main() {
  CURRENT_BG='NONE'
  for prompt_segment in "${PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

## Random emoji
EMOJI=(💩 🐦 🚀 🐞 🎨 🍕 🐭 👽 ☕️ 🔬 💀 🐷 🐼 🐶 🐸 🐧 🐳 🍔 🍣 🍻 🔮 💰 💎 💾 💜 🍪 🌞 🌍 🐌 🐓 🍄)

random_emoji() {
  print -n "$EMOJI[$RANDOM%$#EMOJI+1]"
}

prompt_precmd() {
  vcs_info
  PROMPT='${NEWLINE}%{%f%b%k%}$(prompt_main)${NEWLINE}$(random_emoji) > '
}

prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_setup "$@"
