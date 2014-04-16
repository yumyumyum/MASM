TITLE Assignment 4   (Assignment4.asm)

; Counts number of words, lines of text, and 
; occurencies of the letter 'u'
; Author: Matthew Yu
; Date Created: 4/14/14
; Last Modification Date: 4/15/14

INCLUDE Irvine32.inc

.data
paragraph byte 10000 dup(?)
words dword 0
wUnits byte " word(s)",0
lines dword 0
lUnits byte " line(s)",0
uchar dword 0
uUnits byte " occurrence(s) of 'u'",0
paraLength dword 0
paraprompt byte "Please input paragraph terminated by '@': ",0dh,0ah,0
menu byte "Enter the following numbers to execute commands: ",0dh,0ah,
	"0) Exit. ",0dh,0ah,
	"1) Input paragraph. Must do this before accessing options 2-4",0dh,0ah,
	"2) Print number of words in paragraph.",0dh,0ah,
	"3) Print number of lines in paragraph. ",0dh,0ah,
	"4) Print number of times 'u' was in paragraph. ",0dh,0ah,0
menuinput byte "input: ",0

.code
main PROC

call clrscr
mov edx,offset menu
call dispMenu

menuloop: 
mov edx, offset menuinput
call writestring
call readchar
call writechar				;echo input char
call crlf
cmp al,30h	;if char is '0'
je char0
cmp al,31h 	;if char is '1'
je char1
cmp al,32h	;if char is '2'
je char2
cmp al,33h	;if char is '3'
je char3
cmp al,34h	;if char is '4'
je char4
jmp menuloop

char1: mov ebx,offset paragraph
mov edx,offset paraprompt
mov esi,type paragraph
call inputPara			;gets user input paragraph terminated by '@'
mov paraLength,edx
call crlf
call crlf
jmp menuloop

char2: 
mov eax, offset paragraph
mov ecx, paraLength
call wordNum			;counts words in paragraph
mov words,ebx
mov eax,words
call writedec
mov edx,offset wUnits
call writeString
call crlf
call crlf
jmp menuloop

char3: 
mov eax, offset paragraph
mov ecx, paraLength
call lineNum			;counts lines in paragraph
mov lines,ebx
mov eax, lines
call writedec
mov edx, offset lUnits
call writestring
call crlf
call crlf
jmp menuloop

char4: 
mov eax, offset paragraph
mov ecx, paraLength
call uNum			;counts occurrences of 'u' in paragraph
mov uchar,ebx
mov eax, uchar
call writedec
mov edx,offset uUnits
call writestring
call crlf
call crlf
jmp menuloop

char0:

	exit

main ENDP


;======================================================================
;counts the number of words in a paragraph
;Receives: paragraph's offset in eax,length of paragraph in ecx
;Returns: number of words in bl

wordNum PROC

xor esi,esi
mov ebx,1				;always have at least one word

WORDCHECK: cmp byte ptr [eax+esi],20h	;check if char is space
je incword				;space char found
inc esi					;next char of paragraph
loop WORDCHECK
jmp done


incword: inc ebx			;inc number of words
inc esi					;next char of paragraph
loop WORDCHECK

done: ret

wordNum ENDP
;======================================================================


;======================================================================
;counts number of lines in a paragraph
;receives: paragraph's offset in eax,length of paragraph in ecx
;returns: number of lines in ebx

lineNum PROC

xor edx,edx
mov ebx,1				;always have at least one line

LINECHECK: 
inc edx
cmp edx,80				;80 characters in a line
je incLine				;another line
loop LINECHECK

jmp done

incLine: inc ebx			;inc number of lines
xor edx,edx				;reset char counter to 0
loop LINECHECK				;because we count every 80 chars per line

done: ret

lineNum ENDP
;======================================================================


;======================================================================
;counts number of times 'u' occurs in a paragraph
;receives: paragraph's offset in eax,length of paragraph in ecx
;returns number of occurrences of 'u' in ebx

uNum PROC

xor ebx,ebx
xor esi,esi

uCHECK: cmp byte ptr [eax+esi],75h	;check if char is 'u'
je incU					;'u' found
cmp byte ptr [eax+esi],55h		;check if char is 'U'
je incU					;'U' found
inc esi					;move to next char in paragraph
loop UCHECK

jmp done

incU: inc ebx				;inc occurrences of 'u'
inc esi					;move to next char in paragraph
loop UCHECK

done: ret

uNum ENDP
;======================================================================


;======================================================================
;stores user input paragraph terminated by '@' into array with offset at ebx
;receives: offset of prompt in edx,type of paragraph in esi
;returns: offset of paragraph in ebx, number of chars in paragraph in edx

inputPara PROC

call writestring			;tell user to input paragraph
call crlf

xor edx,edx				;edx counts how many chars are in paragraph

input: call readchar
call writechar				;echo char inputted
cmp al,40h				;check if input char is '@'
je done
inc edx
mov [ebx],al
add ebx,esi				;move to next char in paragraph
jmp input


done: ret				;end of paragraph

inputPara ENDP
;======================================================================


;======================================================================
;displays menu options
;receives: menu string offset in edx
;returns: nothing

dispMenu PROC


call writestring
call crlf

ret

dispMenu ENDP
;======================================================================



END main 