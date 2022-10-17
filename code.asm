.model small
.stack
.data
    m1 db 10, 13, "Enter"
    m2 db 10, 13, "Enter number is :$"
    num db ?

.code
.startup

mov num, 7


; mov dl, num
; add dl, 48
; mov ah, 2
; int 21h


;OUTPUT CODE STARTS HERE

mov ah, 0
mov al, 47
; MOV AX,73 ;AX = N = 25
MOV DX,0 ;DX = 0
MOV BX,10 ;BX = 10
MOV CX,0 ;CX = 0 => COUNTER REGISTER
L1:
DIV BX ;DIVIDE => AX = AX / BX
;IN CASE OF 8 BIT REGISTER => AL = QUOTIENT, AH = REMAINDER
;IN CASE OF 16 BIT REGISTER => AX = QUOTIENT, DX = REMAINDER
;AX = 2 , DX = 5
PUSH DX ;5 SAVE IN STACK
MOV DX,0 ;DX = 0
MOV AH,0 ;AX AH = 00000000, AL = QUOTIENT
INC CX ;CX = CX + 1
CMP AX,0 ;(2 == 0)
JNE L1 ;JUMP NOT EQUAL => AX != 0
MOV AH,2 ;OUTPUT/PRINT A SINGLE CHARACTER
L2:
POP DX ;FIRST TIME POP 2 AND SECOND TIME POP 5 = 25
ADD DX,48
INT 21H
LOOP L2
;OUTPUT CODE ENDS HERE






; mov bl, 16
; add bl, 30h
; mov al,bl

; and al, 0f0h
; shr al, 04h
; add al, 30h

; mov num, al

; mov dl,al
; mov ah,02
; int 21h






; mov bl, num

; and bl, 0f0h

; mov cl, 04h

; shr bl, cl

; add bl, 30h

; mov dl, bl
; mov ah, 02
; int 21h

; ;///////////////////////

; mov bl, num

; and bl, 0fh

; ; mov cl, 04h

; ; shr bl, cl

; add bl, 30h

; mov dl, bl
; mov ah, 02
; int 21h



.exit
end