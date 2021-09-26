.text
.global _start
_start:
LDR R1, = TEST_NUM
MOV R2, #0
MOV R7, #0
MOV R8, #0
LOOP:
LDR R3, [R1, R2]
CMP R3, #-1
BEQ END
ADD R7, R7, R3
ADD R8, R8, #1
ADD R2, R2, #4
B LOOP


END: B END
//TEST_NUM: .word 1,2,3,5,0xA,-1
.end