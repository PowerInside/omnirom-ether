repo init -u https://github.com/omnirom/android.git -b android-7.1 --depth=1 && \
repo sync -j8 -c -f --no-clone-bundle
export USE_CCACHE=1
/android/omni/prebuilts/misc/linux-x86/ccache/ccache -M 15G
cd /android/omni/device/nextbit/ether && \ 
./extract-files.sh -d /android/sys_dump/ && \ 
source /android/build/envsetup.sh && \
brunch ether
