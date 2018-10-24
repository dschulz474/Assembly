.text
.equ SWI_Open,0x66@open and close a file
.equ SWI_Close,0x68
.equ SWI_RDInt,0x6c@read int and print int
.equ SWI_PrInt,0x6b
.equ Stdout, 1
.equ SWI_Exit,0x11

.global _start
b	main


main:
ldr	r0,=InFileName
mov	r1,#0 @input mode
swi	SWI_Open
bcs	InFileError
ldr	r1,=InFileHandle
str	r0,[r1]

.data 
OutFileHandle:	.word 0
InFileHandle: 	.word 0
InFileName:		.asciz "integers.dat"
InFileError:	.asciz "Unable to open input file\n"	
.align
OutFileName:	.asciz "integers.dat"

.end