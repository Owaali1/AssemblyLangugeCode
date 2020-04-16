; comments here


.686 ; directives start with a period
.model flat,stdcall
option casemap : none ; case-sensitive

ExitProcess PROTO:DWORD

extern printf : proc
extern scanf : proc

; information that is not input after running the code
.data
szMsg db "welcome to x86 Assembly %s %i",0dh,0ah,0	;0dh, 0ah line feed, always ends with a 0 
szMsg2 db "testing",0
szfmt db "%s %i",0
;Fpu - Floating point unit
;SSE - Streaming SIMD Extentions
;SIMD - Single Instruction Multiple Data
;XMM - 128 bit registers, 4 32 bit registers or 2 64 bit registers
;AVX - Advanced Vector Extensions, 256 bit registers, 8 32 bit registers or 4 64 bit registers

.data?

szName  db 32 dup(?) ; db is defined byte  8 bits
Iage	dd ?		 ; dw is defined word 16 bits
					 ; dd is define double word 32 bits
.code
main proc

	mov eax,1
	mov ecx,10
	push offset Iage
	push offset szName
	push offset szfmt
	
	call scanf

	push 1000
	push 32
	push [Iage]
	push offset szName
	push offset szMsg
	call printf
	
	
	invoke ExitProcess,0
main endp
end main