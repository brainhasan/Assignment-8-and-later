LDD_VERSION = '55b3b5bd452068b7c125d204be5a3641e34c201b'
LDD_SITE = 'git@github.com:aquini/aesd-assignment-7-aquini.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = scull misc-modules
$(eval $(kernel-module))

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/init $(TARGET_DIR)/etc/init.d/S98lddmodules
endef
$(eval $(generic-package))
