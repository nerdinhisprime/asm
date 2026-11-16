default rel
BUF_SIZE equ 32

section .bss
  inbuf resb BUF_SIZE
  outbuf resb BUF_SIZE

section .text
global _start

_start:
  xor eax, eax
  xor edi, edi
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
  xor edx, edx    ; обнуляем rdx|edx|dx|dl
  div rcx         ; rdx | rax : rcx = частное в (rax), остаток в (rdx)
  add dl, '0'     ; остаток из dl (RDX версия в которой лежит остаток) + 48
  dec rdi         ; читаем символ левее
  mov [rdi], dl   ; пишем сумму dl + 48 в байт rdi левее
  test rax, rax   ; если они не 0 то:
  jnz .next       ; перемещаемся в .next
  ret
