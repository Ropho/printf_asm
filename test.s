global rprintf

section .text



%macro      putchar 0                 

            push rax 
            push rdi
            push rsi
            push rdx

            mov rax, 0x01      ; write64 (rdi, rsi, rdx) ... r10, r8, r9
            mov rdi, 1         ; stdout
            mov rsi, r14
            mov rdx, 1    ; strlen (Msg)
            syscall

            pop rdx
            pop rsi
            pop rdi
            pop rax                  
%endmacro


rprintf:

    mov r12, rsp
    add r12, 8d                     ;points on first param in stack
 
    mov r14, rdi                    ;pointer on the string
    mov r15, 1d                     ;NUMBER OF PARAMS
;-----------------------------------
    mov    [buffer_param],      rsi
    mov    [buffer_param + 8],  rdx 
    mov    [buffer_param + 16], rcx
    mov    [buffer_param + 24], r8
    mov    [buffer_param + 32], r9

.loop:

	cmp [r14], byte 0x00
	je end_of_string 			;end of loop
	
	call check_symb
	
	inc r14

	jmp .loop

end_of_string:
	ret



check_symb:
        cmp [r14], byte 25h
        jne std_print
        
		inc r14
		call procent_dealer
	
		jmp end_print

        std_print:
            putchar
        end_print:
	ret


procent_dealer:
	
	xor rbx, rbx

	mov bl, byte [r14]
	sub bl, 'a' + 1             ; code -> offset from 'a'
                                    ; jmp to default
	shl rbx, 3                  ; rbx *= 8

	mov rax, JumpTable
	add rbx, rax
	mov rbx, [rbx]	;SEGFAULT HERE

	jmp rbx                  	; jump to particlar JumpTable	

strr:
    call param

    inc r15

 	mov rbx, r13
	
	push r14
	push rbx
 		call strlen
	pop rbx
	pop r14

	push r14
	.loop:

		push rcx
		push rbx

		mov r14, rbx
		putchar

		pop rbx
		inc rbx
		pop rcx

		sub rcx, 1d
		cmp rcx, 0d
	jne .loop
	pop r14

	jmp endd


character:

    call param

    mov [buffer_ch], r13
    inc r15

    push r14            		;GET address of the ASCII from stack
		mov r14, buffer_ch
    	putchar
	pop r14
	
	jmp endd



bin:
	mov rcx, 2d
	jmp number_print

oct:
	mov rcx, 8d
	jmp number_print
hex:
	mov rcx, 16d
	jmp number_print	
decc:
	mov rcx, 10d
	jmp number_print


number_print:
	

    call param

    inc r15

	mov rsi, buffer_num
    mov rbx, r13
	call itoa

	mov rdx, rdi		;strlen
	mov rax, 0x01       ; write64 (rdi, rsi, rdx) ... r10, r8, r9
    mov rdi, 1          ; stdout, rsi has the string
    syscall	

	jmp endd


stdd:
    push r14
	    putchar
    pop r14
endd:	
	ret




section .data

    buffer_ch:  db 0
	buffer_num: times 10 db (0)

    buffer_param times 5 dq (0)

	JumpTable:
		dq bin	        ;0
		dq character	;1
		dq decc	        ;2
		dq stdd	        ;3
		dq stdd	        ;4
		dq stdd	        ;5
		dq stdd	        ;6
		dq stdd	        ;7
		dq stdd	        ;8
		dq stdd	        ;9
		dq stdd	        ;10
		dq stdd	        ;11
		dq stdd	        ;12
		dq oct	        ;13
		dq stdd	        ;14
		dq stdd	        ;15
		dq stdd	        ;16
		dq strr	        ;17
		dq stdd	        ;18
		dq stdd	        ;19
		dq stdd	        ;20
		dq stdd	        ;21
		dq hex	        ;22

;=============================

section .text


;ENTRY: rbx = offset string
;OUT: rcx = strlen
;DESTR: rbx, rcx

strlen:

	mov rcx, 0
	
.increment:
	
	cmp byte [rbx], 0x00
	je end_of_increment

	inc rcx
	inc rbx
	jmp .increment

end_of_increment:
	
	ret
;====================================================
;GIVES needed parameter in r13
param:
    
    push r15
    dec r15

    cmp r15, 5d
    jae stack
    
    regs: 
        mov r13, [buffer_param + r15 * 8d]
        jmp end_of_check
    
    stack:
        push rbp
        
        mov rbp, r12
        mov r13, [rbp]
        add r12, 8d
        
        pop rbp
        jmp end_of_check


end_of_check:
    pop r15

    ret


;--------------------ITOA------------------------
;
; Description: Translates number into string
; Entry:
;              RSI - points to the address of the
;                   first symbol in string
;              RBX - number to be translated
;              RCX - base of the numeric system 
;
; Exit:        SI remains it value
;              DI - number of symbols in string
;
; Destr:       BX, AX, DX
;------------------------------------------------

itoa:

            mov rax, rbx   
            mov rdi, 1           ; start value of counter       

        .count:           ; counting offset
            xor rdx, rdx
            div rcx

            cmp rax, 0
            je .main
            inc rsi              ; iterate to next symb
            inc rdi              ; increments counter
            jmp .count

        .main:
            mov rax, rbx
	
	    inc rsi
	    mov byte [rsi], 0h	;add '\0' in the end
	    dec rsi

	            .loop:
            xor rdx, rdx          ; for 'div' command
            	div rcx

            mov rbx, rdx          ; converting remainder to symbol
            mov dl, [rbx + HEX]   
                                   ; prints number from end
            mov [rsi], dl     
            dec rsi              ; iterate to next symbol

            cmp rax, 0
            jne .loop

            inc rsi              ; si points to the start of string
            ret


section .data

HEX db "0123456789ABCDEF"
HEX_LEN equ $ - HEX
;------------------------------------------------------------------------------
