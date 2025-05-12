.model small
.stack 100h

.data

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 255
    
   
    print:
    mov ah, 02      
    mov dl, cl       
    int 21h
    
    loop print
    
               
    
    
    mov ah, 4ch
    int 21h

main endp
end main
