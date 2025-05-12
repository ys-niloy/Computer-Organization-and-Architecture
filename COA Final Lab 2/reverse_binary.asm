.model small
.stack 100h

.data
txt db "Enter a binary value (16 bits): $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Print the prompt
    mov ah, 9
    lea dx, txt
    int 21h
    
    ; Clear BX (will hold the binary value)
    xor bx, bx
    mov cx, 16     ; We expect 16 bits of input
    
input_:
    mov ah, 1      ; Read a character from user
    int 21h
    cmp al, 13     ; Check if input is carriage return (Enter key)
    je output_     ; If Enter is pressed, proceed to output
    sub al, 30h    ; Convert ASCII '0' or '1' to binary (0 or 1)
    shl bx, 1      ; Shift BX left to make room for the next bit
    or bl, al      ; Set the least significant bit of BX
    loop input_    ; Repeat until we've processed 16 bits
    
output_:
    ; Print a newline
    mov ah, 2
    mov dl, 10     ; Newline character
    int 21h
    mov dl, 13     ; Carriage return
    int 21h
    
    ; Output the original binary value
    mov cx, 16
    mov ax, bx     ; Copy value from BX to AX for output
    
output_1:
    shl ax, 1      ; Shift AX left
    jnc zero       ; If no carry, print '0'
    mov ah, 2
    mov dl, 31h    ; '1' character
    int 21h
    jmp loop_
    
zero:
    mov dl, 30h    ; '0' character
    int 21h
    
loop_:
    loop output_1  ; Repeat until all 16 bits are printed
    
    ; Now reverse the bits in BX
    xor ax, ax     ; Clear AX (will hold the reversed bits)
    mov cx, 16     ; 16 bits to reverse
    
reverse:
    shl bx, 1      ; Shift BX left (MSB moves to carry)
    rcr ax, 1      ; Rotate carry into AX (building reversed bits)
    loop reverse   ; Repeat for all 16 bits
    
    ; Print the reversed binary value
    mov cx, 16
    mov bx, ax     ; Reversed value is now in AX, move to BX for output

    ; Print a newline
    mov ah, 2
    mov dl, 10     ; Newline character
    int 21h
    mov dl, 13     ; Carriage return
    int 21h
    
    ; Output the reversed binary value
    mov ax, bx     ; Copy reversed value to AX for output
    
output_reversed:
    shl ax, 1      ; Shift AX left
    jnc zero_reversed
    mov ah, 2
    mov dl, 31h    ; '1' character
    int 21h
    jmp loop_reversed
    
zero_reversed:
    mov dl, 30h    ; '0' character
    int 21h
    
loop_reversed:
    loop output_reversed
    
    ; Exit program
    mov ah, 4Ch
    int 21h
    
main endp
end main
