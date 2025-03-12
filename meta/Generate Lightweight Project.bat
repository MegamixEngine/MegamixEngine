set /p id="Enter levels you want, spaced apart, without the .room.gmx extension: "
@echo off
>output.txt (
gmslur.exe -p "../MegamixEngine.project.gmx"
)
@echo on
set /p id="Output made to output.txt"