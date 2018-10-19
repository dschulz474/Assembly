.global _start

main:
ldr r0, =n @load address of n into r0
ldr r1, =sum
ldr r2, =i
mov r2,#0
for:@summation for loop
cmp r2,r0
bgt endforloop
add r1,r1,r2
add r2,r2,#1
b for
endforloop:
mov r0,#stdout
mov r1,r1
swi SWI_PrInt
swi 0x11

.data
n:	.word 5
sum:	.word 0
i:	.word 0



