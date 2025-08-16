
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_SOCKET_VERSION = 1d3f4ad1097329044b9724c5329b352c1b5eb83b
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_SOCKET_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-mr16048.git
AESD_SOCKET_SITE_METHOD = git
AESD_SOCKET_GIT_SUBMODULES = YES

define AESD_SOCKET_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_SOCKET_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
