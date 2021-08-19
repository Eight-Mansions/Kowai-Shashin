@echo off
set original=kowai-shashin-original.bin
set working=kowai-shashin-working.bin

:: Check that the files exist
if not exist cd\%original% (
	echo Could not find the original bin
	echo Please verify a file named %original% exists in the cd folder
	echo and try again.
	goto :EXIT
)

if not exist cd\%working% (
	echo Could not find the translated bin
	echo Please verify a file named %working% exists in the cd folder
	echo and try again.
	goto :EXIT
)

:: Create a patch with the two bins
echo Creating patch, please wait...
release\patch_data\xdelta.exe -9 -S djw -B 1812725760 -e -vfs cd\%original% cd\%working% release\patch_data\kowai-shashin-patch.xdelta3
echo Patch created successfully in the release\patch_data folder!

:EXIT
echo Press any key to close this window
pause >nul
exit