
//LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
.global _start
.global SWAP
_start:
//C code
//for (int i=n-1 ; i>0 ; i--)
//	for(int j=0 ; j<i ; j++){
//		s = swap(&list[j])
//}}

LDR R12, =LIST
LDR R1, [R12, #0] //number of elements
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
MOV R3, #0
MOV R4, #0
MOV R5, #0
MOV R6, #0
LSL R0, R2, #2 //multiply index to access element
ADD R0, R0, R12
ADD R4, R0, #4
BL SWAP //else determien swap
ADD R2, #1 //next element
B COMPARING

SWAP:
PUSH {R5-R6, LR}
//return R12 1=swap, 0=no swap
LDR R5, [R0] //first element
LDR R6, [R4] //second element
CMP R6, R5
BGT NOSWAP
STR R5, [R4] //SWAP
STR R6, [R0]
//SWAP
MOV R0, #1 //return value
B ENDSUB
NOSWAP:
MOV R0, #0 //return value if no swap
ENDSUB:
POP {R5-R6, PC}


END:
B END

.end