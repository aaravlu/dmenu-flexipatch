# dmenu - dynamic menu
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dmenu.c stest.c util.c
OBJ = $(SRC:.c=.o)

all: dmenu stest

.c.o:
	$(CC) -c $(CFLAGS) $<

config.h:
	cp config.def.h $@

patches.h:
	cp patches.def.h $@

$(OBJ): arg.h config.h config.mk drw.h patches.h

dmenu: dmenu.o drw.o util.o
	$(CC) -o $@ dmenu.o drw.o util.o $(LDFLAGS)

install: dmenu
	chmod 777 dmenu
	strip dmenu
	touch -t 202001010000 dmenu
	chmod 755 dmenu
	mv -f dmenu $(DESTDIR)$(PREFIX)/bin
	rm -rf dmenu-$(VERSION) stest $(OBJ) dmenu-$(VERSION).tar.gz

.PHONY: all clean dist install uninstall
