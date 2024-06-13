#!/bin/bash

FFMPEG_VERSION=5.0
FFMPEG_SOURCE_DIR=FFmpeg-n$FFMPEG_VERSION
FFMPEG_LIBS="libavcodec libavdevice libavfilter libavformat libavutil libpostproc libswresample libswscale"
PREFIX=`pwd`/output
ARCH="arm64"

if [ ! -d $FFMPEG_SOURCE_DIR ]; then
  echo "Start downloading FFmpeg..."
  curl -LJO https://codeload.github.com/FFmpeg/FFmpeg/tar.gz/n$FFMPEG_VERSION || exit 1
  tar -zxvf FFmpeg-n$FFMPEG_VERSION.tar.gz || exit 1
  rm -f FFmpeg-n$FFMPEG_VERSION.tar.gz
fi

echo "Start compiling FFmpeg..."

rm -rf $PREFIX
cd $FFMPEG_SOURCE_DIR

## macos
#./configure \
#  --prefix=$PREFIX \
#  --enable-gpl \
#  --enable-version3 \
#  --disable-programs \
#  --disable-doc \
#  --arch=$ARCH \
#  --extra-cflags="-arch $ARCH -march=native -fno-stack-check" \
#  --disable-debug || exit 1
  
## ios arm64
./configure \
--prefix=$PREFIX
--cc="xcrun -f --sdk iphoneos17.5 clang" \
--arch=aarch64 \
--cpu=generic \
--sysroot="xcrun --sdk iphoneos17.5 --show-sdk-path" \
--target-os=darwin \
--extra-cflags="-arch arm64" \
--extra-ldflags="-arch arm64 -miphoneos-version-min=7.0" \
--enable-cross-compile

make clean
make -j8 install || exit 1

cd ..

for LIB in $FFMPEG_LIBS; do
  ./build_framework.sh $PREFIX $LIB $FFMPEG_VERSION || exit 1
done

echo "The compilation of FFmpeg is completed."
