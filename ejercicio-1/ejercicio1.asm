;OCHOA ROBLES MARCOS JAVIER
section .bss
    input resb 2
    oute   resb 1

section .data
    fname db "e1.txt",0

section .text
global _start

_start:
    ; read (stdin)
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 2
    syscall

    mov al, [input]
    sub al, 30h

    shl al, 1

    add al, 30h
    mov [oute], al

    ; open file
    mov rax, 2
    mov rdi, fname
    mov rsi, 577
    mov rdx, 0644o
    syscall

    mov rbx, rax

    ; write
    mov rax, 1
    mov rdi, rbx
    mov rsi, oute
    mov rdx, 1
    syscall

    ; close
    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall