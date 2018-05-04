nocat-configure:
	cd glib && rm -f ./config.cache && \
	CC="$(CC)" CFLAGS="$(COPTS) $(MIPS16_OPT) -std=gnu89" \
	glib_cv_prog_cc_ansi_proto=no \
	ac_cv_sizeof_char=1 \
	ac_cv_sizeof_short=2 \
	ac_cv_sizeof_long=4 \
	ac_cv_sizeof_void_p=4 \
	ac_cv_sizeof_int=4 \
	ac_cv_sizeof_long_long=8 \
	glib_cv_has__inline=yes \
	glib_cv_has__inline__=yes \
	glib_cv_hasinline=yes \
	glib_cv_sane_realloc=yes \
	glib_cv_va_copy=no \
	glib_cv___va_copy=yes \
	glib_cv_va_val_copy=yes \
	glib_cv_rtldglobal_broken=no \
	glib_cv_uscore=no \
	ac_cv_func_getpwuid_r=yes \
	glib_cv_func_pthread_mutex_trylock_posix=yes \
	glib_cv_func_pthread_cond_timedwait_posix=yes \
	glib_cv_sizeof_gmutex=24 \
	glib_cv_byte_contents_gmutex="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" \
	./configure --prefix=$(TOP)/glib-1.2.10-install --cache-file=config.cache --host=$(ARCH)-linux
	cd nocat && ./configure --with-remote-splash CC="$(CC)" CFLAGS="$(COPTS) $(MIPS16_OPT) -std=gnu89 -DNEED_PRINTF -I../libghttp " --prefix=/tmp/ --with-glib-prefix=$(TOP)/glib-1.2.10-install --disable-glibtest --host=$(ARCH)-linux

nocat:
	make  -C glib
	cp $(TOP)/glib/.libs/*.a $(TOP)/glib-1.2.10-install/lib
	cp $(TOP)/glib/gmodule/.libs/*.a $(TOP)/glib-1.2.10-install/lib
	cp $(TOP)/glib/gthread/.libs/*.a $(TOP)/glib-1.2.10-install/lib
	make  -C nocat

nocat-clean:
	make  -C glib clean
	make  -C nocat clean
	

nocat-install:
	install -D nocat/src/splashd $(INSTALLDIR)/nocat/usr/sbin/splashd
	$(STRIP) $(INSTALLDIR)/nocat/usr/sbin/splashd
	mkdir -p ${INSTALLDIR}/nocat/etc
	ln -sf /tmp/etc/nocat.conf $(INSTALLDIR)/nocat/etc/nocat.conf
	mkdir -p $(INSTALLDIR)/nocat/usr/libexec
	cp -r nocat/libexec/iptables $(INSTALLDIR)/nocat/usr/libexec/nocat
ifeq ($(CONFIG_RAMSKOV),y)
	install -D nocat/config_redirect/nocat.webhotspot $(INSTALLDIR)/nocat/etc/config/nocat.webhotspot
	install -D nocat/config_redirect/nocat.nvramconfig $(INSTALLDIR)/nocat/etc/config/nocat.nvramconfig
	install -D nocat/config_redirect/nocat.startup $(INSTALLDIR)/nocat/etc/config/nocat.startup
	install -D nocat/config_redirect/nocat.header $(INSTALLDIR)/nocat/etc/config/nocat.header
	install -D nocat/config_redirect/nocat.footer $(INSTALLDIR)/nocat/etc/config/nocat.footer
else
	install -D nocat/config/nocat.webhotspot $(INSTALLDIR)/nocat/etc/config/nocat.webhotspot
	install -D nocat/config/nocat.nvramconfig $(INSTALLDIR)/nocat/etc/config/nocat.nvramconfig
	install -D nocat/config/nocat.startup $(INSTALLDIR)/nocat/etc/config/nocat.startup
endif
