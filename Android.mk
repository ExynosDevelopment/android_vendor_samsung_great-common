LOCAL_PATH := $(call my-dir)

ifneq ($(filter exynos8895, $(TARGET_SOC)),)

include $(CLEAR_VARS)
LOCAL_MODULE := libGLES_mali
LOCAL_MODULE_OWNER := samsung
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/egl/libGLES_mali.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/egl/libGLES_mali.so
LOCAL_MULTILIB := both
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_PATH_32 := $(TARGET_2ND_ARCH_VAR_PREFIX)(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/egl
LOCAL_MODULE_PATH_64 := $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/egl
include $(BUILD_PREBUILT)

SYMLINKS := $(TARGET_OUT)/vendor
$(SYMLINKS):
	@echo "Symlink: vulkan.exynos5.so"
	@mkdir -p $@/lib/hw
	@mkdir -p $@/lib64/hw
	$(hide) ln -sf ../egl/libGLES_mali.so $@/lib/hw/vulkan.exynos5.so
	$(hide) ln -sf ../egl/libGLES_mali.so $@/lib64/hw/vulkan.exynos5.so
	@echo "Symlink: libOpenCL.so.1.1"
	$(hide) ln -sf egl/libGLES_mali.so $@/lib/libOpenCL.so.1.1
	$(hide) ln -sf egl/libGLES_mali.so $@/lib64/libOpenCL.so.1.1

ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(SYMLINKS)

endif
