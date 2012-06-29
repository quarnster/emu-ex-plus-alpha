

mkdir build-android
cd build-android
cmake -DCMAKE_INSTALL_PREFIX=~/android/android-ndk-r7-crystax-4/toolchains/clang/  -DLLVM_TARGETS_TO_BUILD=ARM ..
make -j4 install
cd ~/android/android-ndk-r7-crystax-4/toolchains/clang/lib/clang/3.1
mv include/ include.old
ln -s ../../../arm-linux-androideabi-4.6.3/prebuilt/darwin-x86/lib/gcc/arm-linux-androideabi/4.6.3/include/ include

ln -s gcc/bin/arm-linux-androideabi-ld arm-linux-androideabi-ld



export ANDROID_NDK_PATH=~/android/android-ndk-r7-crystax-4
export IMAGINE_PATH=$(pwd)/../imagine
export PATH=$PATH:$ANDROID_NDK_PATH/toolchains/clang-android/bin

cd NES.emu
make android_antTarget=debug config_android_noArmv6=1 android-apk
