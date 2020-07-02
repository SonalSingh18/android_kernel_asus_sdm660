#!/bin/bash

# Color
green='\033[0;32m'
echo -e "$green"

# Clone depedencies
git clone --depth=1 https://github.com/stormbreaker-project/stormbreaker-clang.git -b 11.x ~/p/strom
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-10.0.0_r20 ~/p/gcc64
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-10.0.0_r14 ~/p/gcc32

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="rapli"
export KBUILD_BUILD_HOST="raplixwg"
export CROSS_COMPILE=/home/rapli/p/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/rapli/p/gcc32/bin/arm-linux-androideabi-
export KBUILD_COMPILER_STRING=$(/home/rapli/p/strom/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')

mkdir -p out

make O=out ARCH=arm64 etherious_defconfig

make -j$(nproc --all) O=out ARCH=arm64 \
                        CC="/home/rapli/p/strom/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
