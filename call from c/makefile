# dos.exe: dos.s
# 	nasm -felf64 -g -l dos.lst dos.s ; 	ld -g -o dos.exe dos.o

# dos.exe: d.cpp dos.s
# 	nasm -felf64 dos.s ; gcc -c d.cpp ; ld dos.o d.o -o a ; ./a

# call.exe: callmaxofthree.c maxofthree.asm
# 	nasm -felf64 maxofthree.asm ; gcc callmaxofthree.c maxofthree.o
# set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -Wall --std=c++11 -O3 -fPIC" )
# set( CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -Wall -O3 -fPIC" )

# dos.exe: d.cpp dos.s
# 	nasm -felf64 dos.s ; gcc d.cpp dos.o


# dos.exe: d.cpp test.s
# 	nasm -felf64 test.s ; gcc d.cpp test.o


# dos.exe: d.c test.s
# 	nasm -felf64 test.s ; gcc -c d.c ; ld test.o d.o -o kek


# nasm -felf64 test.s && gcc test.o d.c && ./a.out

# ÐÀÁÎ×Àß!!!!
a.out: test.s d.c
	nasm -felf64 test.s && gcc test.o d.c -no-pie && ./a.out

# dos: dos.s d.c
# 	nasm -felf64 dos.s && gcc dos.o d.c -o dos && ./dos
