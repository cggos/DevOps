@echo off
echo ****** �������ϵͳ�����ļ������Ե�...... ******

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old

del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd     /s /q %windir%\temp & md %windir%\temp

del /f /s /q "%userprofile%\*.tmp"
del /f /s /q "%userprofile%\AppData\Local\Temp\*"
rd     /s /q "%userprofile%\AppData\Local\Temp" & md "%userprofile%\AppData\Local\Temp"
rd     /s /q "%userprofile%\Favorites" & md "%userprofile%\Favorites"
rd     /s /q "%userprofile%\Documents" & md "%userprofile%\Documents"

cls

echo ****** ϵͳ���������ɣ�******
echo.& pause