;Written by: Rubee
;7.19.2023
;A program that outputs the first 9 multiples of 9.


top_label:
	DATA  R0,0x01           ;Opcode and operands to load 1 into R0.
	DATA  R1,0x00           ;Opcode and operands to load decimal 0 into R1. This is RA.
	DATA  R2,0x00           ;Opcode and operands to load 0 into R2.This is RB.
        DATA  R3,0x09   	;Opcode and operands to load decimal 9 into R3. This is the loop variable.


loop_top:
       ADD  R0,R1                ;ADD 1 to RA and result is in RA.
       SHL  R1,R2                ;Shift Left the value in RA and reslt is in RB.
       SHL  R2,R2                ;Shift again the value in RB.
       SHL  R2,R2                ;Shift again the value in RB.
       ADD  R1,R2                ;Add RA and RB and result is in RB.
       OUT  R2                   ;Get the Output of the multiplication of 9.

       CMP R1,R3                 ;Compare the value in R3 with current value in R1.
       JE  loop_forever          ;If the values in R1 and R2 equal then jump out of the loop to "loop forever".
       JMP loop_top              ;If the equal flag not set, then jump back to the loop top.


loop_forever:
        JMP   loop_forever      ;Hold the processor in this infinite loop.
	    .BYTE 0