##############################################################
#
# AESDCHAR
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 'fbca140171bcbd536a1ae3d2ef032edbfd8c5f03'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:brainhasan/assignment3_2.git'

AESDCHAR_MODULE_SUBDIRS = aesd-char-driver

define AESDCHAR_BUILD_CMDS
    # Build aesdsocket
    $(TARGET_CC) $(TARGET_CFLAGS) -DUSE_AESD_CHAR_DEVICE=1 -o $(@D)/server/aesdsocket $(@D)/server/aesdsocket.c -lpthread
endef

define AESDCHAR_INSTALL_TARGET_CMDS
    
    # Install driver load/unload scripts
    $(INSTALL) -D -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/aesdchar_load
    $(INSTALL) -D -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/aesdchar_unload
    
    # Fix paths in load script to use installed module location
    sed -i 's|\./${module}.ko|/lib/modules/$$(uname -r)/extra/${module}.ko|g' $(TARGET_DIR)/usr/bin/aesdchar_load
    sed -i 's|insmod ./$module.ko|insmod /lib/modules/$$(uname -r)/extra/$module.ko|g' $(TARGET_DIR)/usr/bin/aesdchar_load
    
    # Install built aesdsocket binary and start-stop script
    $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
    $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/usr/bin/aesdsocket-start-stop
endef

$(eval $(kernel-module))
$(eval $(generic-package))
