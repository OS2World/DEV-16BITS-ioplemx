all: test_iopl.exe

test_iopl.exe: test_iopl.obj test_iopl.def iopl.obj
	gcc test_iopl.obj test_iopl.def iopl.obj -Zomf -Zcrtdll
test_iopl.obj: test_iopl.c
	gcc -c test_iopl.c -Zomf
iopl.obj: iopl.asm
	\masm\masm iopl;

