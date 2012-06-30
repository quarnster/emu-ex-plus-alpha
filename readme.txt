This is a mirror of http://code.google.com/p/emu-ex-plus-alpha/ with changes to make (some of) the projects compile on my computer.

The sources use some C11 features so need either gcc-4.7 or clang 3.1 to compile. Clang was very easy and straight forward to setup so that's what I used. Mostly based on https://wiki.mozilla.org/Android/Clang.


Some very rough notes (that are at this point in time no longer 100% valid so beware in case you try to follow them).


mkdir build-android
cd build-android
cmake -DCMAKE_INSTALL_PREFIX=~/android/android-ndk-r7-crystax-4/toolchains/clang/  -DLLVM_TARGETS_TO_BUILD=ARM ..
make -j4 install
cd ~/android/android-ndk-r7-crystax-4/toolchains/clang/lib/clang/3.1
mv include/ include.old
ln -s ../../../arm-linux-androideabi-4.6.3/prebuilt/darwin-x86/lib/gcc/arm-linux-androideabi/4.6.3/include/ include

ln -s gcc/bin/arm-linux-androideabi-ld arm-linux-androideabi-ld



export ANDROID_NDK_PATH=~/android/android-ndk-r7-crystax-4
export IMAGINE_PATH=$(pwd)/imagine
export PATH=$PATH:$ANDROID_NDK_PATH/toolchains/clang-android/bin
export CHOST=arm-linux-androideabi

cd imagine/bundle/all/src/freetype && make -f android-armv7.mk install
cd ../libpng && make -f android-armv7.mk install
cd ../unzip && make -f android-armv7.mk


cd NES.emu
make android_antTarget=debug config_android_noArmv6=1 android-apk

