'polling.bas
'rewrite of onint.bas to use polling instead of interrupts
'this program turns on an LED and checks for PORTB.0 to go HIGH. When RB0 changes from low to high, this program turns the LED off for 0.5 seconds then resumes normal execution.

'Identify and set the internal oscillator clock speed (required for the PIC16F88)
DEFINE OSC 8
OSCCON.4 = 1
OSCCON.5 = 1
OSCCON.6 = 1

' Turn off the A/D converter (required for the PIC16F88)
ANSEL = 0

led var PORTB.7 ' define variable led
	OPTION_REG = $7f 'Enable PORTB pull-ups
	TRISB = %00000001 'set PORTB.0 to input, all others outputs

loopsforever:
	High led 'turn on led
	If PORTB.0 = 0 Then 'If button is pressed
	Low led 'turn off led
	Pause 500 'wait 0.5 seconds
	Endif
	Pause 200 'debounce pause
	Goto loopsforever 'loopforeverandeverandeverandever

	END

