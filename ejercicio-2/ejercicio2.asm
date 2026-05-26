; OCHOA ROBLES MARCOS JAVIER
section .bss
    hex resb 2

section .data
    fname db "e2.txt",0

section .text
global _start

_start:
    mov al, 0x3A

    ; high nibble
    mov bl, al
    shr bl, 4

    cmp bl, 9
    jle .h1
    add bl, 7
.h1:
    add bl, 30h

    ; low nibble
    mov cl, al
    and cl, 0Fh

    cmp cl, 9
    jle .h2
    add cl, 7
.h2:
    add cl, 30h

    mov [hex], bl
    mov [hex+1], cl

    ; open
    mov rax, 2
    mov rdi, fname
    mov rsi, 577
    mov rdx, 0644o
    syscall

    mov rbx, rax

    ; write
    mov rax, 1
    mov rdi, rbx
    mov rsi, hex
    mov rdx, 2
    syscall

    ; close
    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall