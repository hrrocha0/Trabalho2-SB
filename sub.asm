section	.text
; Realiza a operação de subtração
%define		first	dword	[ebp - 4]
%define		second	dword	[ebp - 8]
%define		result	dword	[ebp - 12]
%define		char	word	[ebp - 14]
op_sub:
	enter	14, 0
	push	eax
	push	ebx

	call	readi
	mov		first, eax

	call	readi
	mov		second, eax

	mov		eax, first
	sub		eax, second
	mov		result, eax

	push	eax
	call	printi
.op_sub_l1:
	lea		ebx, char

	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_sub_l1

	pop		ebx
	pop		eax
	leave
	ret
