
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
    cmp al, 008H
    je borrar    
    
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
borrar:
    mov ax, num
    mov dx, 0000h
    mov bx, 10
    div bx
    mov num,ax
    jmp loop_1
borrar_2:
    cmp num2,0
    je loop_1
    mov ax, num2
    mov dx, 0000h
    mov bx, 10
    div bx
    mov num2,ax
    jmp loop_2    
loop_2: 
    mov ah, 1
    int 21h 
    cmp al, 3Dh
    je  operar
    cmp al,'-'
    je  negative2
    cmp al, 008H
    je borrar_2  
    
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
oper_1:
    cmp signo2,1
    je niego2
oper_2:
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
    neg num
    jmp oper_1
niego2:
    neg num2
    jmp oper_2 

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
    cmp signo, 1
    je div_neg_1
divi_1:
    cmp signo2, 1
    je div_neg_1
divi_2:    
    mov dx, 0
    div bx
    mov dh, signo
    cmp dh, signo2
    jne div_neg_res
    mov num,ax
    jmp count_0
    
div_neg_1:
    neg ax
    jmp divi_1
div_neg_2:
    neg bx
    jmp divi_2
    
div_neg_res:
    neg ax
    mov num, ax
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