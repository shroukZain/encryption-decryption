 ;* This code contains two types of chipers :
 ;*                                           1- MonoNumeric 
 ;*                                           2-MonoAlphaptic             

name "crypt"
include 'emu8086.inc'
org 100h 
  
;-------------- Saving Tables --------------
; Storing letters from a to z (lower case)

MOV CX,26                      ; Size of letters in the alphabet
MOV AL,61h                     ; ASCII code for letter 'a'
MOV DI,400h                    ; Hold the offset of memory location in the ES
CLD                            ; clears the direction flag ( DF = 0 ,auto increament)

store_letters:
STOSB                          ; Copies a byte from AL to a memory location in ES. DI is used to hold the offset of the memory location in the ES.
                               ; After the copy, DI is automatically incremented or decremented to point to the next string element in memory.
INC AL                         ; Increases AL value by 1, therefore changing the letter
LOOP store_letters             ; Loops if CX after decrementing by 1 not equal 0

; Store numbers from 1 to 26

MOV CX,26                      ; Size of letters in the alphabet
MOV AL,1                       ; Starting from number 1
MOV DI,460h                    ; Hold the offset of memory location in the ES


store_numbers:
STOSB                          ; Copies a byte from AL to a memory location in ES. DI is used to hold the offset of the memory location in the ES.
                               ; After the copy, DI is automatically incremented or decremented to point to the next number element in memory.
INC AL                         ; Increases AL value by 1, therefore changing the letter
LOOP store_numbers             ; Loops if CX after decrementing by 1 not equal 0
 
