default rel
global _start

section .bss
    cycles resb 1

section .rodata
    star db '*'
    newline db 10

section .text
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, cycles
    mov rdx, 1
    syscall
    movzx r12, byte [cycles]
    sub r12, '0'
    test r12, r12
    jz .done

.loop:
    mov rax, 1
    mov rdi, 1
    mov rsi, star
    mov rdx, 1
    syscall

    dec r12
    jnz .loop

.done:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
