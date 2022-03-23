extern  printf
global main

section .text

main:

    push rbx
    push r12        ;REGS, we have to preserve!
    push r13
    push r14
    push r15

print:

        mov     rdi, format             ; set 1st parameter (format)
        mov     rsi, 0x25               ; set 2nd parameter (current_number)
        mov     rdx, 0x24               ; set 3rd parameter
        mov     rcx, 0x23               ;set 4th parameter
        mov     r8, 0x22                ;set 5th parameter
        mov     r9, 0xFF                ;set 6th parameter
        
;----------------------16 byte ALLIGNMENT for rsp
        mov rax, 0x00       
        push    rax                     ;rsp has to be alligned on 16
        mov rax, 0x00                   ;so we have to additional push  
        push rax
;----------------------

                                        ;args in reverse order
        mov rax, 10d                    ;set 8th parameter
        push    rax

        mov rax, 11d
        push    rax                     ;set 7th parameter
         
        call    printf                  ; printf(format, current_number)

;------------------------POP STACK PARAMS
        pop rax
        pop rax

;------------------------POP ALLIGNMET
        pop rax
        pop rax
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

    
section .data
    format: db  "KEKWAIT: %c %c %c %c %d %d %d", 10, 0x00