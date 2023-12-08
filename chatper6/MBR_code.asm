; desc:硬盘主引导扇区代码
; data:2023/12/8
section .data
    ;hello_string db 'hello world',0 ;定义数据部分 这里会移到文件末尾，我们还是放到代码段中去
section .text
    global _start   ;定义切入点
_start:
    ORG 0X7C00      ;装到主引导区域
    hello_string db 'hello world',0
    MOV AX,0XB800
    MOV ES,AX
    ;下面显示字符串 'hello world'
    MOV DI,0x00     ;设置偏移量0x00,di目的变址寄存器
    MOV CX,11     ;字符串长度
    LEA SI, [hello_string]
    MOV AH,0X07     ;背景色
WRITE_LOOP:
    MOV AL,[SI]
    INC SI
    STOSW
    loop WRITE_LOOP
    infi: jmp near infi    
    times 510-($-$$) db 0
    DB 0x55,0xAA
