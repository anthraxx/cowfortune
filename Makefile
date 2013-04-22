TARGET=cowfortune
PREFIX?=/usr
BINDIR?=games

-include Makefile.local
CFGDIR=/etc/cowfortune

.PHONY: all install uninstall purge test test-fortune test-cowsay test-path

all: test

test: test-path test-fortune test-cowsay test-cowthink test-awk

test-fortune test-cowsay test-cowthink test-awk:
	@if test -z "$(shell which $(@:test-%=%))"; then \
		echo "\033[1;31m[-] \033[1;37m$(@:test-%=%) not found\033[0;0m"; \
		exit 1; \
	fi
	@echo "\033[1;32m[+] \033[1;37mfound $(shell which $(@:test-%=%))\033[0;0m"

test-path:
	@if test -z $(shell echo $(PATH)|grep $(PREFIX)/$(BINDIR)); then \
		echo "\033[1;31m[-] \033[1;37m$(PREFIX)/$(BINDIR) not found in PATH\033[0;0m"; \
		exit 1; \
	fi
	@echo "\033[1;32m[+] \033[1;37mPATH contains $(PREFIX)/$(BINDIR)\033[0;0m"

install:
	@mkdir -p $(CFGDIR)
	@cp config $(CFGDIR)/config
	@cp blacklist $(CFGDIR)/blacklist
	@touch $(CFGDIR)/whitelist
	@cp $(TARGET) $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "\033[1;32m[+] \033[1;37mcreated $(CFGDIR)\033[0;0m"
	@chmod +x $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "\033[1;32m[+] \033[1;37minstalled $(PREFIX)/$(BINDIR)/$(TARGET)\033[0;0m"

uninstall:
	@rm -f $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "\033[1;32m[+] \033[1;37mremoved $(PREFIX)/$(BINDIR)/$(TARGET)\033[0;0m"

purge: uninstall
	@rm -rf $(CFGDIR)
	@echo "\033[1;32m[+] \033[1;37mpurged $(CFGDIR)\033[0;0m"

