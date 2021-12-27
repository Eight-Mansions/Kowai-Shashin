:: Clear out the old files
del cd\working\DATA\SCN\*.DAT
del cd\working\DATA\SCN2\*.DAT
del exe\SLPS_034.54

:: Copy the new DAT files into the working directory
xcopy /e /y ins\* cd\working\DATA\

:: Compress and copy the translated images in
python tools\KSImageCompressor.py graphics\TITLE graphics\orig\TITLE.DAT graphics\TITLE.DAT
python tools\KSImageCompressor.py graphics\ACTION graphics\orig\ACTION.DAT graphics\ACTION.DAT
python tools\KSImageCompressor.py graphics\STG01 graphics\orig\STG01.DAT graphics\STG01.DAT
python tools\KSImageCompressor.py graphics\ALBUM2 graphics\orig\ALBUM2.DAT graphics\ALBUM2.DAT
python tools\KSImageCompressor.py graphics\COMMON graphics\orig\COMMON.DAT graphics\COMMON.DAT

copy graphics\TITLE.DAT cd\working\DATA\TITLE.DAT
copy graphics\ACTION.DAT cd\working\DATA\ACTION.DAT
copy graphics\STG01.DAT cd\working\DATA\STG\STG01.DAT
copy graphics\ALBUM2.DAT cd\working\DATA\ALBUM2.DAT
copy graphics\COMMON.DAT cd\working\DATA\COMMON.DAT

:: Build the new exe using the assembly file
copy exe\orig\SLPS_034.54 exe\SLPS_034.54
tools\armips.exe code\kowai-shashin-assembly.asm
tools\atlas exe\SLPS_034.54 trans\exe_translations.txt >> exe_error.txt
copy exe\SLPS_034.54 cd\working\SLPS_034.54

:: Combine everything into a final build
tools\psximager\psxbuild.exe cd\working.cat cd\kowai-shashin-working.bin>> cd\build.log
