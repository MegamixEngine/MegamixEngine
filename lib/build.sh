echo "Building filesystem tests..."
g++ filesystem-linux.cpp -static-libgcc -static-libstdc++ -o filesystem_test -s
./filesystem_test
g++ -shared filesystem-linux.cpp -static-libgcc -static-libstdc++ -fPIC -DIS_DLL -o filesystem.so -s