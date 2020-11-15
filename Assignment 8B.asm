TITLE Assignment 8B (Assignment 8B.asm)

; Program Description : Draw an 8x8 chess board (gray + white)
; can use SetTextColor, Gotoxy. Avoid using global variable.
; Every 500 milliseconds, change the color of the colored square. (16 different colors, white is remain.)
; black:  0		red:	 4	  gray: 8			  lightRed: 12
; blue:	  1		magenta: 5	  lightBlue: 9		  lightMagenta: 13
; green:  2		brown:	 6	  lightGreen: 10	  yellow:		14
; cyan:	  3		lightGray: 11 lightCyan: 11		  white: 15

; Author: Jaewon Lee					Creation Date : 11 / 14 / 2020



INCLUDE Irvine32.inc

ColorChange PROTO color:dword
OddColDrawing PROTO times:byte, color:dword
EvenColDrawing PROTO times:byte, color:dword
WriteSquare PROTO color:dword

.data
	 whiteColor = white + (white * 16)							 ; white color text + white color background
	 defaultColor = white + (black * 16)						 ; default value of color (white text, black background)
	 row = 8													 ; number of row
	 col = 8													 ; number of col

	 counter byte 0												 ; variable for changing the color, counting the loop
	 loopCount dword ?											 ; for L0's nested loop
	 pauseTime = 500											 ; delay 500 milliseconds
	 numberOfColor = 16											 ; number of color (loop)
.code
	 main PROC
		  mov ecx, numberOfColor

		  L0:
			   invoke ColorChange, counter						  ; return color value (saved in edx)
			   inc counter
			   
			   mov loopCount, ecx								  ; nested loop (need to save ecx-L0 value)
			   mov ecx, col/2									  ; repeat 4 times (half of col: L1)

			   L1:
					invoke OddColDrawing, row/2, edx			  ; invoke OddColDrawing with row/2 which will be a counter of the loop
					invoke EvenColDrawing, row/2, edx			  ; invoke EvenColDrawing with row / 2 which will be a counter of the loop
			   loop L1

			   mov ecx, loopCount								  ; nested loop (pass the L0 loop count to ecx)
			   
			   mov eax,500										  ; delay 500 ms
			   call Delay										  ; delay 500 ms

			   mov eax, defaultColor							  ; return to the initial value of the color
			   call SetTextColor								  ; set color as default
			   
			   call Clrscr										  ; clean the screen (SetTextColr affects Clrscr)

		  loop L0



		  exit
	 main ENDP	   

	 ; Change the color -> color value = color + (color * 16)
	 ColorChange PROC uses eax, color: dword
		  mov eax, color										  ; changed color = value * 17
		  mov ebx, 17
		  mul ebx

		  mov edx, eax
		  ret
	 Colorchange ENDP


	 ; Odd row's color -> white gray white gray ----
	 OddColDrawing PROC uses ecx, times:byte, color: dword		   ; only needs counter
		  movzx ecx, times										   ; pass ecx to the times
		  L2:
			   invoke WriteSquare, whiteColor					   ; invoke writeSquare, with white color
			   invoke WriteSquare, color						   ; invoke writeSquare, with gray color
		  loop L2
																   ; line will be (W C W C W C W C)
		  call crlf											       ; change the line
		  ret
	 OddColDrawing ENDP

	 ; Even col's color -> gray whtie gray white ----
	 EvenColDrawing PROC uses ecx, times:byte, color: dword		   ; only needs counter
		  movzx ecx, times										   ; pass ecx to the times
		  L2:
			   invoke WriteSquare, color						   ; invoke writeSquare, with gray color
			   invoke WriteSquare, whiteColor					   ; invoke writeSquare, with white color
		  loop L2
																   ; line will be (C W C W C W C W)
		  call crlf												   ; change the line
		  ret
	 EvenColDrawing ENDP

	 ; Write a square with a specific color
	 WriteSquare PROC uses eax, color:dword
		  mov eax, color										   ; pass the color variable to eax for SetTextCplor
		  call SetTextColor										   ; set the color of the text with eax
		  mov al, ' '											   ; variable that will be printed with a color
		  call WriteChar										   ; print ' ' with color
		  call WriteChar										   ; print ' ' with color
		  ret
	 WriteSquare ENDP

END main