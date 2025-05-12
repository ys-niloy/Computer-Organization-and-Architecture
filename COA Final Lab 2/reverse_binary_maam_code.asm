.model small
.stack 100h

.data
txt db "Enter a binary value: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, txt
    int 21h
    
    
    xor bx, bx
    mov cx, 16
    
 input_:
    mov ah, 1
    int 21h
    cmp al, 13
    je output_
    sub al, 30h
    shl bx, 1
    or bl, al
    loop input_ 
    
 
    
 output_:
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    
    mov cx, 16
    
 output_1:
    shr bx, 1
    jnc zero
    mov ah, 2
    mov dl, 31h
    int 21h
    jmp loop_
    
 zero:
 mov ah, 2
    mov dl, 30h
    int 21h
    jmp loop_
    
 loop_:
    loop output_1
 
 

    mov ah, 4ch
    int 21h 
    
  main endp
end main
