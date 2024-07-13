mv "C:\Windows\System32\lxss\lib\libcuda.so" "C:\Windows\System32\lxss\lib\libcuda.so.bak"
mv "C:\Windows\System32\lxss\lib\libcuda.so.1" "C:\Windows\System32\lxss\lib\libcuda.so.1.bak"
New-Item -ItemType SymbolicLink -Path "C:\Windows\System32\lxss\lib\libcuda.so.1" -Target "C:\Windows\System32\lxss\lib\libcuda.so.1.1"
New-Item -ItemType SymbolicLink -Path "C:\Windows\System32\lxss\lib\libcuda.so" -Target "C:\Windows\System32\lxss\lib\libcuda.so.1"
