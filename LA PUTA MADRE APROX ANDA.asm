org 100h

jmp main

radio db ?
r2 dw ?
origen_x dw ?
origen_y dw ?

x db ?
y db ?

main:
    mov ah, 0
    mov al, 13h
    int 10h
    ;set de la pantalla
    mov radio, 30
    mov origen_x, 50
    mov origen_y, 50
    
    call radiocuad
    
primer:    
    mov dx, origen_y
    xor ax, ax
    mov al, radio
    
    sub dx, ax ; dx primer punto
    
    mov cx, origen_x ;cx primer punto
    
    call paint ;dibujo de punto
lop: 
    mov dl, radio
    cmp dl, x ;punto max de x es origen+radio
    jng fin
    
    mov y, 0 
    
    inc x 
    
    call xcuad
lup:
    call ycuad
    add cx, bx
    cmp cx, r2 ; xcuad + ycuad = rcuad
    jg dibu
    jmp y_pp
    
y_pp:
    inc y
    jmp lup
    
dibu:
    xor cx, cx
    xor dx, dx
    
    mov cl, x
    add cx, origen_x
    mov dx, origen_y  
    sub dl, y 
    call paint
    inc dx
    call paint
    jmp lop    
    
paint proc
    mov al, 15
    mov ah, 0Ch
    int 10h
endp  
ret

xcuad proc ;guarda en bx
    xor ax, ax
    mov al, x
    xor bx, bx
    mov bl, x
    mul bl
    mov bx, ax
endp 
ret

ycuad proc ;guarda en cx
    xor ax, ax
    mov al, y
    xor cx, cx
    mov cl, y
    mul cl
    mov cx, ax
endp
ret

radiocuad proc
    xor ax, ax
    mov al, radio
    xor bx, bx
    mov bl, radio
    mul bl
    mov r2, ax
endp
ret

fin:
    
ret