default rel
BUF_SIZE equ 32

section .bss
  buf resb BUF_SIZE

section .text
global _start
_start:
  call read
  call atoi
  mov r12, rax

  call read
  call atoi
  add rax, r12

  call itoa

  mov eax, 1
  mov edi, 1
  syscall

  mov eax, 60
  xor edi, edi
  syscall

itoa:
  lea rdi, [buf + BUF_SIZE]
  mov ecx, 10
  .itoa_loop:
    xor edx, edx
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .itoa_loop
  mov rsi, rdi
  lea rdx, [buf + BUF_SIZE]
  sub rdx, rsi
  ret

read:
  xor eax, eax
  xor edi, edi
  mov rsi, buf
  mov edx, BUF_SIZE
  syscall
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
