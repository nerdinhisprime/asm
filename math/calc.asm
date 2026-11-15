default rel
BUF_SIZE equ 32

section .bss
  inbuf resb BUF_SIZE
  outbuf resb BUF_SIZE

section .text
global _start

_start:
  mov rax, 0
  mov rdi, 0
  mov rsi, inbuf
  mov rdx, BUF_SIZE
  syscall

  mov rsi, inbuf
  call atoi
  call itoa

  mov rsi, rdi
  lea rdx, [outbuf + BUF_SIZE]
  sub rdx, rsi
  mov rax, 1
  mov rdi, 1
  syscall

  mov rax, 60
  mov rdi, 0
  syscall

atoi:
  xor eax, eax
.loop:
  movzx ecx, byte [rsi]
  sub ecx, '0'
  cmp ecx, 9
  ja .done
  imul rax, 10
  add rax, rcx
  inc rsi
  jmp .loop
.done:
  ret

itoa:
  lea rdi, [outbuf + BUF_SIZE]
  mov rcx, 10
.next:
  xor edx, edx
  div rcx
  add dl, '0'
  dec rdi
  mov [rdi], dl
  test rax, rax
  jnz .next
  ret
