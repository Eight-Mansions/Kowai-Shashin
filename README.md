# Kowai-Shashin
## Building
- These instructions expect a Windows environment at this time.

### Requirements
The formmatter and compressor use Python 3, so you will need that installed on your system.
The compression depends on the `lzss` module. You can install that with `pip lzss`. If you have problems setting this up, you can comment out the `KSImageCompressor.py` line in `2_build.bat` to skip it, then copy the original `graphics\orig\TITLE.DAT` to `graphics\TITLE.DAT`.

### First time prep
1. Extract the contents of your original game with CDMage, psximager, etc.
2. **Try to avoid extracting 3MIN.!** Windows hates that a file ends in . and will throw up. If you do get stuck with it, using Windows Subsystem's Ubuntu terminal is easiest.

### Build
- To build from start to finish, run `build-kowai-shashin.bat`. Then your bin/cue will be in the cd folder. Otherwise, you can run `1_insert.bat` or `2_build.bat` manually. Running `2a_build_vn.bat` or `2b_build_random.bat` will create the corresponding hack patch, though `1_insert.bat` should be run first at least once.

To create a patch release, run `create_patch.bat` and an xdelta patch will be created under `release\patch_data`.
