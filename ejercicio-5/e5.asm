;OCHOA ROBLES MARCOS JAVIER
section .bss
    buf resb 3
    hex resb 2

section .data
    fname db "e5.txt",0

section .text
global _start

_start:

    ; leer 2 dígitos
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 3
    syscall

    ; convertir ASCII -> número
    mov al, [buf]
    sub al, '0'

    mov bl, 10
    mul bl              ; AL = (buf[0] * 10)

    mov bl, [buf+1]
    sub bl, '0'

    add al, bl          ; AL = número final (0-99)

    ; guardar número en BL
    mov bl, al

    ; =========================
    ; convertir a HEX (byte)
    ; =========================

    ; nibble alto
    mov al, bl
    shr al, 4
    and al, 0Fh

    cmp al, 9
    jle .h1
    add al, 7
.h1:
    add al, '0'
    mov [hex], al

    ; nibble bajo
    mov al, bl
    and al, 0Fh

    cmp al, 9
    jle .h2
    add al, 7
.h2:
    add al, '0'
    mov [hex+1], al

    ; abrir archivo
    mov rax, 2
    mov rdi, fname
    mov rsi, 577
    mov rdx, 0644o
    syscall

    mov rbx, rax

    ; escribir resultado
    mov rax, 1
    mov rdi, rbx
    mov rsi, hex
    mov rdx, 2
    syscall

    ; cerrar
    mov rax, 3
    mov rdi, rbx
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall