src = $(TOP)/zfs/icp
obj = $(TOP)/zfs/icp

MODULE := icp

EXTRA_CFLAGS = $(ZFS_MODULE_CFLAGS)  -std=gnu99 -Wno-declaration-after-statement -Wno-unused-but-set-variable  -DHAVE_SPL -D_KERNEL -DTEXT_DOMAIN=\"zfs-linux-kernel\" -DNDEBUG 
EXTRA_AFLAGS = $(ZFS_MODULE_CFLAGS)  -std=gnu99 -Wno-declaration-after-statement -Wno-unused-but-set-variable  -DHAVE_SPL -D_KERNEL -DTEXT_DOMAIN=\"zfs-linux-kernel\" -DNDEBUG 

obj-$(CONFIG_ZFS) := $(MODULE).o

ccflags-y += -I$(src)/include
asflags-y += -I$(src)/include
asflags-y += $(ZFS_MODULE_CFLAGS)

$(MODULE)-objs += illumos-crypto.o
$(MODULE)-objs += api/kcf_cipher.o
$(MODULE)-objs += api/kcf_digest.o
$(MODULE)-objs += api/kcf_mac.o
$(MODULE)-objs += api/kcf_miscapi.o
$(MODULE)-objs += api/kcf_ctxops.o
$(MODULE)-objs += core/kcf_callprov.o
$(MODULE)-objs += core/kcf_prov_tabs.o
$(MODULE)-objs += core/kcf_sched.o
$(MODULE)-objs += core/kcf_mech_tabs.o
$(MODULE)-objs += core/kcf_prov_lib.o
$(MODULE)-objs += spi/kcf_spi.o
$(MODULE)-objs += io/aes.o
$(MODULE)-objs += io/edonr_mod.o
$(MODULE)-objs += io/sha1_mod.o
$(MODULE)-objs += io/sha2_mod.o
$(MODULE)-objs += io/skein_mod.o
$(MODULE)-objs += os/modhash.o
$(MODULE)-objs += os/modconf.o
$(MODULE)-objs += algs/modes/cbc.o
$(MODULE)-objs += algs/modes/ccm.o
$(MODULE)-objs += algs/modes/ctr.o
$(MODULE)-objs += algs/modes/ecb.o
$(MODULE)-objs += algs/modes/gcm.o
$(MODULE)-objs += algs/modes/modes.o
$(MODULE)-objs += algs/aes/aes_impl.o
$(MODULE)-objs += algs/aes/aes_modes.o
$(MODULE)-objs += algs/edonr/edonr.o
$(MODULE)-objs += algs/sha1/sha1.o
$(MODULE)-objs += algs/sha2/sha2.o
$(MODULE)-objs += algs/sha1/sha1.o
$(MODULE)-objs += algs/skein/skein.o
$(MODULE)-objs += algs/skein/skein_block.o
$(MODULE)-objs += algs/skein/skein_iv.o
$(MODULE)-objs += $(ASM_SOURCES)


$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/aes/aeskey.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/aes/aes_amd64.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/aes/aes_intel.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/modes/gcm_intel.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/sha1/sha1-x86_64.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/sha2/sha256_impl.o
$(MODULE)-$(CONFIG_X86_64) += asm-x86_64/sha2/sha512_impl.o

ICP_DIRS = \
	api \
	core \
	spi \
	io \
	os \
	algs \
	algs/aes \
	algs/edonr \
	algs/modes \
	algs/sha1 \
	algs/sha2 \
	algs/skein \
	asm-x86_64 \
	asm-x86_64/aes \
	asm-x86_64/modes \
	asm-x86_64/sha1 \
	asm-x86_64/sha2 \
	asm-i386 \
	asm-generic

all:
	mkdir -p $(ICP_DIRS)
