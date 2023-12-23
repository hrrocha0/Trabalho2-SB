section	.text
; Realiza a operação de multiplicação de 16 bits
%define		first	word	[ebp - 2]
%define		second	word	[ebp - 4]
%define		result	word	[ebp - 6]
%define		char	word	[ebp - 8]
op_mul:
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
	imul	second
	mov		result, ax

	cmp		dx, 0
	jg		.op_mul_l2

	cmp		dx, -1
	jl		.op_mul_l2

	cwde
	push	eax
	call	printi
.op_mul_l1:
	lea		ebx, char
	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_mul_l1

	pop		edx
	pop		ebx
	pop		eax
	leave
	ret
.op_mul_l2:
	push	EMSG1_SIZE
	push	emsg1
	call	print

	push	1
	call	exit
