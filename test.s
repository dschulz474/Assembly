.global _start

main:
ldr r1, =n @load address of n into r0
ldr r2, =sum
ldr r3, =i

mov r3,#0
for:@summation for loop
cmp r3,r1
bgt endforloop
add r3,r3,#1
add r2,r2,r3
b for

endforloop:
mov r1,r2
mov r0,#0

swi 0x6b
swi 0x11

.data
n:	.word 5
sum:	.word 0
i:	.word 0




