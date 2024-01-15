.model large
.stack 100h
.data
	WINDOW_WIDTH DW 80d ; 80 znaków / 80 kolumn
	WINDOW_HEIGHT DW 25d ; 25 znaków / 25 rzędów

	GAME_WINDOW_START_X DB 10 ; początek okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_END_X DB 71  ; koniec okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_START_Y DB 2 ; początek okna właściwego gry (z pominięciem ramek) - nr rzędu
	GAME_WINDOW_END_Y DB 22 ; koniec okna właściwego gry (z pominięciem ramek) - nr rzędu

	PACMAN_X DW 10 		; pacman - pozycja X
	PACMAN_PREV_X DW 10 ; zmienna do zapamietywania poprzedniej pozycji X - uzywana do czyszczenia
	PACMAN_Y DW 10 		; pacman - pozycja Y
	PACMAN_PREV_Y DW 10 ; zmienna do zapamietywania poprzedniej pozycji Y - uzywana do czyszczenia
	PACMAN_SPEED DW 1   ; predkosc pacmana

	TIME_BEFORE DB 0 	  ; zmienna używana do sprawdzenia czy czas się zmienił (zegar)
	LAST_KEYSTROKE DB 61h ; zmienna zapisujaca ostatnio wcisniety klawisz (pacman porusza sie caly czas w tą stronę)

	BORDER_CHAR DB 0B1h  ; znak tla
	POINT_CHAR DB 07h 	 ; znak punktu
	PACMAN_CHAR DB 01h   ; znak pacmana

	PLAYER_LIVES DW 3                      ; liczba zyc gracza, domyslnie rowna 3
	LIVES_STRING DB 'LIVES', 0ah, 0dh, '$' ; napis lives do wypisania na ekranie
	SCORE_STRING DB 'SCORE', 0ah, 0dh, '$' ; napis score do wypisania ekranie
	PLAYER_SCORE DW 0      				   ; liczba punktów gracza, na starcie wynosi 0
	DIGIT_DISPLAY_NOE DB 0				   ; zmienna przechowujaca na ktorej pozycji ma zostac wyswietlona dana cyfra wyniku

	MAIN_MENU_STRING DB 'MAIN MENU', 0ah, 0dh, '$'
	PLAY_STRING DB 'PRESS P TO PLAY', 0ah, 0dh, '$'
	HELP_STRING DB 'PRESS H FOR HELP', 0ah, 0dh, '$'
	QUIT_STRING DB 'PRESS Q TO QUIT', 0ah, 0dh, '$'
	HELPPAGE_STRING_1 DB 'PRESS W TO MOVE UP', 0ah, 0dh, '$'
	HELPPAGE_STRING_2 DB 'PRESS A TO MOVE DOWN', 0ah, 0dh, '$'
	HELPPAGE_STRING_3 DB 'PRESS S TO MOVE LEFT', 0ah, 0dh, '$'
	HELPPAGE_STRING_4 DB 'PRESS D TO MOVE RIGHT', 0ah, 0dh, '$'
	HELPPAGE_STRING_5 DB 'PRESS R TO RESTART', 0ah, 0dh, '$'
	HELPPAGE_STRING_6 DB '<- PRESS Q TO BACK', 0ah, 0dh, '$'
	CURRENT_SCENE DB 0 ; 2 - HELP 1 - GRA, 0 - MAIN MENU

	MAP_WALLS_X DW 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 18, 19, 20, 18, 18, 18, 19, 20, 20, 20, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 19, 20, 18, 18, 19, 20, 18, 19, 20, 18, 19, 20, 22, 22, 22, 22, 22, 22, 22, 22, 22, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 31, 32, 33, 31, 33, 31, 33, 31, 33, 34, 35, 36, 37, 38, 39, 40, 30, 32, 32, 32, 39, 40, 39, 40, 39, 40, 37, 38, 35, 36, 37, 35, 35, 34, 35, 36, 37, 38, 34, 34, 36, 37, 38, 39, 40, 36, 36, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 31, 32, 31, 32, 30, 30, 30, 31, 32, 29, 28, 27, 26, 25, 24, 23, 23, 0
	MAP_WALLS_Y DW  3,  3,  3,  3,  3,  3,  4,  4,  4,  4,  4,  4,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6,  7,  7,  7,  7,  7,  7,  8,  8,  8,  8,  8,  8,  3,  3,  3,  4,  5,  7,  7,  7,  6,  5, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 12, 12, 12 ,12 ,12 ,12,  9,  9,  9, 10, 10, 10, 11, 11, 11, 12, 12, 12,  2,  3,  5,  6,  7,  8,  9, 10, 12,  2,  2,  2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6,  8,  8,  8,  8,  8,  8,  9,  9,  9,  9,  9,  9,  2,  2,  2,  4,  4,  5,  5,  6,  6,  2,  2,  2,  2,  2,  2,  2,  2,  4,  5,  6,  3,  3,  5,  5,  6,  6,  6,  6,  4,  4,  4,  5,  6,  8,  8,  8,  8,  8,  9, 10, 10, 10, 10, 10, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 10, 10,  9,  9, 10,  9,  8,  8,  8, 10, 10, 10, 10, 10, 10,  2,  3, 0
