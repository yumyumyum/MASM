TITLE Assignment3     (Assignment3.asm)

; ID number 202419711
; Sums up all numbers in range [n,m] that are divisible by 6
; Matthew Yu
; 4/3/14
;

INCLUDE Irvine32.inc

.data
divisor dword 6		;divisor : 9711 mod 15 = 6
n dword ?		;beginning of number range
m dword ?		;end ofnumber range
prompt1 byte "Please input beginning of number range: ",0
prompt2 byte "Please input end of number range: ",0
prompt3 byte "The sum is: ",0
sum dword 0		;sum of numbers in range [n,m] divisible by 6


.code
main PROC

mov edx, offset prompt1	
call writestring
call readint
mov n, eax		;store user input in n

mov edx, offset prompt2
call writestring
call readint
mov m, eax		;store user input in m

mov ecx, m		;ecx = m
sub ecx, n		;ecx = m-n (the number of times to loop)
inc ecx			;to count the last value in range

mov ebx, n		;param for DivisibleBy
mov eax, divisor		;param for DivisibleBy

L1: call DivisibleBy	;check if number in ebx is divisible by mod
    jz AddIfZero	;if it is then add it to the total sum
INL1:    inc ebx	;check the next number in [n,m] 
         loop L1	;do this until we reach m
         jmp POSTL1


AddIfZero: add sum, ebx	;if number is divisible by mod, then add to sum
	   jmp INL1

POSTL1:
mov edx, offset prompt3	
call writestring

mov eax,sum
call writedec


	exit
main ENDP


;===================Procedures====================
DivisibleBy PROC
;Determines if a number in ebx is divisible 
; by another number in eax
;
;Receives: ebx as dividend, eax as divisor
;
;Returns: zero flag will be set if it is divisible
;sign flag will be set if it is not divisible

push ebx
push eax
DIVIDE: sub ebx,eax
        jz LEAVING
        js LEAVING
        jns DIVIDE

LEAVING:
pop eax
pop ebx
ret

DivisibleBy ENDP
;=================================================

END main