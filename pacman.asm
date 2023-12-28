.model small
.stack 100h
.data
	WINDOW_WIDTH DW 320d ; szerokosc - 320px
	WINDOW_HEIGHT DW 200d ; wysokosc - 200px 
	PACMAN_X DW 41d ; pacman - pozycja X
	PACMAN_PREV_X DW 41d ; zmienna do zapamietywania poprzedniej pozycji X - uzywana do czyszczenia
	PACMAN_Y DW 26d ; pacman - pozycja Y
	PACMAN_PREV_Y DW 26D ; zmienna do zapamietywania poprzedniej pozycji Y - uzywana do czyszczenia
	PACMAN_SPEED DW 05h ; predkosc pacmana
	PACMAN_SIZE DW 06h ; rozmiar pacmana - szerokosc i wysokosc
	TIME_BEFORE DB 0 ; zmienna używana do sprawdzenia czy czas się zmienił (zegar)
	LAST_KEYSTROKE DB 44h ; zmienna zapisujaca ostatnio wcisniety klawisz (pacman porusza sie caly czas w tą stronę)
	
	GAME_START_POINT_X DW 41d ;
	GAME_START_POINT_Y DW 26d ;
	GAME_END_POINT_X DW 279d ;
	GAME_END_POINT_Y DW 174d ;
	
	GAME_WIDTH	DW 240d ; unused
	GAME_HEIGHT DW 150d ; unused
.code
main proc
	; wczytywanie danych z segmentu .data
	xor AX, AX
	mov AX, @data
	mov DS, AX
	
	call clear
	call draw_map
	CHECK_TIME:
	
	mov AH, 2Ch ; weź czas systemowy	
	int 21h	; CH = hour CL = minute DH = second DL = 1/100 seconds
	
	cmp DL, TIME_BEFORE ; porównujemy czas systemowy do jego poprzedniej wartości
	je CHECK_TIME ; jeżeli jest taki sam sprawdź jeszcze raz
	
	mov TIME_BEFORE, DL ; aktualizacja czasu
	
	call move_pacman
	call draw_pacman
	
	jmp CHECK_TIME ; powtarzamy proces
	
	;mov AX, 4C00h ; zakończenie programu
	;int 21h
main endp

move_pacman proc	
	 ; sprawdz czy wcisniety jest przycisk - jesli nie, nic nie rob
	mov AH, 01h
	int 16h
	jnz NO_MOVE
	mov AL, LAST_KEYSTROKE
	 ; sprawdz ktory przycisk jest wcisniety, w rejestrze AL jest zapisana wartosc ASCII tego przycisku
	jmp MOVE
	NO_MOVE:	
	mov AH, 00h
	int 16h
	MOVE:
	
	 ; zapisywanie poprzedniej pozycji pacmana, w celu wyczyszczenia
	mov BX, PACMAN_X
	mov CX, PACMAN_Y
	mov PACMAN_PREV_X, BX
	mov PACMAN_PREV_Y, CX
	
	 ; jezeli wcisniety przycisk jest rowny 'w' lub 'W' to rusz się do góry
	cmp AL, 77h ; 'w'
	je MOVE_PACMAN_UP
	cmp AL, 57h ; 'W'
	je MOVE_PACMAN_UP
	 ; jezeli wcisniety przycisk jest rowny 'a' lub 'A' to rusz się w lewo
	cmp AL, 61h ; 'a'
	je MOVE_PACMAN_LEFT
	cmp AL, 41h ; 'A'
	je MOVE_PACMAN_LEFT
	 ; jezeli wcisniety przycisk jest rowny 's' lub 'S' to rusz się w dół
	cmp AL, 73h ; 's'
	je MOVE_PACMAN_DOWN
	cmp AL, 53h ; 'S'
	je MOVE_PACMAN_DOWN
	 ; jezeli wcisniety przycisk jest rowny 'd' lub 'D' to rusz się w prawo
	cmp AL, 64h ; 'd'
	je MOVE_PACMAN_RIGHT
	cmp AL, 44h ; 'D'
	je MOVE_PACMAN_RIGHT
	
	ret
	;---------------------------------
	MOVE_PACMAN_UP:
		mov LAST_KEYSTROKE, AL
		mov AX, PACMAN_SPEED
		sub PACMAN_Y, AX
		
		mov DX, GAME_START_POINT_Y;
		cmp PACMAN_Y, DX;
		jl fix_pacman_y_up
	ret
	
	fix_pacman_y_up:
		mov PACMAN_Y, DX
	ret
	;---------------------------------
	MOVE_PACMAN_LEFT:
		mov LAST_KEYSTROKE, AL
		mov AX, PACMAN_SPEED
		sub PACMAN_X, AX
		
		mov DX, GAME_START_POINT_X;
		cmp PACMAN_X, DX
		jl fix_pacman_x_left
	ret
	
	fix_pacman_x_left:
		mov PACMAN_X, DX 
	ret
	;---------------------------------
	MOVE_PACMAN_DOWN:
		mov LAST_KEYSTROKE, AL
		mov AX, PACMAN_SPEED
		add PACMAN_Y, AX
		
		mov DX, GAME_END_POINT_Y
		sub DX, PACMAN_SIZE
		cmp PACMAN_Y, DX;
		jnl fix_pacman_y_down
	ret
	
	fix_pacman_y_down:
		mov PACMAN_Y, DX 
	ret
	;---------------------------------
	MOVE_PACMAN_RIGHT:
		mov LAST_KEYSTROKE, AL
		mov AX, PACMAN_SPEED
		add PACMAN_X, AX
		
		mov DX, GAME_END_POINT_X;
		sub DX, PACMAN_SIZE
		cmp PACMAN_X, DX;
		jnl fix_pacman_x_right
	ret
	
	fix_pacman_x_right:
		mov PACMAN_X, DX 
	ret
	;---------------------------------
