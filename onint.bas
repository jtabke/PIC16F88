' onint.bas
' Example use of an interrupt signal and interrupt handler
' This program turns on an LED and waits for an interrupt on PORTB.0. When RB0 changes
' state, the program turns the LED off for 0.5 seconds and then resumes normal execution.
' Identify and set the internal oscillator clock speed (required for the PIC16F88)
DEFINE OSC 8
OSCCON.4 = 1
OSCCON.5 = 1
OSCCON.6 = 1

' Turn off the A/D converter (required for the PIC16F88)
ANSEL = 0

led var PORTB.7 ' define variable led
	OPTION_REG = $FF ' disable PORTB pull-ups and detect positive edges on interrupt
	On Interrupt Goto myint ' define interrupt service routine location
	INTCON = $90 ' enable interrupt on pin RB0

' Turn LED on and keep it on until there is an interrupt
myloop:
	High led
	Goto myloop

' Interrupt handler
	Disable ' do not allow interrupts below this point
myint:
	Low led ' if we get here, turn LED off
	Pause 500 ' wait 0.5 seconds
	INTCON.1 = 0 ' clear interrupt flag
	Resume ' return to main program
	Enable ' allow interrupts again
End ' end of program
