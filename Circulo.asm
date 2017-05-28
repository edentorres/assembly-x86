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
    mov radio, 20
    mov origen_x, 32
    mov origen_y, 32
    
    call radiocuad
    
primer:    
    mov dx, origen_y
    xor ax, ax
    mov al, radio
    
    sub dx, ax
    
    mov cx, origen_x
    
    call paint
lop: 
    mov dl, radio
    cmp dl, x
    jng fin
    mov y, 0 
    
    mov al, x
    add al, 1
    mov x, al 
    
    call xcuad
    pop cx
lup:
    call ycuad
    pop bx
    add cx, bx
    cmp cx, r2
    jg dibu
    jmp y_pp
    
y_pp:
    mov al, y
    add al, 1
    mov y, al
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
    pop bx
    push ax
    push bx
endp 
ret

ycuad proc ;guarda en cx
    xor ax, ax
    mov al, y
    xor bx, bx
    mov bl, y
    mul bl
    pop bx
    push ax
    push bx
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