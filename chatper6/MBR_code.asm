; desc:硬盘主引导扇区代码
; data:2023/12/8
section .data
    ;hello_string db 'hello world',0 ;定义数据部分 这里会移到文件末尾，我们还是放到代码段中去
section .text
    global _start   ;定义切入点
_start:
    ORG 0X7C00      ;装到主引导区域
    MOV AX,0XB800
    MOV ES,AX
    hello_string db 'hello world',0;下面显示字符串 'hello world'
    MOV DI,0     ;设置偏移量0x00,di目的变址寄存器
    MOV DI,0     ;设置偏移量0x00,di目的变址寄存器
    MOV CX,11     ;字符串长度   
    MOV SI, hello_string
    MOV AH,0X07     ;背景色
WRITE_LOOP:
    LODSB
    STOSW
    loop WRITE_LOOP
    infi: jmp near infi    
    times 510-($-$$) db 0
    DB 0x55,0xAA
; 为什么会吃掉一条指令？为什么定义在数据区会没有东西？