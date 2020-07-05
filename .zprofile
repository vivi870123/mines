# Following automatically calls "startx" when you login:
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1

# adds `~/.local/bin/*`to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Default programs:
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="qutebrowser"
export READER="zathura"
export FILE="vifm"
export LAUNCHER="dmenu_run"
export FILEBROWSER="$TERMINAL -e bash $HOME/.config/vifm/scripts/vifmrun"
export MUSIC="$TERMINAL -e ncmpcpp"
export EMAIL="$TERMINAL -e neomutt"
export AUDIO="$TERMINAL -e pulsemixer"
export PROCESS="$TERMINAL -e htop"
export TORRENT="$TERMINAL -e tremc"
export NOTES_DIR="~/Documents/notes"

# ~/ Clean-up:
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export INPUTRC="$HOME/.config/inputrc"
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Other program settings:
export SUDO_ASKPASS="/home/chris/.local/bin/dmenu/askpass"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_DEFAULT_OPTS="--prompt='» ' --pointer='▶' --marker='✓ ' --reverse --tabstop 2 --multi --color=bg+:-1,marker:010 --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '($FZF_PREVIEW_COMMAND) 2> /dev/null' --preview-window down:60%:noborder"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap:hidden --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} 2> /dev/nul"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx

