jmp near start

message db '1+2+3+...+100=';

start:
        mov ax,0x07c0
        mov ds,ax   ;设置数据段
        mov ax,0xb800
        mov es,ax
        ;
        mov si,message
        mov di,0
        mov cx,14
        mov ah,0x07
    @g:
        lodsb
        stosw
        loop @g
        ;以下计算1-100的和
        xor ax,ax
        mov cx,1
    @f:
        add ax,cx
        inc cx
        cmp cx,100
        jle @f
        ; 下面计算累加和的每个数位
        xor cx,cx
        mov ss,cx
        mov sp,cx
        mov bx,10 ;作为除数
        xor cx,cx ;为什么这里要设置两遍
    @d:
        inc cx ;这里push进去多少次，那里等一会就弹出去多少次
        xor dx,dx
        div bx
        or dl,0x30 ;将数字转换为assic字符
        push dx
        cmp ax,0
        jne @d
    ;取数进行展示
    @a:
        pop dx
        mov byte [es:di],dl
        inc di
        mov byte [es:di],0x07
        inc di
        loop @a

        jmp near $
times 510-($-$$) db 0
db 0x55,0xaa    

