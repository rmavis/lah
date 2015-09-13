# Last Action Hero

This sort of thing happens to me all the time:

    $ emacs readme.md
    The file readme.md does not exist.
    $ touch readme.md
    $ emacs readme.md

Or maybe I'm just `ls`ing a bunch of directories and find one I need to get into:

    $ ls /long/path/to/where/ever
    $ cd /long/path/to/where/ever

Or I want to remind myself of what a shell function does before running it, so I run `cat`. But I see something's off, so I need to make a quick update:

    $ cat ~/.config/fish/functions/today.fish
    $ emacs ~/.config/fish/functions/today.fish

There are three ways to create that second command:

1. Type the whole thing out.
2. Hit the up arrow, alt-arrow back through the path, delete the `cat`, type in `emacs`.
3. The same as #2 but you hit ctrl-a instead of alt-arrowing.

And here's a fourth method:

    $ lah emacs

`lah` stands for Last Action Hero. It finds the last non-`lah` command in your history, replaces the executable's name with the new name you provide, and executes that new command.

So

    $ emacs readme.md
    The file readme.md does not exist.
    $ lah touch

will run `touch readme.md`, and then

    $ lah emacs

will run `emacs readme.md`.

If you enter more than one parameter, it will append the rest to the end of the new command. So, following the above,

    $ lah emacs notes todo.org

will run `emacs readme.md notes todo.org`.



## Notes

This is an alpha. It's my first work with Racket.

It currently only works with the `[fish][]` shell.

It will spit a `#t` after the `lah`'d command runs. This is Racket's `true` value, that its appearance in your terminal means `lah` ran fine. I don't yet know how to prevent that from appearing.



## Installation

1. Clone the repository.
2. Symlink `dist/bin/lah` somewhere in your `$PATH`.





[fish]: http://fishshell.com/
