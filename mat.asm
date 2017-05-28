org 100h

jmp main

w db 100
h db 100
color db 1

x dw ?
y dw ?

mat db 10000 dup(?)

main:
    mov ah, 0
    mov al, 13h
    int 10h
    
    call clear

clear: proc
    jmp sum_x
back:          
endp
ret

sum_x:
    mov y, 00h
    inc x
    inc color
    xor ax, ax
    mov al, w
    sub ax, 1
    cmp ax, x
    jle back
b_sum_x:
    xor bx, bx
    mov bl, h
    sub bx, 1
    cmp bx, y
    je sum_x   
    inc y    
pixel_w:
    mov cx, x
    mov dx, y 
    mov al, color
    mov ah,0Ch
    int 10h
    jmp b_sum_x