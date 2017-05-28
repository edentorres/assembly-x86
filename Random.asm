
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
modulo dd ?
num dd ?
count dd 1 
jmp main

main:
loop_in:
     mov ah, 1
     int 21h
     
     cmp al, '%'
     je random
     
     mov bl, al
     sub bl, 30h ; queda en bx el numero actual
     mov bh, 00h
    
     mov ax, modulo
     mov dx, 10
     mul dx ; consigo el numero corrido
     add bx, ax
     mov modulo, bx
     jmp loop_in
random:
     mov ah,0      
     int 1ah       ;busca cant de ticks
     mov bx,modulo
     mov ax, dx
     xor dx,dx
     div bx
     mov num,dx            ;guarda el modulo
count_0:
    mov ax, count
    mov dx,num
    cmp num,0
    je loop_out   
    cmp ax,num          ;cuenta 0
    jg count_dec
    mov bx, 10
    mul bx
    mov count, ax    
    jmp count_0
count_dec:
    mov dx, 0000h
    mov ax, count            ;saca un 0
    mov cx, 10
    div cx  
    mov count, ax 
loop_out:          
    mov dx, 0000h
    mov ax, num
    mov cx, count
    div cx                ;divide
    mov num,dx
    mov bx,ax           
mostrar: 
    mov dx,bx
    add dx,30h
    mov ah, 2
    int 21h
    cmp count, 1
    je loop_in
    jmp count_dec

fin:     
ret