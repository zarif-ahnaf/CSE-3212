; Smart Boy string finding algorithm

.MODEL SMALL
.STACK 100H
.DATA
    STR1 DB 'HELLO'
    STR2 DB 5 DUP(?)
    CHAR_TO_FIND DB 'L'
    MSG_MATCH DB 'Match Found$', 0
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX              ; Extra Segment must point to Data Segment for String Ops

    ; 1. MOVSB: Copy STR1 to STR2
    LEA SI, STR1            ; Source index
    LEA DI, STR2            ; Destination index
    MOV CX, 5               ; Length
    CLD                     ; Clear Direction Flag (Left to Right)
    REP MOVSB               ; Repeat move byte

    ; 2. LODSB: Load first byte of STR1 into AL
    LEA SI, STR1
    LODSB                   ; AL now contains 'H', SI points to 'E'

    ; 3. SCASB: Scan STR1 for the letter 'L'
    LEA DI, STR1
    MOV AL, CHAR_TO_FIND
    MOV CX, 5
    REPE SCASB              ; Scan until match or CX=0

    ; 4. CMPSB: Compare STR1 and STR2
    LEA SI, STR1
    LEA DI, STR2
    MOV CX, 5
    REPE CMPSB              ; Compare while equal
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN