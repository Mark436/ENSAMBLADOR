; OCHOA ROBLES MARCOS JAVIER
section .bss
    buf resb 3
    res resb 2

section .data
    fname db "e3.txt",0

section .text
global _start

_start:

    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 3
    syscall

    ; ASCII -> número real
    mov al, [buf]
    sub al, '0'

    mov bl, 10
    mul bl

    mov bl, [buf+1]
    sub bl, '0'

    add al, bl

    ; SHR funciona sobre el valor binario, no sobre ASCII
    shr al, 1

    ; número -> ASCII
    xor ah, ah
    mov bl, 10
    div bl

    add al, '0'
    mov [res], al

    mov al, ah
    add al, '0'
    mov [res+1], al

    mov rax, 2
    mov rdi, fname
    mov rsi, 577
    mov rdx, 0644o
    syscall

    mov rbx, rax

    mov rax, 1
    mov rdi, rbx
    mov rsi, res
    mov rdx, 2
    syscall

    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall