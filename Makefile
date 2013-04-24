TARGET=cowfortune
PREFIX?=/usr
BINDIR?=games

-include Makefile.local
CFGPATH:=/etc/cowfortune

COWSAY:=$(shell which cowsay)
COWTHINK:=$(shell which cowthink)
FORTUNE:=$(shell which fortune)

RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
BOLD=$(shell tput bold)
RST=$(shell tput sgr0)

.PHONY: all install uninstall purge test test-fortune test-cowsay test-path clean

all: $(TARGET)

$(TARGET): test
	@cp $(TARGET).sh $(TARGET)
	@sed "s/COWSAY\=cowsay/COWSAY\=$(shell echo $(COWSAY)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/COWTHINK\=cowthink/COWTHINK\=$(shell echo $(COWTHINK)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/FORTUNE\=fortune/FORTUNE\=$(shell echo $(FORTUNE)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/CFGPATH\=\/etc\/cowfortune/CFGPATH\=$(shell echo $(CFGPATH)|sed 's/\//\\\//g')/" -i $(TARGET)
	@chmod 0755 $(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)created $(TARGET)$(RST)"

test: test-path test-fortune test-cowsay test-cowthink test-cowpath

test-fortune test-cowsay test-cowthink:
	@if test -z "$(shell which $(@:test-%=%))"; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(@:test-%=%) not found$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(shell which $(@:test-%=%))$(RST)"

test-path:
	@if test -z "$(shell echo $(PATH) | tr ':' '\n' | grep -e '^$(PREFIX)/$(BINDIR)$$')"; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(PREFIX)/$(BINDIR) not found in PATH$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)PATH contains $(PREFIX)/$(BINDIR)$(RST)"

DEFCOWPATH=$(shell cowsay -l|head -n1|cut -d\  -f4|cut -d: -f1)
test-cowpath:
	@if [ -z "$(COWPATH)"] && [ ! -d $(DEFCOWPATH) ]; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)neither COWPATH nor $(DEFCOWPATH) found$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found COWPATH or $(DEFCOWPATH)$(RST)"

clean:
	@rm -f ./$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)removed $(TARGET)$(RST)"

install: $(TARGET)
	@mkdir -p $(CFGPATH)
	@cp config $(CFGPATH)/config
	@cp blacklist $(CFGPATH)/blacklist
	@touch $(CFGPATH)/whitelist
	@cp $(TARGET) $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)created $(CFGPATH)$(RST)"
	@chmod 0755 $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)installed $(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

uninstall:
	@rm -f $(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)removed $(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

purge: uninstall
	@rm -rf $(CFGPATH)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)purged $(CFGPATH)$(RST)"

