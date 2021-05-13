echo off

echo ****** 注册Windows下全部的.dll文件 ******
for %1 in (%windir%system32*.dll) do regsvr32.exe /s %1

pause