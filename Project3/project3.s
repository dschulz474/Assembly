.equ	SEG_A,0x80@pattern for 8 segment display
.equ	SEG_B,0x40
.equ	SEG_C,0x20
.equ	SEG_D,0x08
.equ	SEG_E,0x04
.equ	SEG_F,0x02
.equ	SEG_G,0x01
.equ	SEG_P,0x10
.equ	SWI_SETSEG8, 0x200
.equ 	SWI_SETTLED, 0X201
.equ	SWI_CheckBlack, 0x202
.equ	SWI_CheckBlue, 0x203
.equ	SWI_DRAW_STRING, 0x204
.equ	SWI_CLEAR_DISPLAY, 0x206
.equ	SWI_DRAW_CHAR, 0x207
.equ	SWI_CLEAR_LINE, 0X208
.equ	SWI_EXIT, 0x11
.equ	SWI_GetTicks,0x6d
.equ	Left_LED, 0x02
.equ	Right_LED, 0x01
.equ	Left_Black_Button, 0x02	 @bit patterns for black buttons
.equ	Right_BlackButton, 0x01  @and for blue buttons
.equ	Blue_Key_00, 0x01
.equ	Blue_Key_01, 0x02
.equ	Blue_Key_02, 0x03
.equ	Blue_Key_04, 0x10
.equ	Blue_Key_05, 0x20
.equ	Blue_Key_06, 0x40
.equ	Blue_Key_07, 0x80
.equ	Blue_Key_00, 1<<8
.equ	Blue_Key_01, 1<<9

.text
.global _start
_start:


.data
Welcome: .asciz "Welcome to Board Testing"
LeftLED: .asciz "Left light"
RightLED: .asciz "RIght Light"
PressBlackL: .asciz "Press a Black button"
Bye: .asciz "Bye"
Blank: .asciz " "
Digits:
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G @0
.word	SEG_B|SEG_C @1
.word	SEG_A|SEG_B|SEG_F|SEG_E|SEG_D @2
.word	SEG_A|SEG_B|SEG_F|SEG_C|SEG_D @3
.word	SEG_G|SEG_F|SEG_B|SEG_C @4
.word	SEG_A|SEG_G|SEG_F|SEG_C|SEG_D @5
.word	SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C @6
.word	SEG_A|SEG_B|SEG_C @7
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @8
.word	SEG_A|SEG_B|SEG_F|SEG_G|SEG_C @9
.word 0 @blank display

