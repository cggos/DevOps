echo off

echo ****** set environment variables of Visual C++ 6.0 ******
call VCVARS32.BAT

echo ****** go to the current directory ******
cd /d %~dp0

echo ****** log file ******
set fileLog = %~dp0\BuildVC6_Log.txt
if exist %infoFile% del %infoFile%
echo Build Date:%date% >> %fileLog%
echo Build Time:%time% >> %fileLog%

echo ****** set VC6 setting ******
set fileReg = %~dp0\BuildVC6_IncludeFile.reg
C:\WINDOWS\regedit /s  %fileReg%

echo ****** build VC6 project ******
echo  正在编译 xxx .......
msdev xxx.dsp /make "all - Win32 Debug" /rebuild >> %fileLog%  
if errorlevel 1 (
   echo 编译错误 请看日志文件：%fileLog%
)

pause