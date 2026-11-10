global _start
global after_add

section .text
_start:
  mov rax, 100
  mov rbx, 30

  add rax, rbx

after_add:
  sub rax, 10
  mov rdi, 60
  syscall
