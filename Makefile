-include Makefile.local

TARGET=cowfortune
PREFIX?=/usr
BINDIR?=bin
DESTDIR?=

CFGPATH:=/etc/cowfortune

COWSAY:=$(shell which cowsay 2>/dev/null)
COWTHINK:=$(shell which cowthink 2>/dev/null)
FORTUNE:=$(shell which fortune 2>/dev/null)
LOLCAT:=$(shell which lolcat 2>/dev/null||echo lolcat)

RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
BOLD=$(shell tput bold)
RST=$(shell tput sgr0)

.PHONY: all install uninstall purge test test-fortune test-cowsay test-cowthink test-path test-lolcat clean

all: $(TARGET)

$(TARGET): test
	@cp $(TARGET).sh $(TARGET)
	@sed "s/COWSAY\=cowsay/COWSAY\=$(shell echo $(COWSAY)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/COWTHINK\=cowthink/COWTHINK\=$(shell echo $(COWTHINK)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/FORTUNE\=fortune/FORTUNE\=$(shell echo $(FORTUNE)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/LOLCAT\=lolcat/LOLCAT\=$(shell echo $(LOLCAT)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/CFGPATH\=\/etc\/cowfortune/CFGPATH\=$(shell echo $(CFGPATH)|sed 's/\//\\\//g')/" -i $(TARGET)
	@sed "s/COWPATH\=\/usr\/share\/cowsay\/cows/COWPATH\=$$\{COWPATH:\-$(shell echo $(DEFCOWPATH)|sed 's/\//\\\//g')}/" -i $(TARGET)
	@chmod 0755 $(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)created $(TARGET)$(RST)"

test: test-path test-fortune test-cowsay test-cowthink test-cowpath test-lolcat

test-fortune test-cowsay test-cowthink:
	@if test -z "$(shell which $(@:test-%=%) 2>/dev/null)"; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(@:test-%=%) not found$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(shell which $(@:test-%=%) 2>/dev/null)$(RST)"

test-lolcat:
	@if test -n "$(shell which $(@:test-%=%) 2>/dev/null)"; then \
		echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found optional $(shell which $(@:test-%=%) 2>/dev/null)$(RST)"; \
	fi

test-path:
	@if test -z "$(shell echo $(PATH) | tr ':' '\n' | grep -e '^$(PREFIX)/$(BINDIR)$$')"; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(PREFIX)/$(BINDIR) not found in PATH$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)PATH contains $(PREFIX)/$(BINDIR)$(RST)"

DEFCOWPATH=$(shell $(COWSAY) -l|head -n1|cut -d\  -f4|cut -d: -f1)
test-cowpath:
	@if [ -z "$(COWPATH)"] && [ ! -d $(DEFCOWPATH) ]; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)neither COWPATH nor $(DEFCOWPATH) found$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found COWPATH or $(DEFCOWPATH)$(RST)"

clean:
	@rm -f ./$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)removed $(TARGET)$(RST)"

install:
	@if test ! -f $(TARGET); then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(TARGET) not found, run make$(RST)"; \
		exit 1; \
	fi
	@if test -z "$(shell echo $(PATH) | tr ':' '\n' | grep -e '^$(PREFIX)/$(BINDIR)$$')"; then \
		echo "$(BOLD)$(YELLOW)[-] WARNING: $(RST)$(BOLD)$(PREFIX)/$(BINDIR) not found in PATH$(RST)"; \
		echo "    $(BOLD)^^^$(RST) override $(BOLD)PREFIX$(RST) or $(BOLD)BINDIR$(RST) to make it globally available$(RST)"; \
	fi
	@mkdir -p $(DESTDIR)$(CFGPATH)
	@mkdir -p $(DESTDIR)$(PREFIX)/$(BINDIR)
	@cp config $(DESTDIR)$(CFGPATH)/config
	@cp blacklist $(DESTDIR)$(CFGPATH)/blacklist
	@touch $(DESTDIR)$(CFGPATH)/whitelist
	@chmod 0644 $(DESTDIR)$(CFGPATH)/config $(DESTDIR)$(CFGPATH)/blacklist $(DESTDIR)$(CFGPATH)/whitelist
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)created $(DESTDIR)$(CFGPATH)$(RST)"
	@cp $(TARGET) $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)
	@chmod 0755 $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)installed $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

uninstall:
	@rm -f $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)removed $(DESTDIR)$(PREFIX)/$(BINDIR)/$(TARGET)$(RST)"

purge: uninstall
	@rm -rf $(DESTDIR)$(CFGPATH)
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)purged $(DESTDIR)$(CFGPATH)$(RST)"

