ifndef inc_pkg_stdcxx_headers
inc_pkg_stdcxx_headers := 1

ifeq ($(ENV), android)

ifeq ($(android_stdcxx), gnu)
 CPPFLAGS += -I$(ANDROID_NDK_PATH)/sources/cxx-stl/gnu-libstdc++/libs/$(android_abi)/include \
  -I$(ANDROID_NDK_PATH)/sources/cxx-stl/gnu-libstdc++/include
else
 CPPFLAGS += -I$(ANDROID_NDK_PATH)/sources/cxx-stl/stlport/stlport
endif

endif

endif