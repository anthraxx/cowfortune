cowfortune
==========

Yet another cowfortune script (inspired by mint-fortune) that excludes
too line hungry beasts for less terminal flooding.

To specify the cows in question, you can provide per-user whitelist or
blacklist files that will be respected.


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


The default installation location is /usr/games and could be overriden by
setting the PREFIX and BINDIR env var before running make or by providing
those inside Makefile.local.


Configuration
-------------

All available cows will be read from either COWPATH or /usr/share/cowsay/cows.

You can configure a global whitelist and blacklist:
/etc/cowfortune/whitelist
/etc/cowfortune/blacklist

Optional per-user configuration:
~/.cowfortune/whitelist
~/.cowfortune/blacklist


If you don't want to use the whitelist, dont create that file or simply
keep it at zero length.


Requirements
------------

- cowsay
- fortune


