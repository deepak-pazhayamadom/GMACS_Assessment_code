if NOT EXIST build mkdir build
if NOT EXIST build\debug mkdir build\debug
if NOT EXIST build\release mkdir build\release

if NOT EXIST build\SNOW mkdir build\SNOW
if NOT EXIST build\SNOW_crab mkdir build\SNOW_crab

copy lib\*.cpp
copy gmacsbase.tpl+personal.tpl gmacs.tpl
call admb -g gmacs.tpl tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp equilibrium.cpp dirichlet.cpp 
:: g++ -c -std=c++14 -O3 -fpermissive -D_FILE_OFFSET_BITS=64 -I. -I"C:\Program Files (x86)\ADMB\include" -I"C:\Program Files (x86)\ADMB\contrib\include" -o gmacs.obj gmacs.cpp
:: g++ -static -g -o gmacs.exe gmacs.obj "C:\Program Files (x86)\ADMB\lib\libadmb-contrib.a" tailcompression.obj nloglike.obj spr.obj multinomial.obj robust_multi.obj equilibrium.obj dirichlet.obj
copy gmacs.exe build\SNOW\
copy clean.bat build\SNOW\

copy gmacs.exe build\SNOW_crab
copy clean.bat build\SNOW_crab

rem call admb -f gmacs.tpl tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp equilibrium.cpp dirichlet.cpp
rem copy gmacs.exe build\release
:: Cleanup src directory (these files live in lib directory)
del tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp equilibrium.cpp dirichlet.cpp

