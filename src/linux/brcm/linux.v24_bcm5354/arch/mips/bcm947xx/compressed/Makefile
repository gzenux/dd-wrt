#
# Makefile for Broadcom BCM947XX boards
#
# Copyright 2001-2003, Broadcom Corporation
# All Rights Reserved.
# 
# THIS SOFTWARE IS OFFERED "AS IS", AND BROADCOM GRANTS NO WARRANTIES OF ANY
# KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE. BROADCOM
# SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE.
#
# $Id: Makefile,v 1.2 2005/04/02 12:12:57 wbx Exp $
#

OBJCOPY_ARGS	= -O binary -R .reginfo -R .note -R .comment -R .mdebug -S
SYSTEM		?= $(TOPDIR)/vmlinux

all: vmlinuz

# Don't build dependencies, this may die if $(CC) isn't gcc
dep:

# Create a gzipped version named vmlinuz for compatibility
vmlinuz: piggy
	gzip -c9 $< > $@

piggy: $(SYSTEM)
	$(OBJCOPY) $(OBJCOPY_ARGS) $< $@

mrproper: clean

clean:
	rm -f vmlinuz piggy
