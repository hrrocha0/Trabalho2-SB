section	.text
; Realiza a operação de resto (mod)
%define		first	dword	[ebp - 4]
%define		second	dword	[ebp - 8]
%define		result	dword	[ebp - 12]
%define		char	word	[ebp - 14]
op_mod:
	enter	0, 0
; TODO: ##############################
	push	1
	call	exit
; TODO: ##############################
	leave
	ret
