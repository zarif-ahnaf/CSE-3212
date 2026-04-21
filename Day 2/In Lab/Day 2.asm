.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0DH,0AH,'Enter 1st Number: $'
    MSG2 DB 0DH,0AH,'Enter 2nd Number: $'
    MSG3 DB 0DH,0AH,'Enter 3rd Number: $'
    MSG4 DB 0DH,0AH,'Enter 4th Number: $'
    RES  DB 0DH,0AH,'The Average is: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- Get 1st Number ---
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BL, AL      ; Store 1st number in BL

    ; --- Get 2nd Number ---
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    ADD BL, AL      ; Add 2nd number to BL

    ; --- Get 3rd Number ---
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    ADD BL, AL      ; Add 3rd number to BL

    ; --- Get 4th Number ---
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    ADD BL, AL      ; BL now contains the Total Sum

    ; --- Calculate Average ---
    MOV AX, 0       ; Clear AX
    MOV AL, BL      ; Move sum to AL for division
    MOV CL, 4       ; Divisor is 4
    DIV CL          ; AL = Quotient (Average), AH = Remainder

    MOV BL, AL      ; Save Average in BL

    ; --- Display Result ---
    LEA DX, RES
    MOV AH, 09H
    INT 21H

    MOV DL, BL      ; Move average to DL
    ADD DL, 30H     ; Convert back to ASCII
    MOV AH, 02H     ; Print character function
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN