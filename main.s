section .data
    prompt: db "Enter height of pyramid: "
    promptLen: equ  $ - prompt
    newline: db 0xa
    char: db "*"
    space: db " "

section .bss
    size resb 1

section .text
    global _start

_start:
    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, prompt       ; this message
    mov rdx, promptLen    ; of this length
    syscall

    mov rax, 0            ; read
    mov rdi, 0            ; from stdin
    mov rsi, size         ; to this location
    mov rdx, 1            ; read 1 byte
    syscall

    mov al, [size]        ; move size to 8 bit register
    sub al, '0'           ; convert ascii to integer by subtracting '0'
    mov [size], al        ; set value of size

    mov r8, 0

mainLoop:
    cmp r8, [size]
    je exit

    mov r9, [size]
    dec r9
spacesLoop:
    cmp r9, r8
    je spacesLoopExit

    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, space        ; the character
    mov rdx, 1            ; of 1 byte
    syscall

    dec r9
    jmp spacesLoop

spacesLoopExit:
    mov r10, 0
    mov r9, r8
    shl r9, 1

contentLoop:
    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, char         ; the character
    mov rdx, 1            ; of 1 byte
    syscall 

    cmp r10, r9
    je contentLoopExit

    inc r10
    jmp contentLoop
contentLoopExit:
    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, newline      ; this message
    mov rdx, 1            ; of this length
    syscall

    inc r8                ; decrement size
    jmp mainLoop          ; repeat

exit:
    mov rax, 60           ; exit
    mov rdi, 0            ; with exit code
    syscall
