## Set values
# Remove annoying stuff from PATH that won't freaking go away 
set PATH (string match -v "/home/josh/Github stuff not in AUR" $PATH)
set PATH (string match -v "/home/josh/.emacs.d/bin" $PATH)

#######################
### My custom stuff ###
#######################

# Fix weird-looking man pages
set -x MANROFFOPT -c

# Set nvim as default editor 
set -Ux EDITOR nvim

# Stop ranger from loading both system and local config
set -x RANGER_LOAD_DEFAULT_RC FALSE

# Alias cd to Zoxide
alias cd='z'

# Alias paru -Rcs to yeet lol
alias yeet='paru -Rcus'

# Alias clear to clear && fastfetch
alias clear='clear && fastfetch'

# Adding zoxide https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# Get fastest mirrors
alias mirrors="sudo reflector --country 'United States' --protocol https --age 24 --sort rate --latest 20 --save /etc/pacman.d/mirrorlist"

# Set cursor to line
set fish_cursor_default block

## FZF stuff ##
# Enables these keybindings: 
# ctrl-t - fzf select 
# ctrl-r - fzf history
# alt-c - fzf cd
fzf --fish | source

#######################
#### Garuda stuff #####
#######################

# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Starship prompt
if status --is-interactive
    source ("/usr/bin/starship" init fish --print-full-init | psub)
end

## Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.fish

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with exa
alias ls='exa -l --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles
alias ip='ip -color'

# Replace some more things with better alternatives
alias cat='bat --color=always'

# Common use
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# Run fastfetch if session is interactive
if status --is-interactive && type -q fastfetch
    fastfetch
end
