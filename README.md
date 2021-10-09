# Kowai-Shashin
To build from start to finsh, run `build-kowai-shashin.bat`. Then your bin/cue will be in the cd folder. Otherwise, you can run `0_format.bat`, `1_insert.bat`, or `2_build.bat` manually.

To create a patch release, run `create_patch.bat` and an xdelta patch will be created under `release\patch_data`.

## Requirements
The formmatter and compressor use Python 3, so you will need that installed on your system.
The compression depends on the `lzss` module. You can install that with `pip lzss`. If you have problems setting this up, you can comment out the `KSImageCompressor.py` line in `2_build.bat` to skip it, then copy the original `graphics\orig\TITLE.DAT` to `graphics\TITLE.DAT`.
