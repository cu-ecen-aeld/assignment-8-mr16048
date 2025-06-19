
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 2a3f0e3c77a6cedfbd446c3be134b2835591d512
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-mr16048.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

MAKE_ENV += KERNELDIR=$(LINUX_DIR)


BIN_DIR :="$(TARGET_DIR)/usr/bin"
OBJ_DIR :="$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra"

define LDD_BUILD_CMDS

	$(MAKE) -C $(@D)/misc-modules KERNELDIR=$(LINUX_DIR) ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" 
    $(MAKE) -C $(@D)/scull KERNELDIR=$(LINUX_DIR) ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)"

endef

define LDD_INSTALL_TARGET_CMDS
	# mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra && \
    # for f in $(@D)/*.ko; do \
    #     $(INSTALL) -m 0644 $$f $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/; \
    # done

    $(INSTALL) -D -m 0755 $(@D)/misc-modules/module_load $(BIN_DIR)/module_load
    $(INSTALL) -D -m 0755 $(@D)/misc-modules/module_unload $(BIN_DIR)/module_unload
    $(INSTALL) -D -m 0755 $(@D)/scull/scull_load $(BIN_DIR)/scull_load
    $(INSTALL) -D -m 0755 $(@D)/scull/scull_unload $(BIN_DIR)/scull_unload
    $(INSTALL) -D -m 0644 $(@D)/scull/scull.ko $(OBJ_DIR)/scull.ko
    $(INSTALL) -D -m 0644 $(@D)/misc-modules/faulty.ko $(OBJ_DIR)/faulty.ko
    $(INSTALL) -D -m 0644 $(@D)/misc-modules/hello.ko $(OBJ_DIR)/hello.ko
endef

$(eval $(generic-package))
