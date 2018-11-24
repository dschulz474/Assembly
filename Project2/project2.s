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
b createArrayIn

createArrayIn:
ldr r0,=blockSize
ldr r0,[r0]
swi SWI_MeAlloc
ldr r6,=arrayIn
str r0,[r6]
b createArrayOut

createArrayOut:
ldr r0,=blockSize
ldr r0,[r0]
swi SWI_MeAlloc
ldr r7,=arrayOut
str r0,[r7]
b writeArrayIn

writeArrayIn:
mov r0,r5
mov r1,r6
ldr r2,=blockSize
str r5,[r6]
b loopArg

loopArg:
mov r1,#1
eor r2,r2,r2
mov r3,r2 @index
b UserInputHandle

UserInputHandle:
mov r0,r3
cmp r3,#0
beq Encrypt
bgt Decrypt

Encrypt:
ldrb r0,[r6,r3]
cmp r0,r2
beq Print
eor r0,r0,r8
strb r0,[r7,r3]
add r1,r1,#1
b Encrypt

Decrypt:
ldrb r0,[r6,r3]
cmp r0,r2
beq Print
eor r0,r0,r8
strb r0,[r7,r3]
add r3,r3,r1
b Decrypt

Print:
mov r0,r5
ldr r1,=arrayOut
swi SWI_PrStr
ldr r0,=OutFileHandle
ldr r0,[r0]
ldr r1,=arrayOut
swi 0x69
b Exit











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
OutFileHandle:	
CommandFile:	.asciz "inputCommand.txt"
InputFile:		.asciz "messageInput.txt"
FileOpenError:	.asciz "Failed to open file \n"
EndOfFileMsg:	.asciz "End of file reached \n"
ColonSpace:		.asciz ": "
NewLine:		.asciz "\n"
command:	.word 0
key:		.word 0
input:	.word 0