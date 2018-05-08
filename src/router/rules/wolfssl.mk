wolfssl-configure:
	cd wolfssl && ./configure --prefix=/usr --host=$(ARCH)-linux --enable-opensslextra --disable-shared --enable-static -disable-errorstrings --disable-oldtls --disable-poly1305 --disable-chacha --enable-ecc --disable-sslv3 CFLAGS="$(COPTS) $(MIPS16_OPT) -ffunction-sections -fdata-sections -Wl,--gc-sections"

wolfssl/Makefile: wolfssl-configure

wolfssl: wolfssl/Makefile
	$(MAKE) -j 4 -C wolfssl

wolfssl-clean:
	if test -e "wolfssl/Makefile"; then make -C wolfssl clean; fi
	@true

wolfssl-install:
