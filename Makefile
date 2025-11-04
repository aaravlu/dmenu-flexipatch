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

stest: stest.o
	$(CC) -o $@ stest.o $(LDFLAGS)

clean:
	rm -f dmenu stest $(OBJ) dmenu-$(VERSION).tar.gz

dist: clean
	mkdir -p dmenu-$(VERSION)
	cp LICENSE Makefile README arg.h config.def.h config.mk dmenu.1\
		drw.h util.h dmenu_path dmenu_run stest.1 $(SRC)\
		dmenu-$(VERSION)
	tar -cf dmenu-$(VERSION).tar dmenu-$(VERSION)
	gzip dmenu-$(VERSION).tar
	rm -rf dmenu-$(VERSION)

install: dmenu
	chmod 777 dmenu
	strip dmenu
	touch -t 202001010000 dmenu
	mv -f dmenu /home/lym/.local/bin

.PHONY: all clean dist install uninstall