.code

clear_screen proc
	mov AH, 00h
	mov AL, 03h
	int 10h ; przerwanie

	; zmiana koloru tła
	mov AH, 0Bh
	mov BH, 00h
	mov BL, 00h ; czarne tło
	int 10h ; przerwanie

	ret
clear_screen endp

play_sound proc
	;smth music related
	in al,61h
	or al,3
	out 61h,al
	;stmh music related up

	mov bx, 0200h	; Standardowy dźwięk A, 440 Hz
	mov dx, 0012h	; górna część liczby 1234dd
	mov ax, 34DDh	; dolna część liczby 1234dd
	div bx		; ax = wartość do wysłania

	pushf		; zachowaj flagi
	push ax		; zachowaj wartość do wysłania
	cli		; wyłącz przerwania
	mov al,0b6h
	out 43h,al	; wyślij komendę

	pop ax
	out 42h,al	; wyślij pierwszą połowę licznika
	mov al,ah
	out 42h,al	; wyślij drugą połowę licznika
	popf		; przywróć stan flagi przerwań

	mov cx,0h
	mov dx,0F000h
	mov ah,86h
	int 15h


	in al,61h
	and al,not 3		; zerujemy bity 0 i 1
	out 61h, al
	ret
ret
play_sound endp

check_collision proc
	 ; ustawienie pozycji kursora na NOWĄ pozycję pacmana (juz przesunieta)
	mov AH, 02h
	mov BH, 0
	mov DH, byte ptr [PACMAN_Y] ;rzad
	mov DL, byte ptr [PACMAN_X] ; kolumna
	int 10h

	 ; odczytanie znaku z pozycji na której wylądować ma pacman
	mov AH, 08h
	mov BH, 0
	int 10h

	cmp AL, POINT_CHAR
	je point_detected

	 ; sprawdzenie czy znak jest równy '#'
	cmp AL, BORDER_CHAR
	je collision_detected

	 ; jeżeli nie, to czyścimy rejestr AL
	xor AL, AL
	ret

    collision_detected:
         ; jeżeli tak, ustawiamy rejestr AL na 1
        mov AL, 1
    ret

	point_detected:
		 ; zwiększanie punktów gracza jeśli punkt
		inc PLAYER_SCORE
		call play_sound
	ret
