
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 5c3cae6ddc96b8645dfa6f6bc4ddbba08aae8789
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/ldd3.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

define LDD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull
endef

define LDD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra && \
    for f in $(@D)/*.ko; do \
        $(INSTALL) -m 0644 $$f $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/; \
    done

    $(INSTALL) -m 0644 $(@D)/module_load $(TARGET_DIR)/usr/bin/ 
    $(INSTALL) -m 0644 $(@D)/module_unload $(TARGET_DIR)/usr/bin/;
    $(INSTALL) -m 0644 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin/;
    $(INSTALL) -m 0644 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin/;
endef

$(eval $(generic-package))
