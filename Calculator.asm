
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
jmp main

num dd ?
count dd 1
num2 dd ?
signo db 0
signo2 db 0

main:
    jmp loop_1
    
loop_1:
    
    mov ah, 1
    int 21h
    mov cl,al
    
    cmp al,'+' ;0Dh enter
    je  loop_2
    cmp al,'-'
    je  negative 
    cmp al,'*'
    je  loop_2
    cmp al,'/'
    je  loop_2    
    
    mov bl, al
    sub bl, 30h ; queda en bx el numero actual
    mov bh, 00h
    
    mov ax, num
    mov dx, 10
    mul dx ; consigo el numero corrido
    add bx, ax
    mov num, bx
    
    jmp loop_1
    
negative:
    cmp num,0
    jne loop_2
    mov signo,1
    jmp loop_1
negative2:
    mov signo2,1
    jmp loop_2
loop_2:
    
    mov ah, 1
    int 21h 
    cmp al, 3Dh
    je  operar
    cmp al,'-'
    je  negative2  
    
    mov bl, al
    sub bl, 30h ; queda en bx el numero actual
    mov bh, 00h
    
    mov ax, num2
    mov dx, 10                 
    mul dx ; consigo el numero corrido
    add bx, ax
    mov num2, bx
    
    jmp loop_2
    
operar:
    cmp signo,1
    je  niego
    cmp signo2,1
    je niego2

    mov ax,num
    mov bx, num2
    cmp cl,'+' ;0Dh enter
    je  suma
    cmp cl,'-'
    je  resta 
    cmp cl,'*'
    je  mult
    cmp cl,'/'
    je  divi
niego: 
    mov ax, num
    mov dx,0000h
    mov bx, -1
    mul bx
    mov num, ax
    mov signo,0
    jmp operar
niego2: 
    mov ax, num2
    mov dx,0000h
    mov bx, -1
    mul bx
    mov num2, ax
    mov signo2,0
    jmp operar 

suma:    
    add ax, bx
    mov num,ax
    jmp count_0
resta:
    sub ax,bx
    mov num,ax
    jmp count_0
mult:
    mul bx
    mov num,ax
    jmp count_0
divi:
    div bx
    mov num,ax
    jmp count_0    
count_0:
    mov ax, count
    mov dx,num
    cmp num,0
    jng negar    
    mov ax, count
    cmp ax,num
    jg count_dec
    mov bx, 10
    mul bx
    mov count, ax    
    jmp count_0
negar:
    mov ax, num
    mov dx,0000h
    mov bx, -1
    mul bx
    mov num, ax
    mov dx, 0f0h
    mov ah,2
    int 21h
    jmp count_0    
count_dec:
    mov dx, 0000h
    mov ax, count
    mov cx, 10
    div cx  
    mov count, ax    
loop_out:          
    mov dx, 0000h
    mov ax, num
    mov cx, count
    div cx
    mov num,dx
    mov bx,ax           
mostrar: 
    mov dx,bx
    add dx,30h
    mov ah, 2
    int 21h
    cmp count, 1
    je fin
    jmp count_dec

fin:
ret