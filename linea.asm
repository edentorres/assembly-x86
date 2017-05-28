name "linea"

org 100h

jmp main

y_1 db ?
y_2 db ?
x_1 db ?
x_2 db ?

dx_2 dw ?
dy_2 dw ?

y db ?
x db ?

delta_x db ?
delta_y db ?

d db ?

draw_line MACRO x_o, y_o, x_f, y_f
    mov x_1, x_o
    mov y_1, y_o
    mov x_2, x_f
    mov y_2, y_f
    
    mov al, x_2
    sub al, x_1
    
    mov ah, y_2
    sub ah, y_1
    
    mov delta_x, al
    mov delta_y, ah
    
    mov ax, w.delta_y
    mov dx, 2
    mul dx
    mov dy_2, ax ;guardo dx*2
    
    sub ax, w.delta_x
    mov d, al
    
    mov al, delta_x
    mov dl, 2
    mul dl
    mov dx_2, ax ;guardo dy*2
    
    xor cx, cx
    xor dx, dx
    
    mov cl, x_1
    mov dl, y_1
    call paint
    
    mov al, y_1
    mov y, al
    
    mov al, x_1
    mov x, al
    
lup:
    inc x
    mov al, x_2
    cmp x, al
    je fin
    
    cmp d, 0
    jg mayor
    jmp menor
    
mayor:
    inc y
    
    xor cx, cx
    xor dx, dx
    
    mov cl, x
    mov dl, y
    call paint
    
    mov ax, dy_2
    sub ax, dx_2
    mov bx, w.d
    add bx, ax
    mov d, bl
    jmp lup
     
menor:
    ;dec y
    xor cx, cx
    xor dx, dx
    mov cl, x
    mov dl, y
    call paint
    
    mov bl, d
    add bl, b.dy_2
    mov d, bl
    jmp lup
    
paint proc 
   mov al, 15
   mov ah, 0Ch
   int 10h 
endp
ret
ENDM

main:
    mov ah, 0
    mov al, 13h
    int 10h
    draw_line 30, 40, 70, 200

fin:
    ret