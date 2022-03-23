a.out: call_print_from_asm.s 
	nasm -felf64 call_print_from_asm.s  && gcc call_print_from_asm.o -o print -no-pie && ./print

# a.out: call_from_asm.s call_from_asm.c
# 	nasm -felf64 call_from_asm.s  && ld call_from_asm.o  && ./a.out