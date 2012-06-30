ENV := android

android_ndkSysroot := $(ANDROID_NDK_PATH)/platforms/android-$(android_minSDK)/arch-$(android_ndkArch)

android_hasSDK9 := $(shell expr $(android_minSDK) \>= 9)

ifndef targetDir
 ifdef O_RELEASE
  targetDir := target/android-$(android_minSDK)/libs-release/$(android_abi)
 else
  targetDir := target/android-$(android_minSDK)/libs-debug/$(android_abi)
 endif
endif

ifeq ($(android_hasSDK9), 1)
 android_soName := main
else
 android_soName := imagine
endif

#CPPFLAGS += -isystem $(ANDROID_NDK_PATH)/sources/cxx-stl/gnu-libstdc++/libs/armeabi-v7a/include
ifndef android_stdcxx
 ifdef cxxExceptions
  android_stdcxx := gnu
 else
  android_stdcxx := stlport
 endif
endif

ifeq ($(android_stdcxx), gnu)
 android_stdcxxLib := $(ANDROID_NDK_PATH)/sources/cxx-stl/gnu-libstdc++/libs/$(android_abi)/libgnustl_static.a
else
 android_stdcxxLib := $(ANDROID_NDK_PATH)/sources/cxx-stl/stlport/libs/$(android_abi)/4.6.3/libstlport_static.a -lstdc++
endif

include $(currPath)/gcc.mk

tcpath = $(ANDROID_NDK_PATH)/toolchains/arm-linux-androideabi-4.6.3/prebuilt/darwin-x86/lib/gcc/arm-linux-androideabi/4.6.3/armv7-a

#BASE_CXXFLAGS += -fno-use-cxa-atexit
# -fshort-wchar -funwind-tables -fstack-protector -finline-limit=64 -fno-strict-aliasing
COMPILE_FLAGS += -fsingle-precision-constant -ffunction-sections -fdata-sections \
-Wa,--noexecstack $(android_cpuFlags) -ggdb -O0
ASMFLAGS += $(android_cpuFlags)
LDFLAGS += $(android_cpuFlags) -ggdb -O0
WARNINGS_CFLAGS += -Wno-psabi -Wdouble-promotion
LDFLAGS += -Wl,--no-undefined -Wl,-z,noexecstack -Wl,-soname,lib$(android_soName).so -shared #-Wl,-rpath-link=$(android_ndkSysroot)/usr/lib
LDLIBS += $(android_ndkSysroot)/usr/lib/crtbegin_so.o -L$(android_ndkSysroot)/usr/lib -lcrystax -lc -lm $(tcpath)/libgcc_eh.a $(tcpath)/libgcc.a $(android_ndkSysroot)/usr/lib/crtend_so.o  #-lgcc


NORMAL_WARNINGS_CFLAGS = -Wall -Wextra -Wno-comment -Wno-missing-field-initializers -Wno-unused-parameter -Wno-invalid-constexpr -Wno-attributes -Wno-c++11-narrowing -Wno-unknown-warning-option
CPPFLAGS += -DANDROID -fPIC --sysroot=$(android_ndkSysroot) -I$(ANDROID_NDK_PATH)/sources/crystax/include -ggdb -O0

#CPPFLAGS += -isystem $(ANDROID_NDK_PATH)/sources/cxx-stl/gnu-libstdc++/include

LDFLAGS += -Wl,-g,--gc-sections,--sort-common
OPTIMIZE_LDFLAGS +=
noDoubleFloat=1
