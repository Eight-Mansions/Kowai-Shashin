:: If you want to move this bat to somewhere like your desktop, uncomment
:: the pushd and change it to where your files are stored
:: pushd "C:\Users\yagen\Desktop\Translation Working\Kowai Shashin\tools"

::call 0_format.bat
call 1_insert.bat
call 2_build.bat
::popd

echo "Build complete!"
pause
