cowfortune
==========

Yet another cowfortune script (inspired by mint-fortune) that excludes
too line hungry beasts for less terminal flooding.
To specify the cows in question, you can provide per-user whitelist or
blacklist files that will be respected.
It is also possible to define options that will be passed to fortune,
so you can specify fortune files or length etc.


Installation
------------

The lazy way:
    make && make install

To test the environment and requirements:
    make

To install the cowfortune script and create the configs:
    make install

To uninstall only the cowfortune script itself:
    make uninstall

To purge the cowfortune script including the configuration:
    make purge


The default installation location is `/usr/games` and could be overriden by
setting the `PREFIX` and `BINDIR` env var before running make or by providing
those inside `Makefile.local`.


Usage
-----

For the ultimative cow experience, put `cowfortune` into your `.zshrc` or `.bashrc`.


Configuration
-------------

### cowsay
All available cows will be read from either `COWPATH` or `/usr/share/cowsay/cows`.

You can configure a global whitelist and blacklist:
    /etc/cowfortune/whitelist
    /etc/cowfortune/blacklist

Optional per-user configuration:
    ~/.cowfortune/whitelist
    ~/.cowfortune/blacklist

If you don't want to use the whitelist, dont create that file or simply
keep it at zero length.

### fortune
To pass options to the fortune command, you can use the config file read
from either `~/.cowfortune/config` or `/etc/cowfortune/config`.

#### Available options:
- `LENGTH_SHORT [INTEGER]`
    - **default:** 180
    - **synopsis:** Set the longest fortune length (in characters) considered to be 'short'.

- `LENGTH_USE [short,long,all]`
    - **default:** short
    - **synopsis:** Short, long or all apothegms. See `LENGTH_SHORT` on which fortunes are considered 'short'.

- `OFFENSIVE_ONLY [0,1]`
    - **default:** 0
    - **synopsis:** Choose only from potentially offensive aphorisms. This option is ignored if a fortune directory/file is specified.

- `FORTUNES [FILE]`
    - **default:** undefined -- use all
    - **synopsis:** Choose only fortunes from specified fortune directory/file. If any specified, the `OFFENSIVE_ONLY` options will be ignored.

- `DEBUG_SOURCE [0,1]`
    - **default:** 0
    - **synopsis:** Show the cookie file from which the fortune came.

- `DEBUG_COW [0,1]`
    - **default:** 0
    - **synopsis:** Show the used and all available cow files after blacklist/whitelist processing.

- `DEBUG_FILES [0,1]`
    - **default:** 0
    - **synopsis:** Print out the list of files which would be searched, but don't print a fortune.

- `DEBUG_OPTIONS [0,1]`
    - **default:** 0
    - **synopsis:** Print out the command line arguments that are passed to the fortune command.


Requirements
------------

- cowsay
- fortune
- awk