move_pacman endp

; procedura rysujaca pacmana
draw_pacman proc
	 ; czyszczenie poprzedniego narysowanego pacmana
	mov CX, PACMAN_PREV_X ; poprzednia wspolrzedna X
	mov DX, PACMAN_PREV_Y ; poprzednia wspolrzedna Y
	
	clear_previous_pacman_position:
		mov AH, 0Ch ; tryb rysowania pikseli
		mov AL, 00h ; kolor piksela - czarny
		mov BH, 00h ; numer strony
		int 10h ; przerwanie
		
		inc CX ; przesuwamy sie piksel po pikselu
		mov AX, CX
		sub AX, PACMAN_PREV_X
		cmp AX, PACMAN_SIZE
		jng clear_previous_pacman_position
		
		mov CX, PACMAN_PREV_X
		inc DX ; zmiana rzędu
		mov AX, DX
		sub AX, PACMAN_PREV_Y
		cmp AX, PACMAN_SIZE
		jng clear_previous_pacman_position

	 ; rysowanie pacmana na nowej pozycji
	mov CX, PACMAN_X ; new x position
	mov DX, PACMAN_Y ; new y position
	
	draw_pacman_horizontal:
		mov AH, 0Ch ; tryb rysowania pikseli
		mov AL, 0Eh ; kolor piksela - zolty
		mov BH, 00h ; numer strony
		int 10h ; przerwanie
		
		inc CX ; przesuwamy sie piksel po pikselu
		mov AX, CX
		sub AX, PACMAN_X
		cmp AX, PACMAN_SIZE
		jng draw_pacman_horizontal
		
		mov CX, PACMAN_X
		inc DX ; zmiana rzędu
		mov AX, DX
		sub AX, PACMAN_Y
		cmp AX, PACMAN_SIZE
		jng draw_pacman_horizontal

	ret
draw_pacman endp

clear proc
	mov AH, 00h ; tryb video
	mov AL, 0Dh ; wybór trybu video - 320x200 16 color graphics (EGA,VGA)
	int 10h ; przerwanie
	
	; zmiana koloru tła
	mov AH, 0Bh 
	mov BH, 00h
	mov BL, 00h ; czarne tło
	int 10h ; przerwanie
	
	ret
clear endp


; do skomentowania
draw_map proc
	
	mov CX, 0 ; pozycja startowa x
	mov DX, 0 ; pozycja startowa y

	
	draw_border_horizontal:
		mov AH, 0Ch ; tryb rysowania pikseli
		mov AL, 09h ; kolor piksela
		mov BH, 00h ; numer strony
		int 10h	; przerwanie
		inc CX ; zwiekszamy CX, az do rozmiaru pacman_size
		mov AX, CX 
		cmp AX, WINDOW_WIDTH ; sprawdzamy czy liczba przesuniec w prawo jest równa rozmiarowi pacmana 
		jng draw_border_horizontal
		mov CX, 0
		inc DX
		mov AX, DX
		cmp AX, WINDOW_HEIGHT; sprawdzamy czy liczba przesuniec w dol jest rowna rozmiarowi pacmana
		jng draw_border_horizontal
	
	mov CX, GAME_START_POINT_X ; pozycja startowa x
	mov DX, GAME_START_POINT_Y ; pozycja startowa y
	
	
	draw_map_horizontal:
		mov AH, 0Ch ; tryb rysowania pikseli
		mov AL, 00h ; kolor piksela
		mov BH, 00h ; numer strony
		int 10h	; przerwanie
		inc CX ; zwiekszamy CX, az do rozmiaru pacman_size
		mov AX, CX 
		cmp AX, GAME_END_POINT_X ; sprawdzamy czy liczba przesuniec w prawo jest równa rozmiarowi pacmana 
		jng draw_map_horizontal
		mov CX, GAME_START_POINT_X;
		inc DX
		mov AX, DX
		cmp AX, GAME_END_POINT_Y ; sprawdzamy czy liczba przesuniec w dol jest rowna rozmiarowi pacmana
		jng draw_map_horizontal
	
	ret
	
	

draw_map endp

end main