check_collision endp

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

        call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_y_up
    ret

    fix_pacman_y_up:
		mov AX, PACMAN_PREV_Y
        mov PACMAN_Y, AX
    ret
     ;---------------------------------
    MOVE_PACMAN_LEFT:
        mov LAST_KEYSTROKE, AL
        mov AX, PACMAN_SPEED
		sub PACMAN_X, AX

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_x_left
    ret

    fix_pacman_x_left:
		mov AX, PACMAN_PREV_X
        mov PACMAN_X, AX
    ret
     ;---------------------------------
    MOVE_PACMAN_DOWN:
        mov LAST_KEYSTROKE, AL
        mov AX, PACMAN_SPEED
        add PACMAN_Y, AX

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_y_down
    ret

    fix_pacman_y_down:
		mov AX, PACMAN_PREV_Y
        mov PACMAN_Y, AX
    ret
     ;---------------------------------
    MOVE_PACMAN_RIGHT:
        mov LAST_KEYSTROKE, AL
        mov AX, PACMAN_SPEED
        add PACMAN_X, AX

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_x_right
    ret

    fix_pacman_x_right:
		mov AX, PACMAN_PREV_X
        mov PACMAN_X, AX
    ret
     ;---------------------------------

move_pacman endp

draw_pacman proc
	 ; usun starego pacmana
     ; stawienie pozycji kursora
    mov AH, 02h
    mov BH, 0  				 ; numer strony
    mov DH, byte ptr [PACMAN_PREV_Y]
    mov DL, byte ptr [PACMAN_PREV_X]
    int 10h

     ; rysowanie pacmana
    mov AH, 0Ah
    mov AL, ' ' 			 ; zastępowanie poprzedniego znaku pustym
    mov BH, 0  				 ; numer strony
    mov CX, 1  				 ; liczba powtórzeń
    int 10h

	 ; rysuj nowego pacmana
     ; ustawienie pozycji kursora
    mov AH, 02h
    mov BH, 0   			 ; numer strony
    mov DH, byte ptr [PACMAN_Y]
    mov DL, byte ptr [PACMAN_X]
    int 10h

     ; rysowanie pacmana
    mov AH, 0Ah
    mov AL, PACMAN_CHAR	 ; wyświetlenie pacmana jako symbol
    mov BH, 0  				 ; numer strony
    mov CX, 1  				 ; liczba powtórzeń
    int 10h

    ret
draw_pacman endp

draw_border proc

	 ; rysowanie gornej krawedzi
    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, 0	 ; rzad
    mov DL, 0	 ; kolumna
    int 10h		 ; przerwanie

	 ; rysowanie znaku '#'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 80	; liczba powtorzen
    int 10h		; przerwanie

    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, 1	 ; rzad
    mov DL, 0	 ; kolumna
    int 10h		 ; przerwanie

	 ; rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 80	; liczba powtorzen
    int 10h		; przerwanie

	 ; rysowanie dolnej krawędzi
    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, 24	 ; rzad
    mov DL, 0	 ; kolumna
    int 10h		 ; przerwanie

	 ; rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 80	; liczba powtorzen
    int 10h		; przerwanie

    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, 23	 ; rzad
    mov DL, 0	 ; kolumna
    int 10h		 ; przerwanie

	 ; rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 80	; liczba powtorzen
    int 10h		; przerwanie

	mov BL, 1 ; w celu pominiecia dwoch pierwszych linii
SIDE_BORDER:
     ; inkrementujemy bl, aby przemieszczac sie po rzedach
    inc BL

     ; rysowanie lewej krawedzi
    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, BL	 ; rzad
    mov DL, 0	 ; kolumna
    int 10h		 ; przerwanie

     ; rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 10	; liczba powtorzen
    int 10h		; przerwanie

	 ; right border
    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, BL	 ; rzad
    mov DL, 70	 ; kolumna
    int 10h		 ; przerwanie

     ; rysowanie znaku '#'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 10	; liczba powtorzen
    int 10h		; przerwanie

    ; sprawdzamy warunek koncowy - czy BL jest rowne 22
    cmp BL, 22		 ; 22 bo pomijamy dwa ostatnie rzędy
    jne SIDE_BORDER  ; skocz do side_border jesli nie jest równe

    ret
draw_border endp

