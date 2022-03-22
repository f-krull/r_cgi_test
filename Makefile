BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PORT ?= 8080

all: 3rdparty

run: 3rdparty
	DOCROOT=${BASEDIR}/www/ PORT=$(PORT) \
		${BASEDIR}/3rdparty/lighttpd/sbin/lighttpd -D -f ${BASEDIR}/lighttpd.conf

.PHONY: prepare_offline
prepare_offline:
	$(MAKE) -C 3rdparty download

# ----- 3rdparty

.PHONY: 3rdparty
3rdparty: $(websrcs)
	$(MAKE) -C 3rdparty

.PHONY: distclean
distclean:
	$(MAKE) -C 3rdparty clean
	$(RM) -r www/3rdparty/
