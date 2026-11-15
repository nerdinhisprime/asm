default rel
BUF_SIZE equ 16

section .bss
  buf resb BUF_SIZE

section .rodata
  star db '*'
  newline db 10

section .text
global _start

_start:
  mov rax, 0
  mov rdi, 0
  mov rsi, buf
  mov rdx, BUF_SIZE
  syscall

  call atoi
  mov r12, rax
  call print

  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall

  mov rax, 60
  mov rdi, 0
  syscall

print:
  test r12, r12
  jz .print_ret
  .print_loop:
    mov rax, 1
    mov rdi, 1
    mov rsi, star
    mov rdx, 1
    syscall

    dec r12
    jnz .print_loop
    .print_ret:
      ret

atoi:
  xor eax, eax
  .atoi_loop:
    movzx ecx, byte [rsi]
    sub ecx, '0'
    cmp ecx, 9
    ja .atoi_ret
    imul eax, eax, 10
    add eax, ecx
    inc rsi
    jmp .atoi_loop
    .atoi_ret:
      ret
