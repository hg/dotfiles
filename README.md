# dotfiles

This repository stores my personal configuration files.

## Installation

Install Git and GNU Stow, depending on the distribution:

    # pacman -S stow git
    # dnf install stow git
    # apt install stow git

Clone this repository:

    $ mkdir ~/src && cd ~/src
    $ git clone https://github.com/xero/dotfiles

Run the installation script:

    $ cd dotfiles && ./install

Any conflicting files will be moved to the cloned repository and replaced with symlinks. `git add` & `git reset` them as necessary.

