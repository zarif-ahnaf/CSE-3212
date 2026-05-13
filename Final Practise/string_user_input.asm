; Smart boy user input string loop check

.MODEL SMALL
.STACK 100H
.DATA
    ; Prompts
    PROMPT1 DB 'Enter a string (max 9): $'
    PROMPT2 DB 0DH, 0AH, 'Enter a character to find: $'
    MSG_MATCH DB 0DH, 0AH, 'Match Found!$'
    MSG_NOMATCH DB 0DH, 0AH, 'No Match Found.$'
    
    ; Input Buffer for String (Service 0AH format)
    ; [Max Length] [Actual Length] [Data...]
    STR_BUF DB 10          ; Max characters to read
    STR_LEN DB ?           ; Actual number of chars read (filled by DOS)
    USER_STR DB 10 DUP(?)  ; The actual string data
    
    CHAR_INPUT DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX             ; Required for SCASB/CMPSB

    ; --- 1. Get String Input ---
    LEA DX, PROMPT1
    MOV AH, 09H
    INT 21H

    LEA DX, STR_BUF
    MOV AH, 0AH            ; Buffered Input Service
    INT 21H

    ; --- 2. Get Character Input ---
    LEA DX, PROMPT2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H            ; Read single character with echo
    INT 21H
    MOV CHAR_INPUT, AL     ; Store it

    ; --- 3. SCASB: Search for the character ---
    LEA DI, USER_STR       ; Point DI to the start of the user string
    MOV AL, CHAR_INPUT     ; Target character
    XOR CH, CH             ; Clear CH
    MOV CL, STR_LEN        ; Load actual length entered by user
    
    CLD                    ; Forward direction
    REPNE SCASB            ; Repeat While Not Equal (Scan for match)

    JE MATCH_FOUND         ; If Zero Flag is set, we found it
    
    ; --- 4. Handle Results ---
    LEA DX, MSG_NOMATCH
    JMP DISPLAY

MATCH_FOUND:
    LEA DX, MSG_MATCH

DISPLAY:
    MOV AH, 09H
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN