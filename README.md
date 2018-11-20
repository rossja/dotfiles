# Dotfiles

This is a collection of configuration files I find handy

## Cool ZSH prompt: Zero to Eleven (on Mac OS X)

1. Install dev tools: `xcode-select --install`
1. Install homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Clone this repo: `git clone "https://github.com/rossja/dotfiles.git" "$HOME/Documents/dotfiles"`
1. Install the required software: `cd $HOME/Documents/dotfiles/public/homebrew && brew bundle`
1. Clone the iterm2 themes repo: `git clone "https://github.com/mbadolato/iTerm2-Color-Schemes.git" "$HOME/src/iTerm2-Color-Schemes"`
1. Configure iterm2:
     * General Tab:
       - check 'Quit when all windows are closed'
     * Appearance Tab:
       - Check 'Dimming affects only text, not background'
       - Check 'Dim background windows'
       - Set Theme to 'Dark'
     * Profiles Tab:
       - Make a new profile, and edit it with:
         1. General:
           * Set 'Working Directory' to 'Reuse previous session's directory'
         1. Colors
           * Set Color Theme to whatever you like. I prefer 'Misterioso' theme
         1. Text
           * Change font to powerline-enabled font *('Hack Nerd Font' is in the bundle)*
         1. Terminal
           * Change scrollback lines to 100,000
       - Set New profile as default
1. Close terminal, start iterm2
1. Enjoy the awesome!
