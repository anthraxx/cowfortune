TARGET=cowfortune
PREFIX?=/usr
BINDIR?=games
CFGDIR=/etc/cowfortune

install:
	mkdir ${CFGDIR}
	cp blacklist ${CFGDIR}/blacklist
	touch ${CFGDIR}/whitelist
	cp ${TARGET} ${PREFIX}/${BINDIR}/${TARGET}
	chmod +x ${PREFIX}/${BINDIR}/${TARGET}

uninstall:
	rm -r ${CFGDIR}
	rm ${PREFIX}/${BINDIR}/${TARGET}

