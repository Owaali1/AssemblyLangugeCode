.686
.model flat,stdcall
option casemap : none ; case-sensitive

ExitProcess PROTO:DWORD

extern printf : proc
extern scanf : proc

.data
szMsg db "enter 2 integers: ",0
table db 32,25,46,72,21,89
szInput db "%i %i",0
szFmt db "%i ",0 
szHeading db "                 decimal                   hex           Binary", 0dh, 0ah, 0
szOutput db "%s		 %i	    %x           %b\n", 0dh, 0ah, 0
sz1st db "1st",0
sz2nd db "2nd",0
szSum db "Sum",0
szSub db "diff",0
szMul db "Prod",0
szdiv db "Qout",0
szmod db "Mod",0
szAnd db "and",0
szor  db "or",0
szxor db "xor",0
sznot1st db "~1st",0 
sznot2nd db "~2nd",0
szneg1st db "neg1st",0
szneg2nd db "neg2nd",0
szshl db "shl x",0
szshr db "shr x",0
szrol db "rol x",0
szror db "ror x",0
szsar db "sar x",0
szrcl db "rcl x",0
szrcr db "rcr x",0
szshl2 db "shl y",0
szshr2 db "shr y",0
szrol2 db "rol y",0
szror2 db "ror y",0
szsar2 db "sar y",0
szrcl2 db "rcl y",0
szrcr2 db "rcr y",0
szans db "answer",0
szFrm2 db "Testing %b %s %i %x\n",0
.data?
	x	dd ?
	y	dd ?
	buffer db 120 dup(?)
.code

itoa:
	;itoa integer to ascii
	;eax contains the number
	;edi is already set to the destination buffer
	;end with zero so we can print with printf
	;using string instructions as much as possible

	push ebx
	
	
	
	mov ebx,0
	cmp eax,0
	jge @10
		cmp ecx,10
		jne @10
		mov bh,1
		neg eax
	@10:
	    xor edx,edx
		div ecx
		add edx, 030h
		cmp edx, 03ah
		jl @15
			add edx,39

		@15:
		push edx
		inc bl
		cmp eax, 0
		jne @10
		cmp bh,1
			jne @20
			push '-'
			inc bl
	@20:
		pop eax
		stosb
		dec bl
		jg @20

	pop ebx
	ret

	; sputf will have the same functionality as printf
sputf proc
	push esi
	push edi
	push ebx


	mov edi, eax ; buffer is put in edi
	mov esi, edx
	mov ebx, ecx

	L1:
		lodsb
		cmp al, '\'
		je L100

		cmp al, '%'
		je L110

		stosb
		cmp al,0
		jne L1
		jmp @done
	L100:
		lodsb
		mov al, 0dh
		stosb
		mov al, 0ah
		stosb
		jmp L1
	L110:
		lodsb
		mov ecx ,10
		cmp al, 'i'
		je L112
		mov ecx, 16
		cmp al, 'x'
		je L112
		mov ecx, 2
		cmp al, 'b'
		je L112
		push esi
		mov esi, [ebx]
		add ebx, 4
	L113:
		lodsb
		cmp al, 0 
		je L114
		stosb
		jmp L113
	
	L112:
		mov eax, [ebx] ; ebx contains the array
		call itoa
		add ebx,4
		jmp L1
	L114:
		pop esi
		jmp L1
	

	@done:
		pop ebx
		pop edi
		pop esi
		ret




sputf endp

putf proc
	mov eax, offset buffer
	lea ecx, [esp+4]
	call sputf
	push offset buffer
	call printf
	pop eax
	ret

putf endp


;eax = value edx = string
DoOutput proc

	push eax
	push eax
	push eax
	push edx
	mov edx, offset szOutput
	call putf
	add esp,16
	ret


DoOutput endp

main proc

	mov edx, offset szMsg
	call putf
	
	push offset y
	push offset x
	push offset szInput

	call scanf
	
	mov edx, offset szHeading
	call putf
	
	mov eax,x
	mov edx, offset sz1st
	
	call DoOutput

	mov eax, y
	mov edx, offset sz2nd
	call DoOutput

	mov eax,x
	add eax,y
	mov edx, offset szSum
	call DoOutput 

	mov eax,x
	sub eax,y
	mov edx, offset szSub
	call DoOutput 

	mov eax,x
	mov ebx,y
	mul y
	mov edx, offset szMul
	call DoOutput 

	mov eax,x
	cdq 
	div y
	push edx
	mov edx,offset szdiv
	call  DoOutput
	
	pop eax
	mov edx,offset szmod
	call DoOutput

	mov eax,x
	mov ebx,y
	and eax,ebx
	mov edx,offset szAnd
	call DoOutput

	mov eax,x
	mov ebx,y
	or eax,ebx
	mov edx,offset szor
	call DoOutput

	mov eax,x
	mov ebx,y
	xor eax,ebx
	mov edx,offset szxor
	call DoOutput

	
	mov eax,x
	not eax
	mov edx,offset sznot1st
	call DoOutput
	
	mov eax,y 
	not eax
	mov edx,offset sznot2nd
	call DoOutput

	
	mov eax,x
	neg eax
	mov edx,offset szneg1st
	call DoOutput
	
	mov eax,y
	neg eax
	mov edx,offset szneg1st
	call DoOutput

	mov eax,x
	shl eax,1
	mov edx,offset szshl
	call DoOutput

	mov eax,y
	shl eax,1
	mov edx,offset szshl2
	call DoOutput

	mov eax,x
	shr eax,1
	mov edx,offset szshr
	call DoOutput

	mov eax,y
	shr eax,1
	mov edx,offset szshr2
	call DoOutput


	mov eax,x
	sar eax,1
	mov edx,offset szsar
	call DoOutput

	mov eax,y
	sar eax,1
	mov edx,offset szsar2
	call DoOutput

	mov eax,x
	rol eax,1
	mov edx,offset szrol
	call DoOutput

	mov eax,y
	rol eax,1
	mov edx,offset szrol2
	call DoOutput

	mov eax,x
	ror eax,1
	mov edx,offset szror
	call DoOutput

	mov eax,y
	ror eax,1
	mov edx,offset szror2
	call DoOutput

	mov eax,x
	rcl eax,1
	mov edx,offset szrcl
	call DoOutput

	mov eax,y
	rcl eax,1
	mov edx,offset szrcl2
	call DoOutput
	
	mov eax,x
	rcr eax,1
	mov edx,offset szrcr
	call DoOutput

	mov eax,y
	rcr eax,1
	mov edx,offset szrcr2
	call DoOutput

	mov eax,0102h
	mov ebx, 010h
	mul ebx
	mov edx,offset szans
	call DoOutput





	mov eax, 42
	;mov eax, ebx
	;mov al, 42
	;mov dh, 46
	mov eax, [dword ptr table]
	mov al, [table]
	mov al, [table+2]


	invoke ExitProcess,0
main endp
end main