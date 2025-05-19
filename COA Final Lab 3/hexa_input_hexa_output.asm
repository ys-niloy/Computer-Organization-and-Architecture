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
         mov dl, bh
         shr dl, 4
         rol bx, 4
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

just use shl, shr, rol, ror to print the hexa output in reverse order like if input is: A123 the output should be 321A

.model small
.stack 100h
.data  

.code
    main proc
    mov ax, @data
    mov ds, ax
    MOV CL, 4 ; number of bits to shift for each hex digit (4 bits per hex digit)
    
    mov BX, 0 ; clear BX
    
    mov ah, 1
    
input:
    int 21h            ; get character input from user
    cmp al, 13         ; check if Enter key (13 in ASCII)
    je output_         ; jump to output if Enter is pressed
    cmp al, 41h        ; check if al >= 'A' (ASCII 41h)
    jge letter         ; jump to letter processing if al is a letter
    sub al, 30h        ; convert from ASCII '0'-'9' to numerical value
    
    jmp shift          ; jump to shift and store in BX
    
letter:
    sub al, 37h        ; convert from ASCII 'A'-'F' to numerical value
    
shift:
    shl bx, cl         ; shift left by 4 bits to make space for the new hex digit
    or bl, al          ; store the new hex digit in the lower byte of BX
    jmp input          ; continue to read the next input character
    
output_:
    mov ah, 2          ; DOS function to print character
    mov dl, 10         ; print newline (ASCII 10)
    int 21h
    mov dl, 13         ; print carriage return (ASCII 13)
    int 21h

    mov cx, 4          ; number of hex digits to output
    mov ah, 2          ; DOS function to print character
    
output_1:
    ; Print the first (most significant) hex digit
    mov dl, bh         ; move high byte of BX into DL
    shr dl, 4          ; shift the high byte right by 4 bits to isolate the top hex digit
    cmp dl, 10         ; check if digit is >= 10
    jge outputletter   ; if so, it's 'A'-'F'
    add dl, 30h        ; convert to ASCII '0'-'9'
    int 21h            ; print the character
    jmp loop_
    
outputletter:
    add dl, 37h        ; convert to ASCII 'A'-'F'
    int 21h            ; print the character
    jmp loop_
    
loop_:
    rol bx, 4          ; rotate BX left by 4 bits to move to the next digit
    loop output_1      ; loop for all 4 digits
    
    mov ah, 4Ch        ; DOS function to exit the program
    int 21h            ; terminate program

main endp
end main
