#! /bin/bash

rm -f build
mkdir build
cd src
zip -r 2017.love ./
mv 2017.love ../build
cd ../build
cp ~/dev/love-0.10.1-win32/*.dll ./
cat ~/dev/love-0.10.1-win32/love.exe 2017.love > 2017.exe
mv 2017.love ../
zip -r 2017-win32.zip ./
mv ../2017.love ./
