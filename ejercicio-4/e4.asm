; OCHOA ROBLES MARCOS JAVIER
section .bss
    buf resb 1
    res resb 1

section .data
    fname db "e4.txt",0

section .text
global _start

_start:

    mov rax, 2
    mov rdi, fname
    mov rsi, 0
    mov rdx, 0
    syscall

    mov rbx, rax

    mov rax, 0
    mov rdi, rbx
    mov rsi, buf
    mov rdx, 1
    syscall

    mov rax, 3
    mov rdi, rbx
    syscall

    mov al, [buf]

    ; ROR rota los bits a la derecha
    ror al, 1

    mov [res], al

    mov rax, 2
    mov rdi, fname
    mov rsi, 577
    mov rdx, 0644o
    syscall

    mov rbx, rax

    mov rax, 1
    mov rdi, rbx
    mov rsi, res
    mov rdx, 1
    syscall

    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall