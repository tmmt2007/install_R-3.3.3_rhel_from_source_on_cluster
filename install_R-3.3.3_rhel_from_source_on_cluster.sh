#! /bin/bash

## install R-3.3.3 at 1st time
cd /shared/apps/R
wget https://cran.r-project.org/src/base/R-3/R-3.3.3.tar.gz
tar xzvf R-3.3.3.tar.gz
cd R-3.3.3
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## error 1: 
## ........
## checking if zlib version >= 1.2.5... no
## checking whether zlib support suffices... configure: error: zlib library and headers are required

## step 1. install zlib-1.2.11
cd /shared/apps/R/packages
wget http://zlib.net/zlib-1.2.11.tar.gz
tar xzvf zlib-1.2.11.tar.gz 
cd zlib-1.2.11
./configure --prefix=/shared/apps/R/packages/
make
make install

## step 2. set the path and flags (this step is important!!)
export PATH=/shared/apps/R/packages/bin:$PATH
export LD_LIBRARY_PATH=/shared/apps/R/packages/lib:$LD_LIBRARY_PATH
export CFLAGS="-I/shared/apps/R/packages/include"
export LDFLAGS="-L/shared/apps/R/packages/lib"

cd ../../R-3.3.3

## step 3: install R-3.3.3 at 2nd time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## error 2:
## ........
## checking for bzlib.h... yes
## checking if bzip2 version >= 1.0.6... no
## checking whether bzip2 support suffices... configure: error: bzip2 library and headers are required

cd ../../packages/

## step 4: install bzip2-1.0.6
wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
tar xzf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make -f Makefile-libbz2_so
make clean
make
make -n install PREFIX=/shared/apps/R/packages/
make install PREFIX=/shared/apps/R/packages/

cd ../../R-3.3.3

## step 5: install R-3.3.3 at 3rd time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## error 3:
## ........
## checking if bzip2 version >= 1.0.6... yes
## checking whether bzip2 support suffices... yes
## checking for lzma_version_number in -llzma... no
## configure: error: "liblzma library and headers are required"

cd ../../packages/

## step 6. install xz-5.2.3
wget http://tukaani.org/xz/xz-5.2.3.tar.gz
tar xzf xz-5.2.3.tar.gz
cd xz-5.2.3
./configure --prefix=/shared/apps/R/packages/
make -j3
make install

cd ../../R-3.3.3

## step 7: install R-3.3.3 at 4th time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## error 4:
## ........
## checking if lzma version >= 5.0.3... yes
## ........
## checking for pcre/pcre.h... no
## checking if PCRE version >= 8.10, < 10.0 and has UTF-8 support... no
## checking whether PCRE support suffices... configure: error: pcre >= 8.10 library and headers are required

cd ../../packages/

## step 8. install pcre-8.40
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.bz2
tar xjf pcre-8.40.tar.bz2
cd pcre-8.40
./configure --enable-utf8 --prefix=/shared/apps/R/packages/
## here, --enable-utf8 will solve the error of " UTF-8 support... no".
make -j3
make install

cd ../../R-3.3.3

## step 9: install R-3.3.3 at 5th time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## error 5:
## ........
## checking if PCRE version >= 8.10, < 10.0 and has UTF-8 support... yes
## checking if PCRE version >= 8.32... yes
## ........
## checking if libcurl is version 7 and >= 7.28.0... no
## configure: error: libcurl >= 7.28.0 library and headers are required with support for https

cd ../../packages/

## step 10. install curl-7.54.0
wget --no-check-certificate https://curl.haxx.se/download/curl-7.54.0.tar.gz
tar xzf curl-7.54.0.tar.gz
cd curl-7.54.0
./configure --prefix=/shared/apps/R/packages/
make -j3
make install

cd ../../R-3.3.3

