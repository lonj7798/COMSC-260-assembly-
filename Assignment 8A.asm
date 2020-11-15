TITLE Assignment 8A (Assignment 8A.asm)

; Program Description : Draw an 8x8 chess board (gray + white)
; can use SetTextColor, Gotoxy. Avoid using global variable.
; Author: Jaewon Lee					Creation Date : 11 / 14 / 2020



INCLUDE Irvine32.inc

OddColDrawing PROTO times:byte
EvenColDrawing PROTO times:byte
WriteSquare PROTO color:dword

.data
	 grayColor = gray + (gray * 16)					   ; gray color text + gray color background
	 whiteColor = white + (white * 16)				   ; white color text + white color background
	 defaultColor = white + (black * 16)			   ; default value of color (white text, black background)
	 row = 8										   ; number of row
	 col = 8										   ; number of col


.code
	 main PROC
		  mov ecx, col/2							   ; repeat 4 times (half of col: L1)
		  L1:
			   invoke OddColDrawing, row/2			   ; invoke OddColDrawing with row/2 which will be a counter of the loop
			   invoke EvenColDrawing, row/2			   ; invoke EvenColDrawing with row / 2 which will be a counter of the loop
		  loop L1

		  mov eax, defaultColor						   ; return to the initial value of the color
		  call SetTextColor							   ; set color as default

		  exit
	 main ENDP	   


	 ; Odd row's color -> white gray white gray ----
	 OddColDrawing PROC uses ecx, times:byte		   ; only needs counter
		  movzx ecx, times							   ; pass ecx to the times
		  L2:
			   invoke WriteSquare, whiteColor		   ; invoke writeSquare, with white color
			   invoke WriteSquare, grayColor		   ; invoke writeSquare, with gray color
		  loop L2
													   ; line will be (W G W G W G W G)
		  call crlf									   ; change the line
		  ret
	 OddColDrawing ENDP

	 ; Even col's color -> gray whtie gray white ----
	 EvenColDrawing PROC uses ecx, times:byte		   ; only needs counter
		  movzx ecx, times							   ; pass ecx to the times
		  L2:
			   invoke WriteSquare, grayColor		   ; invoke writeSquare, with gray color
			   invoke WriteSquare, whiteColor		   ; invoke writeSquare, with white color
		  loop L2
													   ; line will be (G W G W G W G W)
		  call crlf									   ; change the line
		  ret
	 EvenColDrawing ENDP

	 ; Write a square with a specific color
	 WriteSquare PROC uses eax, color:dword
		  mov eax, color							   ; pass the color variable to eax for SetTextCplor
		  call SetTextColor							   ; set the color of the text with eax
		  mov al, ' '								   ; variable that will be printed with a color
		  call WriteChar							   ; print ' ' with color
		  call WriteChar							   ; print ' ' with color
		  ret
	 WriteSquare ENDP

END main