; to do potencjalnej zmiany
draw_box proc
	mov dh, 1
	xor bl, bl

	DRAW_BOX_JMP:

	inc BL
	inc DH

     ; ustawienie pozycji kursora, rysujemy box'a po lewej
    mov AH, 02h
    mov BH, 0
    inc DH       ; przenosimy sie do nastepnego rzędu
	mov dl, 8 	 ; ustawienie początku box'a na 8
    int 10h

     ; rysowanie box'a po osi x
    mov AH, 0Ah
    mov AL, BORDER_CHAR         ; tu wypisujemy znak
    mov BH, 0          			;  numer strony
    mov CX, 30         			; długość box'a
    int 10h

	 ; ustawienie pozycji kursora, rysujemy box'a po prawej
    mov AH, 02h
    mov BH, 0
	mov dl, 42
    int 10h

     ; rysowanie box'a po osi x
    mov AH, 0Ah
    mov AL, BORDER_CHAR
    mov BH, 0
    mov CX, 30
    int 10h

	cmp BL, 10 ; sprawdzamy czy wydrukowaliśmy 10 rzędów box'ów
	jne DRAW_BOX_JMP

    ret
draw_box endp

draw_box_array proc

	mov si, offset MAP_WALLS_X
	mov di, offset MAP_WALLS_Y

DRAW_BOX_ARRAY_LOOP:

    ; Sprawdzenie warunku zakończenia rysowania (wartość 0 w tablicy)
	mov cx, [di] ; dla porównania, nadpisywane potem przez 1
    cmp cx, 0
    je DRAW_BOX_ARRAY_END

    ; Ustawienie pozycji kursora - lewy górny
    mov AH, 02h
    mov BH, 0
    mov DH, [di] ; Wartość z tablicy MAP_WALLS używana jako numer rzędu
    mov DL, [si] ; Wartość z tablicy MAP_WALLS używana jako numer kolumny
    int 10h

    ; Rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah
    mov AL, BORDER_CHAR
    mov BH, 0
    mov CX, 1
    int 10h

	 ; Ustawienie pozycji kursora - prawy górny
	mov CH, 79
	sub CH, [si]

    mov AH, 02h
    mov BH, 0
    mov DH, [di] ; Wartość z tablicy MAP_WALLS używana jako numer rzędu
    mov DL, ch ; Wartość z tablicy z ch (wymiar okna po podjęciu zawartości tablicy)
    int 10h

    ; Rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah
    mov AL, BORDER_CHAR
    mov BH, 0
    mov CX, 1
    int 10h

	 ; Ustawienie pozycji kursora - prawy górny
	mov CL, 24
	sub CL, [di]

    mov AH, 02h
    mov BH, 0
    mov DH, cl ; Wartość z tablicy MAP_WALLS używana jako numer rzędu
    mov DL, [si] ; Wartość z tablicy z ch (wymiar okna po podjęciu zawartości tablicy)
    int 10h

    ; Rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah
    mov AL, BORDER_CHAR
    mov BH, 0
    mov CX, 1
    int 10h

	 ; Ustawienie pozycji kursora - prawy dolny
	mov CH, 79
	sub CH, [si]
	mov CL, 24
	sub CL, [di]

    mov AH, 02h
    mov BH, 0
    mov DH, cl ; Wartość z tablicy MAP_WALLS używana jako numer rzędu
    mov DL, ch ; Wartość z tablicy z ch (wymiar okna po podjęciu zawartości tablicy)
    int 10h

    ; Rysowanie znaku 'BORDER_CHAR'
    mov AH, 0Ah
    mov AL, BORDER_CHAR
    mov BH, 0
    mov CX, 1
    int 10h

    ; Przesunięcie offsetu do kolejnej wartości w tablicy MAP_WALLS
	add si, 2
	add di, 2

    ; Powrót do początku pętli
    jmp DRAW_BOX_ARRAY_LOOP

	DRAW_BOX_ARRAY_END:
    ret
draw_box_array endp

 ; funkcja wypełnia całą planszę punktami, które zjada nasz pacman
