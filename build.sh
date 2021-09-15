
<<<<<<< HEAD
export KERNEL_PATH=$PWD
export ANYKERNEL_PATH=~/Anykernel3
export CLANG_PATH=~/proton-clang
export PATH=${CLANG_PATH}/bin:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export ARCH=arm64
export SUBARCH=arm64
=======
#!/bin/bash
#cd ~/QK-MIUI-Cepheus-rebase/ #change this to fit your downloaded kernelsource folder
>>>>>>> 67c48e6cc9f16a3b38ee7028022469ccf51b9af7


<<<<<<< HEAD
echo "=========================Clean========================="
rm -rf $KERNEL_PATH/out/ *.zip
make mrproper && git reset --hard HEAD

echo "=========================Build========================="
make O=out CC="ccache clang" CXX="ccache clang++" CROSS_COMPILE=$CLANG_PATH/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=$CLANG_PATH/bin/arm-linux-gnueabi- LD=ld.lld cepheus_defconfig
make O=out CC="ccache clang" CXX="ccache clang++" CROSS_COMPILE=$CLANG_PATH/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=$CLANG_PATH/bin/arm-linux-gnueabi- LD=ld.lld 2>&1 | tee kernel.log

if [ ! -e $KERNEL_PATH/out/arch/arm64/boot/Image.gz-dtb ]; then
    echo "=======================FAILED!!!======================="
    rm -rf $ANYKERNEL_PATH $KERNEL_PATH/out/
    make mrproper>/dev/null 2>&1
    git reset --hard HEAD 2>&1
    exit -1>/dev/null 2>&1
fi

echo "=========================Patch========================="
rm -r $ANYKERNEL_PATH/modules $ANYKERNEL_PATH/patch $ANYKERNEL_PATH/ramdisk
cp $KERNEL_PATH/anykernel.sh $ANYKERNEL_PATH/
cp $KERNEL_PATH/out/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_PATH/
cd $ANYKERNEL_PATH
zip -r $KERNEL_NAME *
mv $KERNEL_NAME.zip $KERNEL_PATH/out/
cd $KERNEL_PATH
#rm -rf $CLANG_PATH
rm -rf $ANYKERNEL_PATH
echo $KERNEL_NAME.zip
=======
# Paths
KERNEL_DIR="${HOME}/Android/kernel_xiaomi_cepheus"
ZIMAGE_DIR="$KERNEL_DIR/out-clang/arch/arm64/boot"
KERNEL=Image.gz-dtb
ANY_KERNEL="${HOME}/MI9_Anykernel3_Nethunter"
zm="${KERNEL_DIR}/out-clang/modules_out/"
#mkdir $zm
cd $KERNEL_DIR
# Resources
THREAD="$(grep -c ^processor /proc/cpuinfo)"
export ARCH=arm64
export SUBARCH=arm64
#export CLANG_PATH=~/toolchains/Clang-11/bin/
export CLANG_PATH=~/Android/toolchains/proton-clang/bin/
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=${HOME}/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=${HOME}/toolchains/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
export CXXFLAGS="$CXXFLAGS -fPIC"
export LOCALVERSION=-NetHunter

DEFCONFIG="cepheus_defconfig"

DATE_START=$(date +"%s")

echo "-------------------"
echo "Making Kernel:"
echo "-------------------"

echo
make CC=clang O=out-clang $DEFCONFIG
make CC=clang O=out-clang -j$THREAD 2>&1 | tee kernel.log
 #INSTALL_MOD_PATH=$zm $THREAD modules_install

echo "-------------------"
echo "Build Completed in:"
echo "-------------------"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo
cd $ZIMAGE_DIR
ls -a

rm -rf $ANY_KERNEL/$KERNEL
#python3 mkdtboimg.py create out-clang/arch/arm64/boot/dtbo.img out-clang/arch/arm64/boot/dts/qcom/*.dtbo


#rm -rf ~/MI9_Anykernel3_Nethunter/dtbo.img
#rm -rf ~/out_kernel_asop/nethunter*
cp -a $ZIMAGE_DIR/$KERNEL $ANY_KERNEL

cd $ANY_KERNEL
mkdir -p release
rm release/*.zip 2>/dev/null
zip -r9 release/miuia.zip * -x .git README.md *placeholder release/
>>>>>>> 67c48e6cc9f16a3b38ee7028022469ccf51b9af7
