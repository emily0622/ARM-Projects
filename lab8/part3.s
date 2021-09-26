
//LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
.global _start
.global SWAP
_start:
//C code
//for (int i=n-1 ; i>0 ; i--)
//	for(int j=0 ; j<i ; j++){
//		s = swap(&list[j])
//}}

LDR R7, =LIST
LDR R1, [R7, #0] //number of elements
ADD R1, #1 //i'm just adding 1 because in elngth of list 1 is subtracted but I want swap to chekc till the end of the list
MOV R2, #1 //j

LENGTHOFLIST:
CMP R1, #1 //check length of list to check
BEQ END///if the list left to check is 1 you are done yay
SUB R1, #1 //i--
MOV R2, #1 //reset R2 to 1
COMPARING:
//CMP R1, R2 //i-j > 0 => j<i
CMP R1, R2 //is j less than i?
BEQ LENGTHOFLIST //surpassed where you need to check
BL SWAP //else determien swap
ADD R2, #1 //next element
B COMPARING

SWAP:
PUSH {R3-R7, LR}
LDR R7, =LIST
MOV R0, #0 //return value if no swap
//return R12 1=swap, 0=no swap
MOV R3, #0
MOV R4, #0
MOV R5, #0
MOV R6, #0
LSL R3, R2, #2 //multiply index to access element
ADD R4, R3, #4
LDR R5, [R7, R3] //first element
LDR R6, [R7, R4] //second element
CMP R6, R5
BGT ENDSUB
STR R5, [R7, R4] //SWAP
STR R6, [R7, R3] //SWAP
MOV R0, #1 //return value
//B COMPARING
ENDSUB:
POP {R3-R7, PC}


END:
B END

.end