place_points proc ; DH - RZAD ; DL - KOLUMNA

     ; ustawienie pozycji startowej
    mov DH, GAME_WINDOW_START_Y
	dec DH

	NEXT_ROW:

		mov DL, GAME_WINDOW_START_X ; "wyzerowanie" kolumn
		inc DH						; zwiększenie numeru rzędu

    PLACE:

		mov AH, 02h
		mov BH, 0
		int 10h

		 ; odczytanie znaku w aktualnym polu
		mov AH, 08h
		mov BH, 0
		int 10h

		 ; jeżeli jest to # to pomijamy wypisanie znaku punktu
		cmp AL, BORDER_CHAR
		je SKIP_PLACE_POINT

		 ; wypisanie znaku punktu
		mov AH, 0Ah
		mov AL, POINT_CHAR
		mov BH, 0
		mov CX, 1
		int 10h

	SKIP_PLACE_POINT:

		inc DL 					  ; zwiększamy kolumnę o jeden
		cmp DL, GAME_WINDOW_END_X ; sprawdzamy czy skończyły się kolumny w rzędzie
		jne PLACE

		cmp DH, GAME_WINDOW_END_Y ; sprawdzamy czy skończyły się rzędy
		jne NEXT_ROW

	ret
place_points endp

; funkcja wyświetlająca znak na ekranie
display_integer proc
    ; konwersja wyniku gracza do ASCII
    mov CX, 10    ; dzielnik do konwersji na wartości decymalne
    mov BX, 0     ; licznik cyfr naszej liczby

    ; przypadek dla zera
    test AX, AX
    jnz NOT_ZERO

    mov DL, '0'
    mov AH, 02h
    int 21h

    ret

	NOT_ZERO:
		CONVERT_LOOP:
			xor DX, DX          ; wyczyszczenie poprzedniej reszty
			div CX              ; dzielenie AX przez 10, wynik w AX, reszta w DX
			push DX             ; push reszty na stos
			inc BX              ; zwiększenie liczby cyfr
			mov DIGIT_DISPLAY_NOE, 1 ; zmienna pomocnicza do "zwiększania liczby cyfr które mamy wyświetlić"
			test AX, AX         ; sprawdzenie czy iloraz to 0
			jnz CONVERT_LOOP    ; jeśli nie kontynuuj

		DISPLAY_LOOP:
			pop DX              ; zdjęcie wartości ze stosu
			add DL, '0'         ; konwersja do ASCII

			 ; wyświetlenie liczby
			mov AH, 02h
			int 21h

			 ; przesunięcie kursora na następną pozycję
			mov AH, 02h
			mov BH, 0
			mov DH, 0
			mov DL, 66 				  ; 66 to pierwszy numer wyniku
			add DL, DIGIT_DISPLAY_NOE ; przesunięcie o liczbę cyfr
			int 10h

			inc DIGIT_DISPLAY_NOE
			dec BX              ; zmniejszenie liczby cyfr do wyświetlenia
			jnz DISPLAY_LOOP    ; jeżeli więcej cyfr kontynuuj

    ret
display_integer endp

display_score proc
     ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany napis
    mov AH, 02h
    mov BH, 0
    mov DH, 0    ; rząd
    mov DL, 60   ; kolumna
    int 10h

	 ; wypisanie napisu 'SCORE'
	mov dx, offset SCORE_STRING
	mov ah, 9
	int 21h

	 ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany wynik (cyfra)
	mov AH, 02h
	mov BH, 0
	mov DH, 0
	mov DL, 66
	int 10h

	 ; funkcja wyświetlająca wynik gracza
	mov AX, PLAYER_SCORE
	call display_integer

    ret
display_score endp

