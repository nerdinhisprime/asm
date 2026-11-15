global _start
BUF_SIZE equ 32

section .bss
    buf resb BUF_SIZE

section .rodata
    zero db 'ZERO', 10
    zero_len equ $ - zero
    minus db 'MINUS', 10
    minus_len equ $ - minus
    plus db 'PLUS', 10
    plus_len equ $ - plus

section .text
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, BUF_SIZE
    syscall

    cmp byte [buf], '-'
    je .is_minus
    cmp byte [buf], '0'
    je .is_zero

    mov rsi, plus
    mov rdx, plus_len
    jmp .print

.is_minus:
    mov rsi, minus
    mov rdx, minus_len
    jmp .print

.is_zero:
    mov rsi, zero
    mov rdx, zero_len

.print:
    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
