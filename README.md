cowfortune
==========

Yet another cowfortune script (inspired by mint-fortune) that excludes
too line hungry beasts for less terminal flooding.  
To specify the cows in question, you can provide per-user whitelist or
blacklist files that will be respected.  
It is also possible to define options that will be passed to fortune,
so you can specify fortune files or length etc.

     ________________________________________
    ( Just go with the flow control, roll    )
    ( with the crunches, and, when you get a )
    ( prompt, type like hell.                )
     ----------------------------------------
            o   ^__^
             o  (oo)\_______
                (__)\       )\/\
                    ||--WWW |
                    ||     ||


Installation
------------

The lazy way:

    make && make install

To generate the cowfortune script:

    make

To install the cowfortune script and create the configs:

    make install

To uninstall only the cowfortune script itself:

    make uninstall

To purge the cowfortune script including the configuration:

    make purge

To test the environment and requirements:

    make test

To clean the local environment:

    make clean


The default installation location is `/usr/games` and could be overriden by
setting the `PREFIX` and `BINDIR` env var before running make or by providing
those inside `Makefile.local`.


Usage
-----

For the ultimative cow experience, put `cowfortune` into your `.zshrc` or `.bashrc`.  
  
Or if you feel like you need a moo...

    cowfortune


Configuration
-------------

### Cows
All available cows will be read from either `COWPATH` or `cowsay -l`.

##### global configuration:

    /etc/cowfortune/whitelist
    /etc/cowfortune/blacklist

##### user configuration:

    ~/.cowfortune/whitelist
    ~/.cowfortune/blacklist

_If you don't want to use the whitelist, dont create that file or simply
keep it at zero length._

### Customization
To pass options to the `fortune` or `cowsay` command, use these config file locations:

    ~/.cowfortune/config
    /etc/cowfortune/config


##### Available options:
- `LENGTH_SHORT [INTEGER]`  
**synopsis:** Set the longest fortune length (in characters) considered to be 'short'.  
**default:** 180  
  
- `COLUMN_WIDTH [INTEGER]`  
**synopsis:** Specifies roughly where the message should be wrapped.  
**default:** 50  
  
- `LENGTH_USE [short,long,all]`  
**synopsis:** Short, long or all apothegms. See `LENGTH_SHORT` on which fortunes are considered 'short'.  
**default:** short  
  
- `OFFENSIVE_ONLY [0,1]`  
**synopsis:** Choose only from potentially offensive aphorisms. This option is ignored if a fortune directory/file is specified.  
**default:** 0  
  
- `FORTUNES [FILE...]`  
**synopsis:** Choose only fortunes from specified directory/file. If specified, the `OFFENSIVE_ONLY` options will be ignored.  
**default:** undefined  
  
- `DEBUG_SOURCE [0,1]`  
**synopsis:** Show the cookie file from which the fortune came.  
**default:** 0  
  
- `DEBUG_COW [0,1]`  
**synopsis:** Show the used and all available cow files after blacklist/whitelist processing.  
**default:** 0  
  
- `DEBUG_FILES [0,1]`  
**synopsis:** Print out the list of files which would be searched, but don't print a fortune.  
**default:** 0  
  
- `DEBUG_OPTIONS [0,1]`  
**synopsis:** Print out the command line arguments that are passed to the fortune command.  
**default:** 0  


Requirements
------------

- cowsay
- fortune