display_lives proc
     ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany napis
    mov AH, 02h
    mov BH, 0
    mov DH, 0    ; rząd
    mov DL, 50   ; kolumna
    int 10h

	 ; wypisanie napisu 'LIVES'
	mov dx, offset LIVES_STRING
	mov ah, 9
	int 21h

	 ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany wynik (cyfra)
	mov AH, 02h
	mov BH, 0
	mov DH, 0
	mov DL, 56
	int 10h

	 ; funkcja wyświetlająca wynik gracza
	mov AX, PLAYER_LIVES
	call display_integer

    ret
display_lives endp

displayStringAtPosition MACRO row, col, string_ptr
		mov AH, 02h
		mov BH, 00h
		mov DH, row
		mov DL, col
		int 10h

		mov ah, 09h
		lea DX, string_ptr
		int 21h
ENDM

help_handler proc
		mov CURRENT_SCENE, 02h
		displayStringAtPosition 4, 4, HELPPAGE_STRING_1
		displayStringAtPosition 5, 4, HELPPAGE_STRING_2
		displayStringAtPosition 6, 4, HELPPAGE_STRING_3
		displayStringAtPosition 7, 4, HELPPAGE_STRING_4
		displayStringAtPosition 8, 4, HELPPAGE_STRING_5
		displayStringAtPosition 9, 4, HELPPAGE_STRING_6

		WRONG_BUTTON_HELP:
		mov AH, 00h
		int 16h

		cmp AL, 'q'
		je MENU_START
		cmp AL, 'Q'
		je MENU_START

		jmp WRONG_BUTTON_HELP
	ret
help_handler endp

draw_main_menu proc

	MENU_START:
	call clear_screen
	mov CURRENT_SCENE, 0h

	displayStringAtPosition 4, 4, MAIN_MENU_STRING
	displayStringAtPosition 5, 4, PLAY_STRING
	displayStringAtPosition 6, 4, HELP_STRING
	displayStringAtPosition 7, 4, QUIT_STRING

	call play_sound
	WRONG_BUTTON:

	mov AH, 00h
	int 16h

	cmp AL, 'P'
	je PLAY
	cmp AL, 'p'
	je PLAY
	cmp AL, 'H'
	je HELP
	cmp AL, 'h'
	je HELP
	cmp AL, 'Q'
	je QUIT
	cmp AL, 'q'
	je QUIT

	jmp WRONG_BUTTON

	PLAY:
		mov CURRENT_SCENE, 01h
			call clear_screen
			call draw_border
			call draw_box_array
			;call draw_box
			call place_points
			jmp DRAW_MAIN_END
	HELP:
		call help_handler
	QUIT:
		call clear_screen
		MOV AX, 4C00h
		int 21h

	DRAW_MAIN_END:
	ret
draw_main_menu endp

main proc
	 ; wczytywanie danych z segmentu .data
	xor AX, AX
	mov AX, @data
	mov DS, AX

	 ; ustawienie trybu video na 03h - tryb tekstowy + wyczyszczenie ekranu
	call clear_screen


	cmp CURRENT_SCENE, 0
	je MAIN_MENU

	CHECK_TIME:
	mov AH, 2Ch 		; weź czas systemowy
	int 21h				; CH = hour CL = minute DH = second DL = 1/100 seconds

	cmp DL, TIME_BEFORE ; porównujemy czas systemowy do jego poprzedniej wartości
	je CHECK_TIME 		; jeżeli jest taki sam sprawdź jeszcze raz

	mov TIME_BEFORE, DL ; aktualizacja czasu

	 ; nowy delay - chyba dziala - blad zwiazany z dosboxem!!! (przechodzi samo w 87h przez brak break'a)
    mov cx, 00h
	mov dx, 0FFFFh
	mov ah, 86h
	int 15h

	mov cx, 00h
	mov dx, 0FFFFh
	mov ah, 86h
	int 15h

	call display_lives
	call display_score
	call move_pacman
	call draw_pacman

	jmp CHECK_TIME 		; powtarzamy proces

	MAIN_MENU:
		call draw_main_menu
		jmp CHECK_TIME

	;mov AX, 4C00h 		; zakończenie programu
	;int 21h
main endp
end main