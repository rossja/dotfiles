# Dotfiles

This is a collection of configuration files I find handy

## Cool ZSH prompt: Zero to Eleven

### on Mac OS X

1. Install dev tools: `xcode-select --install`
1. Install homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Clone this repo: `git clone "https://github.com/rossja/dotfiles.git" "$HOME/src/dotfiles"`
1. Install the required software: `cd $HOME/src/dotfiles/public/homebrew && brew bundle`
1. *(OPTIONAL)* Clone the iterm2 themes repo: `git clone "https://github.com/mbadolato/iTerm2-Color-Schemes.git" "$HOME/src/iTerm2-Color-Schemes"`
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
                * Set Color Theme to whatever you like. I prefer 'Smoooooth' theme
                * Set Cursor color to white
                * Set Cursor text color to black
            1. Text
                * Change font to powerline-enabled font *('Hack Nerd Font Mono' is in the bundle)*
            1. Terminal
                * Change scrollback lines to 100,000
       - Set New profile as default
1. Link the zsh configurations:
   ~~~
   ln -s $HOME/src/dotfiles/public/zsh/.zshrc $HOME/.zshrc
   ln -s $HOME/src/dotfiles/public/zsh/.zsh.d $HOME/.zsh.d
   ln -s $HOME/src/dotfiles/public/zsh/.aliases.zsh $HOME/.aliases.zsh
   ln -s $HOME/src/dotfiles/public/zsh/.oh-my-zsh $HOME/.oh-my-zsh
   ~~~
1. Close terminal, start iterm2
1. Enjoy the awesome!

**A screenshot of the zsh configuration described above**
![screenshot of the zsh configuration described above](images/screenshot-iterm2-misterioso.png?raw=true "a handy screenshot")

**A screenshot of the same config on the system terminal, using the Pro theme**
![screenshot of the same config on the system terminal, using the Pro theme](images/screenshot-terminal-pro.png?raw=true "another handy screenshot")





### on Linux (Ubuntu/Debian Based)

1. Install dev tools: `apt-get install git`
1. Clone this repo: `git clone "https://github.com/rossja/dotfiles.git" "$HOME/src/dotfiles"`
1. Install the desired fonts from `$HOME/Documents/dotfiles/public/fonts`
1. Configure your terminal to use the desired font
1. Link the zsh configurations:
   ~~~
   ln -s $HOME/src/dotfiles/public/zsh/.zshrc $HOME/.zshrc
   ln -s $HOME/src/dotfiles/public/zsh/.zsh.d $HOME/.zsh.d
   ln -s $HOME/src/dotfiles/public/zsh/.aliases.zsh $HOME/.aliases.zsh
   ln -s $HOME/src/dotfiles/public/zsh/.oh-my-zsh $HOME/.oh-my-zsh
   ~~~
1. Restart terminal
1. Enjoy the awesome!

**A screenshot of the zsh configuration described above, on Kali Linux (KDE version)**
![screenshot of the zsh configuration described above on Kali Linux using Konsole](images/screenshot-linux-konsole.png?raw=true "a handy screenshot")
