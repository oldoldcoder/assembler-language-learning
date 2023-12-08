section .data
    hello db 'Hello, World!',0

section .text
    global _start

_start:
    ; write Hello, World! to stdout
    mov eax, 4        ; syscall: sys_write
    mov ebx, 1        ; file descriptor: stdout
    mov ecx, hello    ; pointer to the message
    mov edx, 13       ; message length
    int 0x80          ; interrupt to invoke syscall

    ; exit the program
    mov eax, 1        ; syscall: sys_exit
    xor ebx, ebx      ; exit code 0
    int 0x80          ; interrupt to invoke syscall
