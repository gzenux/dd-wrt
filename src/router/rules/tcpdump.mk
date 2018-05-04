ifeq ($(CONFIG_IPV6),y)
export TCPDUMPEXTRA:=--enable-ipv6
endif



tcpdump-configure: libpcap
	cd tcpdump && ./configure --host=$(ARCH)-linux --enable-shared --libdir=/lib --disable-static --without-crypto $(TCPDUMPEXTRA) CC="$(CC)" ac_cv_linux_vers=2 ac_cv_ssleay_path=no td_cv_buggygetaddrinfo=no CPPFLAGS="-I../libpcap $(COPTS) $(MIPS16_OPT) -D_GNU_SOURCE -DNEED_PRINTF" CFLAGS="-I../libpcap $(COPTS) $(MIPS16_OPT) -DNEED_PRINTF -DHAVE_BPF_DUMP" LDFLAGS="-L../libpcap"

tcpdump/Makefile: tcpdump-configure

tcpdump: tcpdump/Makefile
	make -j 4 -C tcpdump


tcpdump-install:
	install -D tcpdump/tcpdump $(INSTALLDIR)/tcpdump/usr/sbin/tcpdump

