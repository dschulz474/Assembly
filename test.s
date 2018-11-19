.equ SWI_Open,0x66@open and close a file
.equ SWI_Close,0x68
.equ SWI_PrChr,0x00
.equ SWI_PrStr,0x69
.equ SWI_RDInt,0x6c@read int and print int
.equ SWI_PrInt,0x6b
.equ SWI_RDStr,0x6a
.equ SWI_MeAlloc,0x12
.equ SWI_DAlloc,0x13
.equ Stdout, 1
.equ SWI_Exit,0x11
.global _start
.text

_start:
main:
ldr r3,=command
ldr r4,=key
ldr r5,=input

bal OpenCommandFile

OpenCommandFile:
@read command file
ldr	r0,=CommandFile
mov	r1,#0
swi	SWI_Open	@open file
bcs	InFileError	@check carry bit C if= 1 then error
ldr	r1,=InFileHandle
str r0,[r1]



ReadCommandFile:
@READ LOOP
ldr r0,=InFileHandle
ldr r0,[r0]
swi	SWI_RDInt
str r0,[r3]


ReadCommandFile2:
ldr r0,=InFileHandle
ldr r0,[r0]
swi SWI_RDInt
str r0,[r4]
b EoFReached

EoFReached:
ldr r0,=InFileHandle
ldr r0,[r0]
swi	SWI_Close
b	OpenInputFile

OpenInputFile:
@read input file
ldr	r0,=InputFile
mov	r1,#0
swi	SWI_Open	@open file
bcs	InFileError	@check carry bit C if= 1 then error
ldr	r1,=InFileHandle
str r0,[r1]
b ReadInputFile

ReadInputFile:
ldr r0,=InFileHandle
ldr r0,[r0]
ldr r1,=input
mov r2,#80
swi	SWI_RDStr
mov r1,r0
str r0,[r5]

createArrayIn:
ldr r0,=blockSize
ldr r0,[r0]
swi SWI_MeAlloc
ldr r6,=arrayIn
str r0,[r6]

createArrayOut:
ldr r0,=blockSize
ldr r0,[r0]
swi SWI_MeAlloc
ldr r7,=arrayOut
str r0,[r7]

writeArray:
mov r0,r5
mov r1,r6
ldr r2,=blockSize
eor r0,r0,r0


InFileError:
mov r0,#Stdout
ldr r1,=FileOpenError
swi	SWI_PrStr
bal Exit


Exit:@Exit 
	swi		SWI_Exit
.data
arrayIn:	.word 0
arrayOut:	.word 0
blockSize:  .word 500
InFileHandle:	.skip 4
CommandFile:	.asciz "inputCommand.txt"
InputFile:		.asciz "messageInput.txt"
FileOpenError:	.asciz "Failed to open file \n"
EndOfFileMsg:	.asciz "End of file reached \n"
ColonSpace:		.asciz ": "
NewLine:		.asciz "\n"
command:	.word 0
key:		.word 0
input:	.word 0