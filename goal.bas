' Identify and set the internal oscillator clock speed (required for the PIC16F88)
DEFINE OSC 8
OSCCON.4 = 1
OSCCON.5 = 1
OSCCON.6 = 1

' Turn off the A/D converter (required for the PIC16F88)
ANSEL = 0

P1_goal var PORTA.0
P2_goal var PORTA.1

TRISA = %00000011 'set RA0 and RA1 to inputs

i var BYTE 'counter variable

P1_red var PORTB.0
P1_green var PORTB.1
P1_blue var PORTB.2

P2_red var PORTB.3
P2_green var PORTB.4
P2_blue var PORTB.5

TRISB = %00000000 'set RB0-RB5 to outputs

'OPTION_REG = $7f 'Enable PORTB pull-ups

main:
    If P1_goal = 1 Then
    Goto P1
    Endif
    If P2_goal = 1 Then
    Goto P1
    Endif
    Goto main
    END

P1:
    High P2_red
    For i = 1 To 3
        High P1_blue
        Pause 200
        Low P1_blue
        Pause 200
        Next i
    Low P2_red
    Goto main
    END

P2:
    High P1_red
    For i = 1 To 3
        High P2_blue
        Pause 200
        Low P2_blue
        Pause 200
        Next i
    Low P1_red
    Goto main
    END