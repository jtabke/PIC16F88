' Initialize the pin values for the 7-segment LED 
'digit display with segments illustrated as below
'                    a
'                 -------
'                |       |
'              f |       | b
'                |   g   |
'                 -------
'                |       |
'              e |       | c
'                |       |
'                 -------
'                    d
' The PORT pin numbers (on the PIC pin-out) correspond to the 
' PORT bit numbers as follows:
' PORTA bit: 		1	2	3
' PORTA pin name:	RA1	RA2	RA3
' PORTA pin number:	18	1	2
' PORTA function:	++	--	reset
' LED segment:		-	c	d	e	b	a	g	f
' PORTB bit:		0	1	2	3	4	5	6	7
' PORTB pin name:	RB0	RB1	RB2	RB3	RB4	RB5	RB6	RB7
' PORTB pin number:	6	7	8	9	11	12	13	14

' NOTE: 0 turns a segment ON and 1 turns it OFF since the PIC sinks current from the LED display
'	      binary  hex display
'	   %0cdebagf (correspondence between LED segments and pins array bits)
' Declare vairables
pins 	var	byte[16] 'an array of 16 bytes used to store the 7-segment display codes
I	var	byte 'counter variable

pins[ 0] = %00000010 ' 02 0
pins[ 1] = %00110111 ' 37 1
pins[ 2] = %01000001 ' 41 2
pins[ 3] = %00010001 ' 11 3
pins[ 4] = %00110100 ' 34 4
pins[ 5] = %00011000 ' 18 5
pins[ 6] = %00001000 ' 08 6
pins[ 7] = %00110011 ' 33 7
pins[ 8] = %00000000 ' 00 8
pins[ 9] = %00110000 ' 30 9
pins[10] = %00100000 ' 20 A
pins[11] = %00001100 ' 0C b
pins[12] = %01001010 ' 4A C
pins[13] = %00000101 ' 05 d
pins[14] = %01001000 ' 48 E
pins[15] = %01101000 ' 68 F

'Identify and set the internal oscillator clock speed (required for the PIC16F88)
DEFINE OSC 8
OSCCON.4 = 1
OSCCON.5 = 1
OSCCON.6 = 1

' Turn off the A/D converter (required for the PIC16F88)
ANSEL = 0

TRISA = %00001110 'PORTA.1,2,3 are inputs
TRISB = $00 'PORTB pins are all outputs

' Initialize the display to zero
I = 0
Gosub Updatepins

'Main loop
pollpins:
'Continue to increment every 0.2 sec while the increment button is being held down
Do While (PORTA.1 == 1)
	If(I==15) Then
		I = 0
	Else
		I = I + 1
	Endif
	Gosub Updatepins ' Update the display
	Pause 200 'Hold the current count on the display for 0.2 sec before continuing
Loop
Pause ' Pause for 0.01 sec to allow any switch bounce to settle after button release

'Continue to decriment every 0.2 sec while the decriment button is being held down
Do While (PORTA.2 == 1)
	If(I==0) Then
		I = 15 
	Else
		I = I - 1
	Endif
	Gosub Updatepins ' Update the display
	Pause 200 'Hold the current count on the display for 0.2 sec before continuing
Loop
Pause ' Pause for 0.01 sec to allow any switch bounce to settle after button release

'Reset the display to zero if the reset button is pressed
	If(PORTA.3 = 1) Then
		I = 0 
	Gosub Updatepins ' Update the display
	Endif
Goto pollpins

'Update pins subroutine
Updatepins:
	PORTB = pins[I]
	Return 'return to line following gosub command that was called
END 'End of program
