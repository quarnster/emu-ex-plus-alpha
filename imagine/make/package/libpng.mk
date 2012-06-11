ifndef inc_pkg_libpng
inc_pkg_libpng := 1

ifdef package_libpng_externalPath
	CPPFLAGS +=  -I$(package_libpng_externalPath)/include
	LDLIBS += -L$(package_libpng_externalPath)/lib
	
	ifdef package_zlib_externalPath
		CPPFLAGS +=  -I$(package_zlib_externalPath)/include
		LDLIBS += -L$(package_zlib_externalPath)/lib
	endif
	
	LDLIBS +=  -lpng14 -lz
else
	ifeq ($(ENV), webos)
		CPPFLAGS +=  -I$(WEBOS_PDK_PATH)/include/libpng12
		LDLIBS +=  -lpng12 -lz $(webos_libm)
	else ifneq ($(ENV), linux)
		CPPFLAGS += $(shell PKG_CONFIG_PATH=$(system_externalSysroot)/lib/pkgconfig PKG_CONFIG_SYSTEM_INCLUDE_PATH=$(system_externalSysroot)/include pkg-config libpng --cflags --static --define-variable=prefix=$(system_externalSysroot))
		LDLIBS += $(shell PKG_CONFIG_PATH=$(system_externalSysroot)/lib/pkgconfig PKG_CONFIG_SYSTEM_LIBRARY_PATH=$(system_externalSysroot)/lib pkg-config libpng --libs --static --define-variable=prefix=$(system_externalSysroot))
	else
		CPPFLAGS += $(shell pkg-config libpng --cflags)
		LDLIBS += $(shell pkg-config libpng --libs)
	endif
endif

endif