section .data
    prompt: db "Enter size of pyramid:", 0xa
    promptLen: equ  $ - prompt
    newline: db 0xa
    char: db "*"

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

    mov bl, [size]

mainLoop:
    cmp bl, 0
    je exit

    mov r8b, bl

innerLoop:
    cmp r8b, 0
    je exitIn

    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, char         ; the character
    mov rdx, 1            ; of 1 byte
    syscall

    dec r8b               ; decrement height
    jmp innerLoop         ; repeat

exitIn:
    mov rax, 1            ; write
    mov rdi, 1            ; to stdout
    mov rsi, newline      ; a newline
    mov rdx, 1            ; of 1 byte
    syscall

    dec bl                ; decrement size
    jmp mainLoop          ; repeat

exit:
    mov rax, 60           ; exit
    mov rdi, 0            ; with exit code
    syscall
