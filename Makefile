TARGET=cowfortune
PREFIX?=/usr
BINDIR?=games
CFGDIR=/etc/cowfortune

all:
install:
	mkdir ${CFGDIR}
	cp blacklist ${CFGDIR}/blacklist
	touch ${CFGDIR}/whitelist
	cp ${TARGET} ${PREFIX}/${BINDIR}/${TARGET}
	chmod +x ${PREFIX}/${BINDIR}/${TARGET}

uninstall:
	rm -f ${PREFIX}/${BINDIR}/${TARGET}

purge: uninstall
	rm -rf ${CFGDIR}

.PHONY: all install uninstall purge
