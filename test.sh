#AndroidImgui的Androidwindow移植到sdl上显示
echo 在termux下编译

git clone https://github.com/wode2016501/AndroidImgui

cp api-ok.cpp AndroidImgui/src 

cd AndroidImgui/scr

c++  -std=gnu++23 api-ok.cpp -c -I. 

cp api-ok.o ../..

gcc api-test.c -c

#下载SDL源码解压
git clone https://github.com/libsdl-org/SDL
cd SDL
echo |tee $(find -name SDL_main.h) $(find -name  SDL_android.c)
mkdir build 
cd build 
cmake .. 
make 
#编译得到静态库

#测试
cd ../..
gcc SDL/test/testvulkan.c api-ok.o api-test.o SDL-main/build/*.a -I SDL/include

adb push  a.out /data/local/tmp

adb shell  /data/local/tmp/a.out
