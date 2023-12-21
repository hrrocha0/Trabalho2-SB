section	.text
; Realiza a operação de exponenciação de 16 bits
%define		first	word	[ebp - 2]
%define		second	word	[ebp - 4]
%define		result	word	[ebp - 6]
%define		char	word	[ebp - 8]
op_exp:
	enter	8, 0
	push	ax
	push	bx
	push	cx
	push	dx

	call	readi
	mov		first, ax

	call	readi
	mov		second, ax

	mov		result, 1
	mov		cx, second
.op_exp_l3:
	mov		dx, 0
	mov		ax, result
	imul	first
	mov		result, ax

	cmp		dx, 0
	jg		.op_exp_l2

	cmp		dx, -1
	jl		.op_exp_l2

	loop	.op_exp_l3

	cdq

	cwde
	push	edx  
	push	eax  
	call	printi
.op_exp_l1:
	lea		ebx, char
	push	1
	push	ebx
	call	read

	mov		ax, char
	cmp		al, LF
	jne		.op_exp_l1

	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	leave
	ret
.op_exp_l2:
	push	EMSG1_SIZE
	push	emsg1
	call	print

	push	1
	call	exit
