# vokenny-zsh-theme

A personalised and stripped-back ZSH theme largely based on [agnoster's theme](https://github.com/agnoster/agnoster-zsh-theme)

I personally use it with:
- [iTerm2](https://iterm2.com/) with [Tomorrow Night Blue](https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Tomorrow%20Night%20Blue.itermcolors) theme 
- [VSCode](https://code.visualstudio.com/) with Tomorrow Night Blue theme
- [Git](https://git-scm.com/)
- Unicode-compatible fonts such as Fira Code

## Main differences
1. Colors - the prompt colours are chosen with Tomorrow Night Blue theme in mind
2. Pre-pending a date & time stamp in the prompt
3. Removing a lot of the extra info that I didn't want/need

## Compatibility

**NOTE:** In all likelihood, you will need to install a [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts) for this theme to render correctly.

To test if your terminal and font support it, check that all the necessary characters are supported by copying the following command to your terminal: `print "\ue0b0 \u00b1 \ue0a0 \u27a6"`. The result should not render any question marks in boxes (unknown characters).
