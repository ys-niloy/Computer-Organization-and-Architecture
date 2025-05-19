.model small
.stack 100h
.data  

 
.code
    main proc
    mov ax, @data
    mov ds, ax
    MOV CL, 4 ; for shifting the value 4 times
    
    mov BX, 0 ; clear BX
    
    mov ah, 1 ;input
    
    input:
        int 21h
        cmp al, 13
        je output_
        cmp al, 41h
        jge letter
        sub al, 30h
    
    jmp shift
    
    letter:
        sub al, 37h ; if input A then store 10h
        
    shift:
        shl bx, cl ; creating space in end of bx
        or bl, al ; set the value of al
    jmp input
    
        
    output_:
        mov ah, 2
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        
        mov cx, 16
        
    output_1:
        shl bx, 1
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
        