.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0DH,0AH,'Name: Rahim$'
    MSG2 DB 0DH,0AH,'Dept: CSE$'
    MSG3 DB 0DH,0AH,'Batch: 17th$'
    
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

    ; --- Get 2nd Number ---
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H

    ; --- Get 3rd Number ---
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
 

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN