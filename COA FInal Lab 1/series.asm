.model small
.stack 100h

.data
A DW ?    ; define word
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5
    mov ax, 0
    mov bx, 1

    SUM:
    add ax, bx
    add bx, 4

    mov A, ax
    loop SUM

    end main 
    
    ; series is 1 + 5 + 9 + 13