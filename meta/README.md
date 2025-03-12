## THE META FOLDER
The following are either source code for extensions used in Megamix 1.9, or tools intended to assist with development (Some of which are sourced from other repositories).

These may require additional dependencies. A batch file is available for some to make the process seamless, *once installed*.

# brstm2ogg
Converts BRSTM files to OGG for use with Megamix 1.9. This is a commmon file format for use with Super Smash Bros. modding, and as such, in fangames it is much more convenient in many cases to find a file under this format, then convert it to OGG, rather than ripping the OGG yourself and finding the exact loop points.

This version is a fork, which allows the user to input additional metadata. The provided .bat file will let you fill out these values manually, explaining each of their purpose.

**See the Readme.MD of the folder for necessary dependencies. It will produce an error if you do not do this.**

Note that the process to install vorbis tools can be cumbersome for Windows; There is a fork [here](https://github.com/Chocobo1/vorbis-tools_win32-build/releases) that contains pre-compiled .exe's. You can add a path to the EXE's contained here to achieve the same effect.

# Mega Extra Content Loader for Megamix (MECLMM)
An extension for 1.9 designed to both fix some broken functionality in GMS1.4, as well as add some new features.
- Contains a workaround for open_url no longer working in most modern browsers.
- SHA-256 Hashing Support (More secure than SHA-1, but note that it is slowly becoming outdated itself).
- Check current game memory within the game itself (used to warn the developer/player about potential memory leaks).
- Check space on C Drive (to prevent possible memory corruption when saving).
- OGG tag acquisition (Used for automated loop points and music credits).

# Fluwiidi
A new extension for 1.9 that allows for MIDI playback with custom SF2 soundfonts. Built off of Nfluidsynth.

# Generate Light/Featherweight Project (GMSListUnusedResources)
GMSListUnusedResources (GMSLUR) is a tool that can build lightweight or featherweight versions of your project.

A lightweight project is one that removes every asset that isn't currently being referenced in any way.

A featherweight project is one where you specify specific rooms to include, and any rooms/assets that are not a part of that list are replaced with negative constants via macros. This allows for *very* fast testing of specific rooms and portions of your project, particularly when it starts to get very big.

# GMSQuickCompile (GMSQC)
A tool that can greatly speed up compilation times, especially for those not needing GMS as a developer environment.
On a fresh cache, can compile very large projects in half the time as booting up GMS to do the same.
In addition, with the provided gmslur.exe, you can generate and immediately compile featherweight projects.

# GMSCacheManager
A tool primarily used during development for sorting out texture pages in a way that's fairly optimal both for compiling and for runtime. Should be adjusted to your specific use case.