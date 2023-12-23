section	.text
; Realiza a operação de resto (mod) de 16 bits
%define		first	word	[ebp - 2]
%define		second	word	[ebp - 4]
%define		result	word	[ebp - 6]
%define		char	word	[ebp - 8]
op_mod:
	enter	8, 0
	push	ax
	push	bx
	push	dx

	call	readi
	mov		first, ax

	call	readi
	mov		second, ax

	mov		dx, 0
	mov		ax, first
	idiv	second
	mov		ax, dx
	mov		result, ax

	cwde
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
