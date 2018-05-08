netconf: iptables
ifeq ($(CONFIG_NETCONF),y)
	make -C netconf
endif