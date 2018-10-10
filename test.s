.global _start

main:
ldr r0, =n @load address of n into r0
ldr r1, =sum
for:@summation for loop
ldr r2, =i 
add r1,r2,r0 @add r2 and r0 into r1
mov	r2,r0
ble for
bgt endfor
endfor:
swi 0x11

.data
n:	.word 5
sum:	.word 0
i:	.word 0


