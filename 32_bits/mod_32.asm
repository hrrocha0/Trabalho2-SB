section	.text
; Realiza a operação de resto (mod) de 32 bits
%define		first	dword	[ebp - 4]
%define		second	dword	[ebp - 8]
%define		result	dword	[ebp - 12]
%define		char	word	[ebp - 14]
op_mod:
	enter	14, 0
	push	eax
	push	ebx
	push	edx

	call	readi
	mov		first, eax

	call	readi
	mov		second, eax

	mov		edx, 0
	mov		eax, first
	idiv	second
	mov		eax, edx
	cwde
	mov		result, eax

	push	eax
	call	printi
.op_mod_l1:
	lea		ebx, char

	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_mod_l1

	pop		edx
	pop		ebx
    pop		eax
	leave
	ret
