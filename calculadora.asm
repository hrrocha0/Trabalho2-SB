global	_start

%define PREC_16		0
%define	PREC_32		1

%define	NULL		0					; fim da string
%define	LF			10					; quebra de linha
%define	CHAR_ZERO	48					; codigo ascii do caractere '0'

%define	NAME_SIZE	16					; numero maximo de bytes do nome
%define	PREC_SIZE	1					; numero maximo de bytes da precisao
%define	OPTN_SIZE	1					; numero maximo de bytes da opcao

section	.data
; Variaveis globais inicializadas
nmsg1		db		"Bem-vindo. Digite seu nome:", LF, NULL
NMSG1_SIZE	equ		$ - nmsg1
wmsg1		db		"Hola, ", NULL
WMSG1_SIZE	equ		$ - wmsg1
wmsg2		db		", bem-vindo ao programa de CALC IA-32", LF, NULL
WMSG2_SIZE	equ		$ - wmsg2
pmsg1		db		"Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):", LF, NULL
PMSG1_SIZE	equ		$ - pmsg1
omsg1		db		"- 1: SOMA", LF, NULL
OMSG1_SIZE	equ		$ - omsg1
omsg2		db		"- 2: SUBTRACAO", LF, NULL
OMSG2_SIZE	equ		$ - omsg2
omsg3		db		"- 3: MULTIPLICACAO", LF, NULL
OMSG3_SIZE	equ		$ - omsg3
omsg4		db		"- 4: DIVISAO", LF, NULL
OMSG4_SIZE	equ		$ - omsg4
omsg5		db		"- 5: EXPONENCIACAO", LF, NULL
OMSG5_SIZE	equ		$ - omsg5
omsg6		db		"- 6: MOD", LF, NULL
OMSG6_SIZE	equ		$ - omsg6
omsg7		db		"- 7: SAIR", LF, NULL
OMSG7_SIZE	equ		$ - omsg7
omsg8		db		"ESCOLHA UMA OPÇÃO:", LF, NULL
OMSG8_SIZE	equ		$ - omsg8

section	.bss
; Variaveis globais nao inicializadas
name		resb	NAME_SIZE			; nome do usuario
precision	resb	PREC_SIZE			; precisao selecionada
option		resb	OPTN_SIZE			; opcao selecionada

section	.text
; Software Basico (2023.2) - Trabalho 2
; Henrique Rodrigues Rocha - 211036061
_start:
	call	getname
	call	getprecision
	call	getoption

	push	0
	call	exit

; Le o nome do usuario do console e armazena na variavel 'name'
; Parametros: nenhum
; Retorno: nenhum
getname:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Le a precisao do console e armazena na variavel 'precision'
; 0 - 16 bits
; 1 - 32 bits
; Parametros: nenhum
; Retorno: nenhum
getprecision:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Le a opcao do console e armazena na variavel 'option'
; 1 - soma
; 2 - subtracao
; 3 - multiplicacao
; 4 - divisao
; 5 - exponenciacao
; 6 - resto (mod)
; 7 - sair
; Parametros: nenhum
; Retorno: nenhum
getoption:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Imprime uma string no console
; Parametros:
;	 - 1: endereco da string
;	 - 2: tamanho da string em bytes
; Retorno: nenhum
print:
	enter	0, 0					; cria o stack frame
	mov		eax, 4					; sys_write
	mov		ebx, 1					; stdout
	mov		ecx, [ebp + 12]			; endereco
	mov		edx, [ebp + 8]			; tamanho
	int		80h						; syscall
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Le uma string do console
; Parametros:
;	 - 1: endereco onde a string sera armazenada
;	 - 2: tamanho maximo da string em bytes
; Retorno:
;	 - 1: tamanho da string lida
read:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Le um inteiro de 32 bits do console
; Parametros:
;	 - 1: numero maximo de digitos em bytes
; Retorno:
;	 - 1: numero de 32 bits lido
geti32:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Le um inteiro de 16 bits do console
; Parametros:
;	 - 1: numero maximo de digitos em bytes
; Retorno:
;	 - 1: numero de 16 bits lido
geti16:
	enter	0, 0					; cria o stack frame
	; TODO: funcao nao implementada
	; TODO	#######################################################
	push	11
	call	exit
	; TODO	#######################################################
	leave							; destroi o stack frame
	ret		8						; retorna e apaga os parametros

; Termina o processo com o codigo especificado
; Parametros:
;	 - 1: codigo de saida
; Retorno: nenhum
exit:
	enter	0, 0					; cria o stack frame
	mov		eax, 1					; sys_exit
	mov		ebx, [ebp + 8]			; codigo de saida
	int		80h						; syscall
	leave							; destroi o stack frame
	ret		4						; retorna e apaga os parametros
