for f in ./*.asm; do dotnet retroassembler.dll $f; done
