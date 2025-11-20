LDD_VERSION = 'fbca140171bcbd536a1653d2ef032edbfd8c5f03'
LDD_SITE = 'git@github.com:brainhasan/aesd-assignment-7.git'
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
