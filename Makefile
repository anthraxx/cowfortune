TARGET=cowfortune
PREFIX?=/usr
BINDIR?=games

-include Makefile.local
CFGDIR=/etc/cowfortune

RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
WHITE=$(shell tput setaf 7)
BOLD=$(shell tput bold)
RST=$(shell tput sgr0)
.PHONY: all install uninstall purge test test-fortune test-cowsay test-path

all: test

test: test-path test-fortune test-cowsay test-cowthink

test-fortune test-cowsay test-cowthink:
	@if test -z "$(shell which $(@:test-%=%))"; then \
		echo "$(BOLD)$(RED)[-] $(WHITE)$(@:test-%=%) not found$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)found $(shell which $(@:test-%=%))$(RST)"

test-path:
	@if test -z "$(shell echo $(PATH) | tr ':' '\n' | grep -e '^$(PREFIX)/$(BINDIR)$$')"; then \
		echo "$(BOLD)$(RED)[-] $(WHITE)$(PREFIX)/$(BINDIR) not found in PATH$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)PATH contains $(PREFIX)/$(BINDIR)$(RST)"

install:
	@mkdir -p $(CFGDIR)
	@cp config $(CFGDIR)/config
	@cp blacklist $(CFGDIR)/blacklist
	@touch $(CFGDIR)/whitelist
	@cp $(TARGET) $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)created $(CFGDIR)$(RST)"
	@chmod +x $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)installed $(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

uninstall:
	@rm -f $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)removed $(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

purge: uninstall
	@rm -rf $(CFGDIR)
	@echo "$(BOLD)$(GREEN)[+] $(WHITE)purged $(CFGDIR)$(RST)"

