.equ SWI_Open,0x66@open and close a file
.equ SWI_Close,0x68
.equ SWI_PrChr,0x00
.equ SWI_PrStr,0x69
.equ SWI_RDInt,0x6c@read int and print int
.equ SWI_PrInt,0x6b
.equ Stdout, 1
.equ SWI_Exit,0x11
.global _start
.text

_start:

main:
mov r0,#Stdout
ldr r1,=StartMessage
swi	SWI_PrStr
@loading variables
ldr r4,=lostGen
ldr r5,=greatestGen
ldr r6,=babyBoomer
ldr r7,=genX
ldr r8,=genY
ldr r9,=genZ
ldr r10,=notApplicable

ldr	r0,=InFileName	@set name for file
mov	r1, #0 @input mode	
swi	SWI_Open	@open file
bcs	InFileError	@check carry bit (C) if= 1 then error
ldr r1,=InFileHandle
str	r0,[r1]

@read integers if file opened succesfully 
ReadLoop:
ldr r0,=InFileHandle
ldr r0,[r0]
swi SWI_RDInt
@sort age
mov r1,r0
cmp r1,#0
blt AddNotApplicable
cmp r1,#127
bgt AddNotApplicable
blt	AddLostGen
bcs EoFReached
bal ReadLoop


AddNotApplicable:
mov r1,r0
add r10,r10,#1
b	ReadLoop

AddLostGen:
mov r1,r0
cmp r1,#102
blt AddGreatestGen
add r4,r4,#1
b	ReadLoop

AddGreatestGen:
mov r1,r0
cmp r1,#93
blt AddBaby
add r5,r5,#1
b	ReadLoop

AddBaby:
mov r1,r0
cmp r1,#71
bgt ReadLoop
blt AddBaby2


AddBaby2:
mov r1,r0
cmp r1,#53
blt AddGenX
add r6,r6,#1

b	ReadLoop



AddGenX:
mov r1,r0
cmp r1,#38
blt AddGenY
add r7,r7,#1
b	ReadLoop

AddGenY:
mov r1,r0
cmp r1,#36
bgt ReadLoop
blt AddGenY2

AddGenY2:
mov r1,r0
cmp r1,#22
blt AddGenZ
add r8,r8,#1
b	ReadLoop

AddGenZ:
mov r1,r0
cmp r1,#7
blt AddNotApplicable
add r9,r9,#1
b	ReadLoop



EoFReached:
mov	r0,#Stdout
ldr r1,=EndOfFileMsg
swi SWI_PrStr
@close File
ldr	r0,=InFileHandle@get address of file handle
ldr r0,[r0]	@get value at address
b	PrintGenerations


PrintGenerations:
ldr r1,=LostMsg
swi SWI_PrStr
mov r4,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=GreatestGenMsg
swi SWI_PrStr
mov r5,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=BabyBoomerMsg
swi SWI_PrStr
mov r6,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=GenXMsg
swi SWI_PrStr
mov r7,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=GenYMsg
swi SWI_PrStr
mov r8,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=GenZMsg
swi SWI_PrStr
mov r9,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

ldr r1,=NotAppMsg
swi SWI_PrStr
mov r10,r0
mov r0,#Stdout
swi SWI_PrInt
mov r0,#Stdout
ldr r1,=NL
swi SWI_PrStr

b	Exit





Exit:
	swi	SWI_Exit @stop executing due to no file found
InFileError:
mov r0,#Stdout
ldr r1, =FileOpenError
swi	SWI_PrStr
bal Exit

.data
.align
InFileHandle: .skip	4
StartMessage:	.asciz "Program Start \n"
InFileName:	.asciz "integers.dat"
FileOpenError:	.asciz "Failed to open file \n"
EndOfFileMsg:	.asciz "End of file reached\n"
LostMsg:	.asciz "LostGen: "
GreatestGenMsg:	.asciz"Greatest Generation: "
BabyBoomerMsg:	.asciz"Baby Boomers: "
GenXMsg:	.asciz "Gen X: "
GenYMsg:	.asciz "Gen Y: "
GenZMsg:	.asciz "Gen Z: "
NotAppMsg:	.asciz "N/A: "
ColonSpace:	.asciz ": "
NL: asciz:	.asciz "\n"

@variables for generations
lostGen:	.word 0
greatestGen:	.word 0
babyBoomer:	.word 0
genX:	.word 0
genY:	.word 0
genZ:	.word 0
notApplicable:	.word 0

.end