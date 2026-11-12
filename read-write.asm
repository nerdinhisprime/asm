global _start

section .bss
  buf resb 64

section .text
_start:
  mov rax, 0
  mov rdi, 0
  mov rsi, buf
  mov rdx, buf
  syscall

  mov rdx, rax
  mov rax, 1
  mov rdi, 1
  mov rsi, buf
  syscall

  mov rax, 60
  mov rdi, 0
  syscall
