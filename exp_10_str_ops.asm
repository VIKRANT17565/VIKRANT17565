.model small
;******  Data Segment ******
.data
menu db 10,13, "Menu: "
     db 10,13, "1.Length of string "
     db 10,13, "2.Count spaces "
     db 10,13, "3.Reverse "
     db 10,13, "4.Check for palindrome "
     db 10,13, "5.Concatenate "
     db 10,13, "6.Enter another string "
     db 10,13, "7.Exit  "
     db 10,13, "  "
     db 10,13, "Your choice: $"
msg1 db 10,13, "Your choice is: $"
mc1 db 10,13, "case 1 $"
mc2 db 10,13, "case 2 $"
mc3 db 10,13, "case 3 $"
mc4 db 10,13, "case 4 $"
mc5 db 10,13, "case 5 $"
mc6 db 10,13, "Exiting the program $"
mc7 db 10,13, "Invalid choice....try again $"
empty db 10,13, "   $"
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
len db ?
mstring db 10,13, "Enter the string: $"
notpalin db 10,13, "String is not a palindrome. $"
palin db 10,13, "String is a palindrome. $"
mstring2 db 10,13, "Enter second string: $"
mconcat db 10,13, "Concatenated string: $"
mscount db 10,13, "Number of spaces: $"
mlength db 10,13, "Length is: $"
mreverse db 10,13, "Reversed string: $"
scount db ?

;********** Code Segment ************
.code

print macro m
        mov ah,09h
        mov dx,offset m
        int 21h
endm

start:
mov ax,@data
mov ds,ax

print mstring
call accept_string   ;function call to accept a string

again:

print menu
call accept  ;accept user choice
mov bl,al


case1:

        cmp bl,"1"    ;compare user choice with '1'
        jne case2     ;if not equal,check for case 2

        print mc1           
        print empty         
        ; print mstring
        ; call accept_string   ;function call to accept a string

        mov cl,str1+1        ;storing length in cl
        mov bl,cl             
        print mlength       
        call display1        ;printing the length
        print empty
        jmp again            ;printing the menu again

case2:  cmp bl,"2"         ;checking user choice for case 2
        jne case3          ;if not equal,check for case 3
        print mc2
        print empty
        
        ; print mstring
        ; call accept_string
        mov si,offset str1+2  ;position si to start of the string
        
        mov cl,str1+1         ;copy length in cl
        mov dh,00             ;counter to store number of spaces  
        cmpagain1:  mov al,[si]      ;copy content at memory location "si" in "al"
                cmp al,' '        ;compare "al" with space
                jne below         ;if not equal jump to label below
                inc dh
                
        below:  inc si               ;move to next character
                dec cl               ;decrement string length counter
                jnz cmpagain1        ;if not zero check again
        
        mov scount,dh       ;save the count in memory location "scount"
        mov bl,scount       ;copy count to "bl" for printing 
        print mscount
        call display1
        print empty     
                
        jmp again


case3:  cmp bl,"3"         ;checking user choice afor case 3
        jne case4          ;if not equal,check for case 4
        print mc3
        print empty
        ; print mstring
        ; call accept_string
        
        print mreverse

        lea si, str1+2
        mov cl, str1+1
        ; add cl, 30h

        BACK1:
                MOV DX, [SI]
                PUSH DX
                INC SI
                DEC CL
                JNZ BACK1
        
                
        MOV CL,str1+1
        ; add cl, 30h
        BACK2:
                POP DX
                MOV AH, 02
                INT 21H
                INC SI
                DEC CL
                JNZ BACK2

        jmp again

        ; mov si,offset str1      ;point si to start of string1 

        ; mov di,offset str2      ;point di to start of string2



        ; mov al,[si]         ;copy first two locations of string1 to string2
        ; mov [di],al         ;since these contain the size and length of the string
        ; inc si              ;which are same in reverse string also
        ; inc di


        ; mov al,[si]
        ; mov [di],al
        ; inc si
        ; inc di

        ; mov cl,str1+1 ;        copy length in cl
        ; mov ch,00              
        ; add si,cx              ;add length of string1 to si to move it to last location
        ; dec si                 ;si at last location of string1
        
; move_more: mov al,[si]       ;copying character one by one from string1 pointed by si
;            mov [di],al       ; to string2 pointed by "di" in reverse order as si moves
;            dec si            ; from last character to first character 
;            inc di
;            dec cl
;            jnz move_more

        
;         print mreverse
;         print str2+2     ;  printing the reversed string
;         print empty

;         mov ah,00
;         mov al,cl
;         jmp again

case4:  cmp bl,"4"         ;checking for case 4
        jne case5          ;if not equal jump to case 5
        print mc4
        print empty
        ; print mstring
        ; call accept_string
        

        mov si,offset str1
        mov cl,str1+1        ;store the length
        mov ch,00h
        mov len,cl
        inc si
        add si,cx            ;si points to last
                
        mov di,offset str1   ;di to start of string
        add di,0002h         ;di to actual start of string;
        
        ;in string 0th byte->size
        ;          1st byte->length of string
        ;          from 2nd byte->actual string         
         
        mov cl,len ;load counter
        cmpagain: 
                mov al,[si]
                mov ah,[di]
                inc di
                dec si
                cmp al,ah
                jne nopalin
                dec cl
                jnz cmpagain
        
        print palin
        print empty
        jmp again  

        nopalin: print notpalin     
                print empty
                jmp again

case5: 
        cmp bl,"5"       ;check for case 5
        jne case6        ;if not equal check for case 6
        print mc5 
        print empty
        
        ;        print mstring
        ;        call accept_string     
        
        ;storing string in str2
        print mstring2
        mov ah,0ah
        lea dx,str2
        int 21h
        
        
        mov cl,str1+1         ;length of string1 in cl
        mov si,offset str1    ; or lea si, str1
        next:  
                inc si
                dec cl
                jnz next
        inc si
        
        inc si
        mov di,offset str2
        inc di
        inc di
        
        
        mov cl,str2+1
        move_next:
                
                mov al,[di]
                mov [si],al
                inc si
                inc di
                dec cl
                jnz move_next
        
        print mconcat
        ; print str1+2
        mov bl, str1+1
        mov al, str2+1
        add bl, al
        mov cl, bl
        ; add bl, 30h
        ; mov dl, bl
        ; mov ah, 02
        ; int 21H
        lea si, str1+2
        concat:
                mov dl, [si]
                mov ah, 02
                int 21H
                inc si
                dec cl
                jne concat
        print empty
       
       jmp again
       
       
case6: cmp bl,"6"     ;check for case 6
       jne case7      ;if not equal,default to case 7 and print the error message

        print mstring
        call accept_string   ;function call to accept a string

        jmp again
               
case7: 
        print mc6
       jmp exit

csae8: 
        print mc7   ;print error message
       jmp again   ;display the menu again
       

exit:
mov ah,4ch       ;exit the program
int 21h


;accept procedure

accept proc near
        mov ah,01
        int 21h
        ret
accept endp

display1 proc near
        ;OUTPUT CODE STARTS HERE
        mov ah, 0
        mov al, bl
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
                ADD DX,30h
                INT 21H
                LOOP L2
        ;OUTPUT CODE ENDS HERE

ret
display1 endp



accept_string proc near

        mov ah,0ah          ;accept string from user function
        mov dx,offset str1  ; store the string in memory pointed by "DX"
        int 21h
        ret
accept_string endp

end start
end



; Every thing is working