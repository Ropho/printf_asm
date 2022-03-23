extern add_func
global main

section .text

main:

    push rbx
    push r12        ;REGS, we have to preserve!
    push r13
    push r14
    push r15

func:

        mov     rdi, 1d             ; set 1st parameter (format)
        mov     rsi, 2d               ; set 2nd parameter (current_number)
 
        call    add_func                  ; printf(format, current_number)

        ;push rax                          ;RETURN ARG is in rax

        ;pop rax
;------------------------
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

;-----------------------END OF PROG
	mov rax, 0x3c	; exit function syscall code  
	xor rdi, rdi    ; exit code
	syscall     