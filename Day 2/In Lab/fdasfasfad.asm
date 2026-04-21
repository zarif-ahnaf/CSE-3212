.MODEL SMALL
.STACK 100H
.DATA
    ; Prompts
    P1 DB 0DH,0AH,'Enter Name: $'
    P2 DB 0DH,0AH,'Enter Dept: $'   

    
    ; Output Labels
    L1 DB 0DH,0AH,'Name: $'
    L2 DB 0DH,0AH,'Dept: $'


    ; Buffers: [Max Length, Actual Length, Storage Space]
    NAME_BUF DB 50, ?, 50 DUP('$')
    DEPT_BUF DB 20, ?, 20 DUP('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- INPUT NAME ---
    LEA DX, P1
    MOV AH, 09H
    INT 21H
    
    LEA DX, NAME_BUF
    MOV AH, 0AH      ; Function 0AH: Buffered Input
    INT 21H

    ; --- INPUT DEPT ---
    LEA DX, P2
    MOV AH, 09H
    INT 21H
    
    LEA DX, DEPT_BUF
    MOV AH, 0AH
    INT 21H

    ; --- DISPLAY FORMATTED OUTPUT ---
    
    ; Print Name Label
    LEA DX, L1
    MOV AH, 09H
    INT 21H
    ; Print Name String (Starting at offset 2 of buffer)
    LEA DX, NAME_BUF + 2
    INT 21H

    ; Print Dept Label
    LEA DX, L2
    MOV AH, 09H
    INT 21H
    ; Print Dept String (Starting at offset 2 of buffer)
    LEA DX, DEPT_BUF + 2
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN