#!/bin/sh
# Written  by turkeyzhu<turkeyzhu@gmail.com>
# Builds the mp4v2 library for Android
export PATH="${NDK_ROOT}/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/:${PATH}"
SYS_ROOT="${NDK_ROOT}/platforms/android-14/arch-arm"
PREF="arm-linux-androideabi-"
OUT_DIR="`pwd`/android-build"
C_FLAGS="-lstdc++ -lsupc++ \
        -I${NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/4.6/include \
        -I${NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/4.6/libs/armeabi/include \
        -L${NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/4.6/libs/armeabi"
        
set e
export CC="${PREF}gcc  --sysroot=${SYS_ROOT}"
export CXX="${PREF}g++  --sysroot=${SYS_ROOT}"
export LD="${PREF}ld  --sysroot=${SYS_ROOT}"
export CPP="${PREF}cpp  --sysroot=${SYS_ROOT}"
export AS="${PREF}as"
export OBJCOPY="${PREF}objcopy"
export OBJDUMP="${PREF}objdump"
export STRIP="${PREF}strip"
export RANLIB="${PREF}ranlib"
export CCLD="${PREF}gcc  --sysroot=${SYS_ROOT}"
export AR="${PREF}ar"

cmake	\
		-DCMAKE_SYSTEM_NAME="Generic" \
		-DCMAKE_CXX_FLAGS="${C_FLAGS}" \
		-DCMAKE_FIND_ROOT_PATH="${SYS_ROOT}" \
		
make && \
make install

cd ${OUT_DIR}/lib && \
${AR} -x libmp4v2.a && \
${CXX} ${C_FLAGS} -shared -Wl,-soname,libmp4v2.a -o libmp4v2_hs_t.so  *.obj && \
rm *.obj