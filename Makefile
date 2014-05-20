CC     = clang
PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
CFLAGS = -g -std=c99 -Os -I${PREFIX}/include -Wall
LDFLAGS = -L${PREFIX}/lib -lxcb -lxcb-xinerama -lxcb-randr

EXEC = bar
SRCS = bar.c
OBJS = ${SRCS:.c=.o}

all: ${EXEC}

.c.o:
	${CC} ${CFLAGS} -o $@ -c $<

${EXEC}: ${OBJS}
	${CC} -o ${EXEC} ${OBJS} ${LDFLAGS}

debug: ${EXEC}
debug: CC += ${CFDEBUG}

clean:
	rm -f ./*.o ./*.1
	rm -f ./${EXEC}

install: bar 
	install -m 755 bar ${DESTDIR}${BINDIR}/bar
	#install -m 644 bar.1 ${DESTDIR}${PREFIX}/share/man/man1/bar.1

uninstall:
	rm -f ${DESTDIR}${BINDIR}/bar
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/bar.1

.PHONY: all debug clean install
