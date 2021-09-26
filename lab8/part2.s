.global _start
_start:
MOV R5, #0 // 0=inwards, 1=outwards
MOV R2, #512 // 0b1000000000 
ADD R2, #1 // 513=0b1000000001 = initial pattern
RESTART:
LDR R3, =0XFF200000	 //LEDR
LDR R0, =0XFFFEC600 // PRIVATE TIMER
LDR R8, =0XFF200050 //KEYs
LDR R1, =50000000 //counter (0.25s)	
STR R1, [R0] //put count into counter
MOV R1, #3 //0b11 enable counting and restarting
STR R1, [R0,#8] //enabling ^

LOOP:
STR R2, [R3]
LOOP2:
LDR R9, [R8] //Value of KEYs
CMP R9, #0b1000 //seeing if KEY3 is pressed
BEQ WAITING //loops to stay on until key is pressed again
//located at bottom of code

LDR R4, [R0, #12] //read timer F bit (is is empty or not?)
CMP R4, #1 // check F
BNE LOOP2 //the purpose is to wait 0.25s
STR R4, [R0, #12] //reset timer

CMP R5, #0 //inwards or outwards?
BEQ LOOPIN
LOOPOUT:
	AND R6, R2, #0b0000011111
	AND R7, R2, #0b1111100000
	CMP R7, #0b1000000000 //R8 //0b1000000001 
	BEQ NEXTIN
	LSR R6, #1
	LSL R7, #1
	MOV R2, #0
	ADD R2, R6
	ADD R2, R7
	B LOOP
	NEXTIN:
	MOV R2, #256
	ADD R2, #2 //0100000010
	MOV R5, #0
	B LOOP

LOOPIN:
	AND R6, R2, #0b0000011111
	AND R7, R2, #0b1111100000
	CMP R7, #0b0000100000 //48 //0b0000110000 
	BEQ NEXTOUT
	LSL R6, #1
	LSR R7, #1
	MOV R2, #0
	ADD R2, R6
	ADD R2, R7
	B LOOP
	NEXTOUT:
	MOV R2, #64
	ADD R2, #8//0001001000
	MOV R5, #1
	B LOOP

WAITING:
LDR R9, [R8] //Value of KEYs
CMP R9, #0b1000 //wait for key to be released
BEQ WAITING
WAITINGLOOP: //wait until pressed again
LDR R9, [R8] //Value of KEYs
CMP R9, #0b1000 //seeing if KEY3 is pressed
BNE WAITINGLOOP //loops to stay on until key is pressed again
WAITINGLOOP2: //wait for key to be released to restart
LDR R9, [R8] //Value of KEYs
CMP R9, #0b0000
BNE WAITINGLOOP2
B RESTART

.end