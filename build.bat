CALL git submodule update --init --recursive
mkdir build_oce
cd build_oce
CALL SETENV.BAT

REM set GENERATOR=Visual Studio 11 2012
REM set VisualStudioVersion=11.0
set GENERATOR=Visual Studio 10 2010
set VisualStudioVersion=10.0
'"%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat" x86'

CALL cmake -DOCE_INSTALL_PREFIX:STRING="%PREFIX%" ^
-DCMAKE_SUPPRESS_REGENERATION:BOOL=ON  ^
-DOCE_MULTITHREADED_BUILD:BOOL=ON ^
-DBUILD_SHARED_LIBS:BOOL=OFF ^
-DBUILD_TESTING:BOOLEAN=OFF ^
-DOCE_DRAW:BOOLEAN=OFF ^
-DOCE_TESTING:BOOLEAN=OFF ^
-DOCE_OCAF:BOOLEAN=OFF ^
-DOCE_VISUALISATION:BOOLEAN=OFF ^
-DOCE_DISABLE_X11:BOOLEAN=ON ^
-DOCE_DISABLE_TKSERVICE_FONT:BOOLEAN=ON ^
-DOCE_USE_PCH:BOOLEAN=ON  ^
-G "%GENERATOR%" ../oce  

REM msbuild /m oce.sln
CALL msbuild /m oce.sln /p:Configuration=Release

CALL msbuild INSTALL.vcxproj /p:Configuration=Release
cd ..
CALL npm install