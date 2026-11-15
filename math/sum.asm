global _start

BUF_SIZE equ 32

section .bss
  inbuf  resb BUF_SIZE
  outbuf resb BUF_SIZE

section .text

parse:
  xor eax, eax              ; обнуляет
.next:
  movzx ecx, byte [rsi]
  sub ecx, '0'
  cmp ecx, 9
  ja .done
  imul rax, rax, 10
  add rax, rcx
  inc rsi
  jmp .next
.done:
  ret

_start:
  ; первое число
  mov rax, 0
  mov rdi, 0
  mov rsi, inbuf
  mov rdx, BUF_SIZE
  syscall
  mov rsi, inbuf
  call parse
  mov r8, rax

  ; второе число
  mov rax, 0
  mov rdi, 0
  mov rsi, inbuf
  mov rdx, BUF_SIZE
  syscall
  mov rsi, inbuf
  call parse

  add rax, r8

  ; число -> строка (справа налево)
  mov rdi, outbuf + BUF_SIZE - 1
  mov byte [rdi], 10
  mov rcx, 10
.digits:
  xor edx, edx
  div rcx
  add dl, '0'
  dec rdi
  mov [rdi], dl
  test rax, rax
  jnz .digits

  ; вывод
  mov rsi, rdi
  mov rdx, outbuf + BUF_SIZE
  sub rdx, rsi
  mov rax, 1
  mov rdi, 1
  syscall

  mov rax, 60
  mov rdi, 0
  syscall
