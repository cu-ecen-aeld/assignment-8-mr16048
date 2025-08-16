
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_CHARDRIVER_VERSION =  6f20e5814dd6ab887e7d310da8c701aae80775a9 
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_CHARDRIVER_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-mr16048.git
AESD_CHARDRIVER_SITE_METHOD = git
AESD_CHARDRIVER_GIT_SUBMODULES = YES

MAKE_ENV += KERNELDIR=$(LINUX_DIR)

DRIVER_DIR="$(@D)/aesd-char-driver"
BIN_DIR :="$(TARGET_DIR)/usr/bin"
OBJ_DIR :="$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra"

define AESD_CHARDRIVER_BUILD_CMDS
	$(MAKE) -C $(DRIVER_DIR) KERNELDIR=$(LINUX_DIR) ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" 
endef

define AESD_CHARDRIVER_INSTALL_TARGET_CMDS

    @echo ">>> Installing aesd_chardriver from $(@D)"
    $(INSTALL) -D -m 0755 $(DRIVER_DIR)/aesdchar_load $(BIN_DIR)/aesdchar_load
    $(INSTALL) -D -m 0644 $(DRIVER_DIR)/aesdchar.ko $(OBJ_DIR)/aesdchar.ko
endef

$(eval $(generic-package))
