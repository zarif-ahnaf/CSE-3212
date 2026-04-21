.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0DH,0AH,'Enter 1st 2-digit Number: $'
    MSG2 DB 0DH,0AH,'Enter 2nd 2-digit Number: $'
    RES  DB 0DH,0AH,'Sum: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- Get 1st Number (2 digits) ---
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; Get 1st digit (e.g., '1')
    INT 21H
    SUB AL, 30H
    MOV BL, 10
    MUL BL              ; AL = 1 * 10
    MOV BH, AL          ; Store 10 in BH

    MOV AH, 01H         ; Get 2nd digit (e.g., '0')
    INT 21H
    SUB AL, 30H
    ADD BH, AL          ; BH now holds 10 (Total 1st Num)

    ; --- Get 2nd Number (2 digits) ---
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; Get 1st digit (e.g., '2')
    INT 21H
    SUB AL, 30H
    MOV BL, 10
    MUL BL              ; AL = 2 * 10
    MOV BL, AL          ; Store 20 in BL

    MOV AH, 01H         ; Get 2nd digit (e.g., '0')
    INT 21H
    SUB AL, 30H
    ADD BL, AL          ; BL now holds 20 (Total 2nd Num)

    ; --- Addition ---
    ADD BL, BH          ; BL = 10 + 20 = 30

    ; --- Display Result ---
    LEA DX, RES
    MOV AH, 09H
    INT 21H

    ; Convert 30 back to '3' and '0'
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    DIV CL              ; AL = Quotient (3), AH = Remainder (0)
    
    MOV BX, AX          ; Save result: BL=3, BH=0

    ; Print Tens Digit
    MOV DL, BL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Print Units Digit
    MOV DL, BH
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN