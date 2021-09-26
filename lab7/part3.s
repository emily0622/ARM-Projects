.global ONES
.text	

ONES:
MOV R0, #0
LOOP: CMP R1, #0
BEQ ENDSUB
LSR R2, R1, #1 // perform SHIFT, followed by AND
AND R1, R1, R2
ADD R0, #1 // count the string lengths so far
B LOOP
ENDSUB:
MOV PC, LR
