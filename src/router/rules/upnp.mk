upnp-clean:
ifeq ($(CONFIG_NETCONF),y)
	make -C upnp clean
endif

upnp: nvram netconf
ifeq ($(CONFIG_NETCONF),y)
	make -C upnp
endif

upnp-install:
ifeq ($(CONFIG_NETCONF),y)
	make -C upnp install
endif

