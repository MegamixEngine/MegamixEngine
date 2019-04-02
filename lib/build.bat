@echo off

echo Checking for MinGW...
g++ --version

IF %ERRORLEVEL% NEQ 0 (
	echo ERROR: MinGW is required to build these DLLs.
	goto :eof
)

echo Building filesystem tests...
g++ filesystem.cpp -static-libgcc -static-libstdc++ -m32 -o filesystem_test.exe -s

IF %ERRORLEVEL% NEQ 0 (
	echo Error building tests for filesystem!
	goto :eof
) ELSE (
	filesystem_test.exe
	IF %ERRORLEVEL% NEQ 0 (
	  echo Errors encountered! Refusing to build filesystem.dll.
	  goto :eof
	) ELSE (
	  echo Building filesystem.dll...
	  g++ -shared filesystem.cpp -static-libgcc -static-libstdc++ -m32 -DIS_DLL -o filesystem.dll -s
	  echo Build successful.
	)
)

echo Building chrono tests...
g++ chrono.cpp -static-libgcc -static-libstdc++ -m32 -o chrono_test.exe -s

IF %ERRORLEVEL% NEQ 0 (
	echo Error building tests for chrono.
	goto :eof
) ELSE (
	chrono_test.exe
	IF %ERRORLEVEL% NEQ 0 (
	  echo Errors encountered! Refusing to build chrono.dll.
	  goto :eof
	) ELSE (
	  echo Building chrono.dll...
	  g++ -shared chrono.cpp -static-libgcc -static-libstdc++ -m32 -DIS_DLL -o chrono.dll -s
	)
)

echo Build complete.