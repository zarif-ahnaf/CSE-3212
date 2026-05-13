.MODEL SMALL
.STACK 100H

.DATA
   
    MAX_LEN    DB 50            
    ACTUAL_LEN DB ?             
    USER_STR   DB 50 DUP('$')   
    
    PROMPT     DB 'Enter a string: $'
    PAL_MSG    DB 10,13,'Result: It is a Palindrome!$'
    NOT_PAL_MSG DB 10,13,'Result: Not a Palindrome.$'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H

    LEA DX, MAX_LEN             
    MOV AH, 0AH                 
    INT 21H

 
    MOV CH, 0
    MOV CL, ACTUAL_LEN          
    
    CMP CL, 1                   
    JLE IS_PALINDROME

    LEA SI, USER_STR            
    LEA DI, USER_STR
    ADD DI, CX                  
    DEC DI                      
    SHR CX, 1                   
    
CHECK:
    MOV AL, [SI]
    MOV BL, [DI]
    
    CMP AL, 'a'
    JL  SKIP_CONV
    SUB AL, 32                 
SKIP_CONV:

    CMP AL, BL
    JNE NOT_PALINDROME
    
    INC SI
    DEC DI
    LOOP CHECK

IS_PALINDROME:
    LEA DX, PAL_MSG
    JMP DISPLAY

NOT_PALINDROME:
    LEA DX, NOT_PAL_MSG

DISPLAY:
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
END START