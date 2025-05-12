.model small
.stack 100h

.data
A DW ?    ; define word
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 20
    mov ax, 0
    mov bx, 100

    SUM:
    add ax, bx 
    sub bx, 5

    mov A, ax
    loop SUM
    
    end main
    
    
    ; series is 100 + 95 + 90 + ....... + 5 