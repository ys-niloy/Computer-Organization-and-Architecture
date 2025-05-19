.model small
.stack 100h
.data  

 
.code
    main proc
    mov ax, @data
    mov ds, ax
    MOV CL, 4 ; for shifting the value 4 times
    
    mov BX, 0 ; clear BX
    
    mov ah, 1
    
    input:
        int 21h
        cmp al, 13
        je output_
        cmp al, 41h
        jge letter
        sub al, 30h
    
    jmp shift
    
    letter:
        sub al, 37h
        
    shift:
        shl bx, cl
        or bl, al
    jmp input
    
        
    output_:
         mov ah, 2
         mov dl, 10
         int 21h
         mov dl, 13
         int 21h
         
         mov cx, 4
         mov ah, 2
         
    output_1:
         mov dl, bl
         and dl, 0Fh
         cmp dl, 10
         jge outputletter
         add dl, 30h
         int 21h
         jmp loop_
         
    outputletter:
         add dl, 37h
         int 21h
         jmp loop_
    
    loop_:
         loop output_1
     
     
    
        mov ah, 4ch
        int 21h 
    
  
main endp 
    end main