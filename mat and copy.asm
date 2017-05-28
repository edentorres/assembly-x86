org 100h

jmp main

w db 10
h db 10

x dw ?
y dw ?

mat db 100 dup(15)

main:
    mov ah, 0
    mov al, 13h
    int 10h ;set de la pantalla
    
    call clear
    call draw
    jmp fin
    
clear: proc
sum_x:
    xor ax, ax
    mov al, w
    ;sub ax, 1
    cmp ax, x
    je fin ;chquea x
a_sum_x:
    mov cx, x
    mov dx, y
    jmp pixel_w
b_sum_x:
    xor bx, bx
    mov bl, h
    sub bx, 1
    cmp bx, y
    jne sum_y ;chequea y
    mov y, 00h
    inc x
    jmp sum_x
    
sum_y:
    inc y
    jmp a_sum_x
    
pixel_w: 
    mov al, 15
    mov ah, 0Ch
    int 10h
    jmp b_sum_x
back:          
endp
ret

draw proc
   lea si, mat
add_x:   
   xor bx, bx
   mov bx, x
   cmp bx, w.w
   je f_draw ; si llego al maximo de x
   
dibujo:
   mov cx, x
   mov dx, y
   
   mov ax, w.h
   mul cx
   add ax, dx
   inc ax
   mov di, ax
   cmp di, 100 ; w*h
   jg f_draw
   add di, si
   ;(h*x)+y+1
   mov al, b.[di]
   call paint
        
   xor cx, cx
   mov cx, y
   cmp cx, w.h
   jne add_y
   
   mov y, 0
   inc x
   jmp add_x
   
add_y:
   inc y
   jmp dibujo
   
f_draw:   
endp
ret

paint proc
   mov ah, 0Ch
   int 10h 
endp
ret

fin:
    ret