## step 11: install R-3.3.3 at 6th time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
## here, no errors happen, then move on to 'make'
make
## error 6:
## ........
## /usr/bin/ld: /shared/apps/R/packages/lib/libbz2.a(bzlib.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
## /shared/apps/R/packages/lib/libbz2.a: could not read symbols: Bad value
## collect2: ld returned 1 exit status
## make[3]: *** [libR.so] Error 1
## make[3]: Leaving directory `/shared/apps/R/R-3.3.3/build/src/main'
## make[2]: *** [R] Error 2
## make[2]: Leaving directory `/shared/apps/R/R-3.3.3/build/src/main'
## make[1]: *** [R] Error 1
## make[1]: Leaving directory `/shared/apps/R/R-3.3.3/build/src'
## make: *** [R] Error 1

## step 12: recompiling bzip2
## go back to libbz2, that is bzip2, rm the directory and configure and make again.
cd ../../packages/bzip2-1.0.6
vi Makefile
## add a flag '-fPIC' as: "CFLAGS=-fpic -fPIC -Wall -Winline -O2 -g $(BIGFILES)"
## recompiling again
make -f Makefile-libbz2_so
make clean
make
make -n install PREFIX=/shared/apps/R/packages/
make install PREFIX=/shared/apps/R/packages/

cd ../../R-3.3.3

## step 13: install R-3.3.3 at 7th time
rm -rf build
mkdir build
cd build
../configure --prefix=/shared/apps/R/R-3.3.3 '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling'
make
## .................
## .................
## make[3]: Leaving directory `/tmp/RtmpFEswHe/R.INSTALL1d6c4ef07e30/mgcv/src'
## installing to /shared/apps/R/R-3.3.3/build/library/mgcv/libs
## ** R
## ** data
## ** inst
## ** byte-compile and prepare package for lazy loading
## ** help
## *** installing help indices
## ** building package indices
## ** testing if installed package can be loaded
## * DONE (mgcv)
## make[2]: Leaving directory `/shared/apps/R/R-3.3.3/build/src/library/Recommended'
## make[1]: Leaving directory `/shared/apps/R/R-3.3.3/build/src/library/Recommended'
## make[1]: Entering directory `/shared/apps/R/R-3.3.3/build/src/library'
## building/updating vignettes for package 'grid' ...
## building/updating vignettes for package 'parallel' ...
## building/updating vignettes for package 'utils' ...
## make[1]: Leaving directory `/shared/apps/R/R-3.3.3/build/src/library'
## make[1]: Entering directory `/shared/apps/R/R-3.3.3/build'
## configuring Java ...
## Java interpreter : /usr/bin/java
## Java version     : 1.6.0_24
## Java home path   : /usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre
## Java compiler    : /usr/bin/javac
## Java headers gen.: /usr/bin/javah
## Java archive tool: /usr/bin/jar

## trying to compile and link a JNI program 
## detected JNI cpp flags    : -I$(JAVA_HOME)/../include -I$(JAVA_HOME)/../include/linux
## detected JNI linker flags : -L$(JAVA_HOME)/lib/amd64/server -ljvm
## make[2]: Entering directory `/tmp/Rjavareconf.aULK9T'
## gcc -std=gnu99 -I/shared/apps/R/R-3.3.3/build/include -DNDEBUG -I/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/../include -I/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/../include/linux -I/usr/local/include    -fpic  -I/shared/apps/R/packages/include  -c conftest.c -o conftest.o
## gcc -std=gnu99 -shared -L/shared/apps/R/R-3.3.3/build/lib -L/shared/apps/R/packages/lib -o conftest.so conftest.o -L/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/lib/amd64/server -ljvm -L/shared/apps/R/R-3.3.3/build/lib -lR
## make[2]: Leaving directory `/tmp/Rjavareconf.aULK9T'

## JAVA_HOME        : /usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre
## Java library path: $(JAVA_HOME)/lib/amd64/server
## JNI cpp flags    : -I$(JAVA_HOME)/../include -I$(JAVA_HOME)/../include/linux
## JNI linker flags : -L$(JAVA_HOME)/lib/amd64/server -ljvm
## Updating Java configuration in /shared/apps/R/R-3.3.3/build
## Done.

## make[1]: Leaving directory `/shared/apps/R/R-3.3.3/build'
