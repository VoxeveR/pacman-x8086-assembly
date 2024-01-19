.286
.model small
.stack 100h
.data


	WINDOW_WIDTH DW 80d ; 80 znaków / 80 kolumn
	WINDOW_HEIGHT DW 25d ; 25 znaków / 25 rzędów

	GAME_WINDOW_START_X DB 10 ; początek okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_END_X DB 70  ; koniec okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_START_Y DB 1 ; początek okna właściwego gry (z pominięciem ramek) - nr rzędu
	GAME_WINDOW_END_Y DB 22 ; koniec okna właściwego gry (z pominięciem ramek) - nr rzędu

	PACMAN_X DB 10 		; pacman - pozycja X
	PACMAN_PREV_X DB 10 ; zmienna do zapamietywania poprzedniej pozycji X - uzywana do czyszczenia
	PACMAN_Y DB 10 		; pacman - pozycja Y
	PACMAN_PREV_Y DB 10 ; zmienna do zapamietywania poprzedniej pozycji Y - uzywana do czyszczenia
	PACMAN_SPEED DB 1   ; predkosc pacmana, najlepiej nie zmieniac gdyz jest to tryb tekstowy
	PACMAN_COLOR DW 0Eh


	 ; czerwony duszek
	BLINKY_X DB 44
	BLINKY_PREV_X DB 43
	BLINKY_Y DB 9
	BLINKY_PREV_Y DB 9
	BLINKY_COLOR DW 0Ch
	BLINKY_OVERRIDE_COLOR DW 0Fh;
	BLINKY_OVERRIDE_CHAR DB 07h ; char ktorego nadpisal duszek
	BACKWARDS_CHECK_BLINKY DB 0b
	BACKWARDS_CHECK_BLINKY_BACKUP DB 0b

	PINKY_X DB 35
	PINKY_PREV_X DB 35
	PINKY_Y DB 9
	PINKY_PREV_Y DB 9
	PINKY_COLOR DW 0Dh
	PINKY_OVERRIDE_COLOR DW 0Fh;
	PINKY_OVERRIDE_CHAR DB 07h ; char ktorego nadpisal duszek
	BACKWARDS_CHECK_PINKY DB 0b
	BACKWARDS_CHECK_PINKY_BACKUP DB 0b

	INKY_X DB 44
	INKY_PREV_X DB 44
	INKY_Y DB 15
	INKY_PREV_Y DB 15
	INKY_COLOR DW 0Bh
	INKY_OVERRIDE_COLOR DW 0Fh;
	INKY_OVERRIDE_CHAR DB 07h ; char ktorego nadpisal duszek
	BACKWARDS_CHECK_INKY DB 0b
	BACKWARDS_CHECK_INKY_BACKUP DB 0b

	CLYDE_X DB 35
	CLYDE_PREV_X DB 35
	CLYDE_Y DB 15
	CLYDE_PREV_Y DB 15
	CLYDE_COLOR DW 06h
	CLYDE_OVERRIDE_COLOR DW 0Fh;
	CLYDE_OVERRIDE_CHAR DB 07h ; char ktorego nadpisal duszek
	BACKWARDS_CHECK_CLYDE DB 0b
	BACKWARDS_CHECK_CLYDE_BACKUP DB 0b

	TIME_BEFORE DB 0 	  ; zmienna używana do sprawdzenia czy czas się zmienił (zegar)
	LAST_KEYSTROKE DB 61h ; zmienna zapisujaca ostatnio wcisniety klawisz (pacman porusza sie caly czas w tą stronę)

	BORDER_CHAR DB 0B1h  ; znak tla
	POINT_CHAR DB 07h 	 ; znak punktu
	PACMAN_CHAR DB 01h   ; znak pacmana
	GHOST_CHAR DB 21h ; znak duszka

	PLAYER_LIVES DW 3                      ; liczba zyc gracza, domyslnie rowna 3
	LIVES_STRING DB 'LIVES', 0ah, 0dh, '$' ; napis lives do wypisania na ekranie
	SCORE_STRING DB 'SCORE', 0ah, 0dh, '$' ; napis score do wypisania ekranie
	PLAYER_SCORE DW 0      				   ; liczba punktów gracza, na starcie wynosi 0
	TOTAL_POINT DW 0                 ; liczba punktow rysowanych na mapie
	DIGIT_DISPLAY_NOE DB 0				   ; zmienna przechowujaca na ktorej pozycji ma zostac wyswietlona dana cyfra wyniku

	DIFFICULTY_LEVEL DB 0 ; 0 - EASY, 1 - NORMAL, 2 - HARD

	DIFFICULTY_EASY_STRING DB 'PRESS D TO CHANGE DIFFICULTY: EASY  ', 0ah, 0dh, '$'
	DIFFICULTY_NORMAL_STRING DB 'PRESS D TO CHANGE DIFFICULTY: NORMAL', 0ah, 0dh, '$'
	DIFFICULTY_HARD_STRING DB 'PRESS D TO CHANGE DIFFICULTY: HARD', 0ah, 0dh, '$'

	MAIN_MENU_STRING DB 'MAIN MENU', 0ah, 0dh, '$'
	LAST_SCORE_STRING DB 'LAST SCORE: ', 0ah, 0dh, '$'
	PLAY_STRING DB 'PRESS P TO PLAY', 0ah, 0dh, '$'
	HELP_STRING DB 'PRESS H FOR HELP', 0ah, 0dh, '$'
	QUIT_STRING DB 'PRESS Q TO QUIT', 0ah, 0dh, '$'
	HELPPAGE_STRING_1 DB 'PRESS W TO MOVE UP', 0ah, 0dh, '$'
	HELPPAGE_STRING_2 DB 'PRESS A TO MOVE DOWN', 0ah, 0dh, '$'
	HELPPAGE_STRING_3 DB 'PRESS S TO MOVE LEFT', 0ah, 0dh, '$'
	HELPPAGE_STRING_4 DB 'PRESS D TO MOVE RIGHT                ', 0ah, 0dh, '$'
	HELPPAGE_STRING_5 DB 'PRESS R TO RESTART', 0ah, 0dh, '$'
	HELPPAGE_STRING_6 DB '<- PRESS Q TO BACK', 0ah, 0dh, '$'
	LIVE_LOST_STRING db 'U HAVE LOST A LIVE! BE CAREFUL!', 0ah, 0dh, '$'
	CURRENT_SCENE DB 0 ; 2 - HELP 1 - GRA, 0 - MAIN MENU

	MAP_WALLS_X DW 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 18, 19, 20, 18, 18, 18, 19, 20, 20, 20, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 19, 20, 18, 18, 19, 20, 18, 19, 20, 18, 19, 20, 22, 22, 22, 22, 22, 22, 22, 22, 22, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 24, 25, 26, 27, 28, 29, 31, 32, 33, 31, 33, 31, 33, 31, 33, 34, 35, 36, 37, 38, 39, 40, 30, 32, 32, 32, 39, 40, 39, 40, 39, 40, 37, 38, 35, 36, 37, 35, 35, 34, 35, 36, 37, 38, 34, 34, 36, 37, 38, 39, 40, 36, 36, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 31, 32, 31, 32, 30, 30, 30, 31, 32, 29, 28, 27, 26, 25, 24, 23, 23, 39, 38, 37, 36, 39, 38, 37, 36, 0
	MAP_WALLS_Y DW  3,  3,  3,  3,  3,  3,  4,  4,  4,  4,  4,  4,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6,  7,  7,  7,  7,  7,  7,  8,  8,  8,  8,  8,  8,  3,  3,  3,  4,  5,  7,  7,  7,  6,  5, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 12, 12, 12 ,12 ,12 ,12,  9,  9,  9, 10, 10, 10, 11, 11, 11, 12, 12, 12,  2,  3,  5,  6,  7,  8,  9, 10, 12,  2,  2,  2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6,  8,  8,  8,  8,  8,  8,  9,  9,  9,  9,  9,  9,  2,  2,  2,  4,  4,  5,  5,  6,  6,  2,  2,  2,  2,  2,  2,  2,  2,  4,  5,  6,  3,  3,  5,  5,  6,  6,  6,  6,  4,  4,  4,  5,  6,  8,  8,  8,  8,  8,  9, 10, 10, 10, 10, 10, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 10, 10,  9,  9, 10,  9,  8,  8,  8, 10, 10, 10, 10, 10, 10,  2 , 3, 11, 11, 11, 11, 12, 12, 12 ,12, 0
.code

displayStringAtPosition MACRO row, col, string_ptr
	pusha
		mov AH, 02h
		mov BH, 00h
		mov DH, row
		mov DL, col
		int 10h

		mov ah, 09h
		lea DX, string_ptr
		int 21h
	popa
ENDM

setCursor MACRO x, y
	pusha

	mov AH, 02h				 ; przerwanie ustawiające pozycję kursora
    mov BH, 0  				 ; numer strony
    mov DH, y    ; rząd
    mov DL, x	 ; kolumna
    int 10h

	popa
ENDM

drawSymbol MACRO symbol, color, repeatCount
	pusha

    mov AH, 09h				 ; przerwanie wyświetlające znak na pozycji kursora
    mov AL, symbol 			 ; zastępowanie poprzedniego znaku wybranym symbolem
	mov BX, color			 ; kolor pacmana
	mov BH, 0                ; numer strony
    mov CX, repeatCount 	 ; liczba powtórzeń
    int 10h

	popa
ENDM

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

draw_pacman proc
	 ; usun starego pacmana
     ; ustawienie pozycji kursora
	setCursor PACMAN_PREV_X, PACMAN_PREV_Y
     ; zastepowanie starego pacmana pustym znakiem
	drawSymbol ' ', 0, 1

	 ; rysuj nowego pacmana
     ; ustawienie pozycji kursora
	setCursor PACMAN_X, PACMAN_Y
     ; rysowanie pacmana
	drawSymbol PACMAN_CHAR, PACMAN_COLOR, 1

    ret
draw_pacman endp

draw_border proc

	 ; rysowanie gornej krawedzi
	setCursor 0, 0
	 ; rysowanie znaku '#'
	drawSymbol BORDER_CHAR, 7, 80

	setCursor 0, 1
	drawSymbol BORDER_CHAR, 7, 80

	 ; rysowanie dolnej krawędzi
	setCursor 0, 24
	drawSymbol BORDER_CHAR, 7, 80

	setCursor 0, 23
	drawSymbol BORDER_CHAR, 7, 80

	mov BL, 1 ; w celu pominiecia dwoch pierwszych linii
SIDE_BORDER:
     ; inkrementujemy bl, aby przemieszczac sie po rzedach
    inc BL

     ; rysowanie lewej krawedzi
	setCursor 0, BL
	drawSymbol BORDER_CHAR, 7, 10

	 ; rysowanie prawej krawedzi
	setCursor 70, BL
	drawSymbol BORDER_CHAR, 7, 10

    ; sprawdzamy warunek koncowy - czy BL jest rowne 22
    cmp BL, 22		 ; 22 bo pomijamy dwa ostatnie rzędy
    jne SIDE_BORDER  ; skocz do side_border jesli nie jest równe

    ret
draw_border endp

draw_box_array proc
	pusha
	mov si, offset MAP_WALLS_X
	mov di, offset MAP_WALLS_Y
	mov bl, 07h
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
    mov AH, 09h
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
    mov AH, 09h
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
    mov AH, 09h
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
    mov AH, 09h
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
	popa
    ret
draw_box_array endp

 ; funkcja wypełnia całą planszę punktami, które zjada nasz pacman
place_points proc ; DH - RZAD ; DL - KOLUMNA
	pusha

     ; ustawienie pozycji startowej
    mov DH, GAME_WINDOW_START_Y
	NEXT_ROW:

		mov DL, GAME_WINDOW_START_X ; "wyzerowanie" kolumn
		inc DH						; zwiększenie numeru rzędu

    PLACE:

		setCursor DL, DH

		 ; odczytanie znaku w aktualnym polu
		mov AH, 08h
		mov BH, 0
		int 10h

		 ; jeżeli jest to # to pomijamy wypisanie znaku punktu
		cmp AL, BORDER_CHAR
		je SKIP_PLACE_POINT

		cmp AL, ' '
		jne SKIP_PLACE_POINT

		 ; wypisanie znaku punktu
		drawSymbol POINT_CHAR, 0Fh, 1
		;inc TOTAL_POINT
	SKIP_PLACE_POINT:

		inc DL 					  ; zwiększamy kolumnę o jeden
		cmp DL, GAME_WINDOW_END_X ; sprawdzamy czy skończyły się kolumny w rzędzie
		jne PLACE

		cmp DH, GAME_WINDOW_END_Y ; sprawdzamy czy skończyły się rzędy
		jne NEXT_ROW
	;sub TOTAL_POINT, 1

	mov TOTAL_POINT, 518

	;setCursor 10, 10
	;drawSymbol 'X' 0Fh, 1

	popa
	ret
place_points endp

load_defaults proc
	mov PACMAN_X, 10
	mov PACMAN_PREV_X, 10
	mov PACMAN_Y, 10
	mov PACMAN_PREV_Y, 10

	mov BLINKY_X, 44
	mov BLINKY_PREV_X, 44
	mov BLINKY_Y, 9
	mov BLINKY_PREV_Y, 9
	mov BACKWARDS_CHECK_BLINKY, 0b
	mov BACKWARDS_CHECK_BLINKY_BACKUP, 0b
	mov BLINKY_OVERRIDE_CHAR, 07h
	mov BLINKY_OVERRIDE_COLOR, 0Fh

	mov PINKY_X, 35
	mov PINKY_PREV_X, 35
	mov PINKY_Y, 10
	mov PINKY_PREV_Y, 10
	mov PINKY_OVERRIDE_COLOR, 0Fh;
	mov PINKY_OVERRIDE_CHAR, 07h
	mov BACKWARDS_CHECK_PINKY, 0b
	mov BACKWARDS_CHECK_PINKY_BACKUP, 0b

	mov INKY_X, 44
	mov INKY_PREV_X, 44
	mov INKY_Y, 15
	mov INKY_PREV_Y, 15
	mov INKY_OVERRIDE_COLOR, 0Fh;
	mov INKY_OVERRIDE_CHAR, 07h
	mov BACKWARDS_CHECK_INKY, 0b
	mov BACKWARDS_CHECK_INKY_BACKUP, 0b

	mov CLYDE_X, 35
	mov CLYDE_PREV_X, 35
	mov CLYDE_Y, 15
	mov CLYDE_PREV_Y, 15
	mov CLYDE_OVERRIDE_COLOR, 0Fh;
	mov CLYDE_OVERRIDE_CHAR, 07h
	mov BACKWARDS_CHECK_CLYDE, 0b
	mov BACKWARDS_CHECK_CLYDE_BACKUP, 0b
ret
load_defaults endp

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
help_handler endp

draw_main_menu proc
	call load_defaults
	MENU_START:
	call clear_screen
	mov CURRENT_SCENE, 0h

	displayStringAtPosition 4, 4, MAIN_MENU_STRING
	displayStringAtPosition 5, 4, PLAY_STRING
	displayStringAtPosition 6, 4, HELP_STRING
	displayStringAtPosition 8, 4, QUIT_STRING
	displayStringAtPosition 0, 54, LAST_SCORE_STRING
	setCursor 66, 0
	mov AX, PLAYER_SCORE
	call display_integer
	cmp DIFFICULTY_LEVEL, 2
	je hard
	cmp DIFFICULTY_LEVEL, 1
	je normal

	displayStringAtPosition 7, 4, DIFFICULTY_EASY_STRING
	jmp difficulties
	normal:
	displayStringAtPosition 7, 4, DIFFICULTY_NORMAL_STRING
	jmp difficulties
	hard:
	displayStringAtPosition 7, 4, DIFFICULTY_HARD_STRING
	difficulties:

	call play_sound
	WRONG_BUTTON:

	mov AH, 00h
	int 16h

	cmp AL, 'D'
	je DIFFICULTY_CHANGE
	cmp AL, 'd'
	je DIFFICULTY_CHANGE
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
	DIFFICULTY_CHANGE:
	inc DIFFICULTY_LEVEL
	and DIFFICULTY_LEVEL, 3
	jmp MENU_START
	PLAY:
		mov TOTAL_POINT, 0
		mov CURRENT_SCENE, 01h
			call clear_screen
			call draw_border
			call draw_box_array

			mov PLAYER_SCORE, 0
			mov PLAYER_LIVES, 3
			jmp draw_end
	HELP:
		call help_handler
		jmp draw_end
	QUIT:
		call clear_screen
		MOV AX, 4C00h
		int 21h

	draw_end:
	ret
draw_main_menu endp

ghost_collision proc
cmp PLAYER_LIVES, 0
je end_game_mid

	setCursor PACMAN_X, PACMAN_Y
	drawSymbol ' ', 0, 1

	setCursor PACMAN_PREV_X, PACMAN_PREV_Y
	drawSymbol ' ', 0, 1

	;pobranie symbolu ktory wczesniej byl na tym polu

	; sekcja skokow (wynika z ograniczonego zasiegu skoku)
	jmp pomin_skok
	end_game_mid:
	jmp end_game
	pomin_skok:

	setCursor BLINKY_X, BLINKY_Y
	drawSymbol ' ', 0, 1

	setCursor BLINKY_PREV_X, BLINKY_PREV_Y
	drawSymbol BLINKY_OVERRIDE_CHAR, 0Fh, 1

	setCursor PINKY_X, PINKY_Y
	drawSymbol ' ', 0, 1

	setCursor PINKY_PREV_X, PINKY_PREV_Y
	drawSymbol PINKY_OVERRIDE_CHAR, 0Fh, 1

	cmp DIFFICULTY_LEVEL, 1
	jl skipp
	setCursor INKY_X, INKY_Y
	drawSymbol ' ', 0, 1

	setCursor INKY_PREV_X, INKY_PREV_Y
	drawSymbol INKY_OVERRIDE_CHAR, 0Fh, 1
	skipp:
	cmp DIFFICULTY_LEVEL, 2
	jl skip_2
	setCursor CLYDE_X, CLYDE_Y
	drawSymbol ' ', 0, 1

	setCursor CLYDE_PREV_X, CLYDE_PREV_Y
	drawSymbol CLYDE_OVERRIDE_CHAR, 0Fh, 1

	skip_2:
	call load_defaults

	ret
end_game:
	call draw_main_menu
ret
ghost_collision endp

check_collision proc
	 ; ustawienie pozycji kursora na NOWĄ pozycję pacmana (juz przesunieta)
	setCursor PACMAN_X, PACMAN_Y

	 ; odczytanie znaku z pozycji na której wylądować ma pacman
	mov AH, 08h
	mov BH, 0
	int 10h

	cmp AL, GHOST_CHAR
	je ghost_detected

	cmp AL, POINT_CHAR
	je point_detected

	 ; sprawdzenie czy znak jest równy '#'
	cmp AL, BORDER_CHAR
	je collision_detected

	 ; jeżeli nie, to czyścimy rejestr AL
	xor AL, AL
	ret

	ghost_detected:
		dec PLAYER_LIVES
		call ghost_collision
	ret

    collision_detected:
         ; jeżeli tak, ustawiamy rejestr AL na 1
        mov AL, 1
    ret

	point_detected:
		 ; zwiększanie punktów gracza jeśli punkt
		dec TOTAL_POINT
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
    mov BL, PACMAN_X
    mov CL, PACMAN_Y
    mov PACMAN_PREV_X, BL
    mov PACMAN_PREV_Y, CL

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
        mov AL, PACMAN_SPEED
		sub PACMAN_Y, AL

        call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_y_up
    ret

    fix_pacman_y_up:
		mov AL, PACMAN_PREV_Y
        mov PACMAN_Y, AL
    ret
     ;---------------------------------
    MOVE_PACMAN_LEFT:
        mov LAST_KEYSTROKE, AL
        mov AL, PACMAN_SPEED
		sub PACMAN_X, AL

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_x_left
    ret

    fix_pacman_x_left:
		mov AL, PACMAN_PREV_X
        mov PACMAN_X, AL
    ret
     ;---------------------------------
    MOVE_PACMAN_DOWN:
        mov LAST_KEYSTROKE, AL
        mov AL, PACMAN_SPEED
        add PACMAN_Y, AL

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_y_down
    ret

    fix_pacman_y_down:
		mov AL, PACMAN_PREV_Y
        mov PACMAN_Y, AL
    ret
     ;---------------------------------
    MOVE_PACMAN_RIGHT:
        mov LAST_KEYSTROKE, AL
        mov AL, PACMAN_SPEED
        add PACMAN_X, AL

		call check_collision
		cmp AL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_pacman_x_right
    ret

    fix_pacman_x_right:
		mov AL, PACMAN_PREV_X
        mov PACMAN_X, AL
    ret
     ;---------------------------------

move_pacman endp

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
	setCursor 60, 0

	 ; wypisanie napisu 'SCORE'
	mov dx, offset SCORE_STRING
	mov ah, 9
	int 21h

	 ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany wynik (cyfra)
	setCursor 66,0

	 ; funkcja wyświetlająca wynik gracza
	mov AX, PLAYER_SCORE
	call display_integer

    ret
display_score endp

display_lives proc
     ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany napis
	setCursor 50, 0

	 ; wypisanie napisu 'LIVES'
	mov dx, offset LIVES_STRING
	mov ah, 9
	int 21h

	 ; ustawienie pozycji kursora, tam gdzie ma być wyświetlany wynik (cyfra)
	setCursor 56, 0

	 ; funkcja wyświetlająca wynik gracza
	mov AX, PLAYER_LIVES
	call display_integer

    ret
display_lives endp

check_collision_enemy MACRO GHOST_X, GHOST_Y
	LOCAL collision_detected_enemy
	LOCAL collision_detected_pacman
	LOCAL end_macro_n
	 ; ustawienie pozycji kursora na NOWĄ pozycję pacmana (juz przesunieta)
	setCursor GHOST_X, GHOST_Y

	 ; odczytanie znaku z pozycji na której wylądować ma pacman
	mov AH, 08h
	mov BH, 0
	int 10h

	cmp AL, PACMAN_CHAR
	je collision_detected_pacman

	 ; sprawdzenie czy znak jest równy '#'
	cmp AL, BORDER_CHAR
	je collision_detected_enemy

	 ; jeżeli nie, to czyścimy rejestr AL
	xor BL, BL
	jmp end_macro_n

	collision_detected_pacman:
	dec PLAYER_LIVES
	call ghost_collision
	jmp end_macro_n
    collision_detected_enemy:
         ; jeżeli tak, ustawiamy rejestr AL na 1
        mov BL, 1
	end_macro_n:
ENDM

move_ghost MACRO GHOST_X, GHOST_Y, GHOST_PREV_X, GHOST_PREV_Y, BACKWARDS_CHECK_GHOST, BACKWARDS_CHECK_GHOST_BACKUP
	LOCAL once_more
	LOCAL move_blinky_up
	LOCAL move_blinky_down
	LOCAL move_blinky_right
	LOCAL move_blinky_down2
	LOCAL move_blinky_right2
	LOCAL dont_move
	LOCAL fix_blinky_x_left
	LOCAL fix_blinky_x_right
	LOCAL fix_blinky_y_down
	LOCAL fix_blinky_y_up
	LOCAL move_blinky_left

     ; zapisywanie poprzedniej pozycji duszka, w celu wyczyszczenia
    mov BL, GHOST_X
    mov CL, GHOST_Y
    mov GHOST_PREV_X, BL
    mov GHOST_PREV_Y, CL


 ; losowy kierunek ruchu
	push dx

	once_more:
	push ax
	push cx
	mov AH, 2Ch
	int 21h

	pop cx
	pop ax

	xor DH, DH
    and DL, 00000011b ; maskowanie wartości, tak aby wynosiły od 0 do 3

	cmp DL, BACKWARDS_CHECK_GHOST
	je once_more

    ; warunki sprawdzające gdzie skoczyć

    cmp DL, 0
    je move_blinky_up

    cmp DL, 1
    je move_blinky_left

    cmp DL, 2
    je move_blinky_down2

    cmp DL, 3
    je move_blinky_right2

	 MOVE_BLINKY_UP:
		MOV DL, BACKWARDS_CHECK_GHOST
		MOV BACKWARDS_CHECK_GHOST_BACKUP, DL
	 	mov BACKWARDS_CHECK_GHOST, 2
		pop dx
        mov AL, 1
		sub GHOST_Y, AL

        check_collision_enemy GHOST_X, GHOST_Y
		cmp bl, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_blinky_y_up
    jmp dont_move

    fix_blinky_y_up:
		mov AL, GHOST_PREV_Y
        mov GHOST_Y, AL
		mov bl, BACKWARDS_CHECK_GHOST_BACKUP
		mov BACKWARDS_CHECK_GHOST, bl
		xor bx, bx
    jmp dont_move
	move_blinky_right2:
	jmp move_blinky_right
	move_blinky_down2:
	jmp move_blinky_down
     ;---------------------------------
    MOVE_BLINKY_LEFT:
		MOV DL, BACKWARDS_CHECK_GHOST
		MOV BACKWARDS_CHECK_GHOST_BACKUP, DL
		pop dx
		mov BACKWARDS_CHECK_GHOST, 3
        mov AX, 1
		sub GHOST_X, AL

        check_collision_enemy GHOST_X, GHOST_Y
		cmp BL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_blinky_x_left
		xor bx, bx
    jmp dont_move


    fix_blinky_x_left:
		mov bl, BACKWARDS_CHECK_GHOST_BACKUP
		mov BACKWARDS_CHECK_GHOST, bl
		xor bx, bx
		mov AL, GHOST_PREV_X
        mov GHOST_X, AL
    jmp dont_move

     ;---------------------------------
    MOVE_BLINKY_DOWN:
		MOV DL, BACKWARDS_CHECK_GHOST
		MOV BACKWARDS_CHECK_GHOST_BACKUP, DL
		mov BACKWARDS_CHECK_GHOST, 0
		pop dx
        mov AL, 1
        add GHOST_Y, AL

        check_collision_enemy GHOST_X, GHOST_Y
		cmp BL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_blinky_y_down
		xor bx, bx
    jmp dont_move

    fix_blinky_y_down:
		mov bl, BACKWARDS_CHECK_GHOST_BACKUP
		mov BACKWARDS_CHECK_GHOST, bl
		xor bx, bx
		mov AL, GHOST_PREV_Y
		mov GHOST_Y, AL
    jmp dont_move
     ;---------------------------------
    MOVE_BLINKY_RIGHT:
		MOV DL, BACKWARDS_CHECK_GHOST
		MOV BACKWARDS_CHECK_GHOST_BACKUP, DL
		mov BACKWARDS_CHECK_GHOST, 1
		pop dx
        mov AL, 1
        add GHOST_X, AL

        check_collision_enemy GHOST_X, GHOST_Y
		cmp BL, 1 ; sprawdzamy czy nastąpiła kolizja
        jz fix_blinky_x_right
		xor bx, bx
    jmp dont_move

    fix_blinky_x_right:
		mov bl, BACKWARDS_CHECK_GHOST_BACKUP
		mov BACKWARDS_CHECK_GHOST, bl
		xor bx, bx
		mov AL, GHOST_PREV_X
        mov GHOST_X, AL
dont_move:
ENDM

draw_enemy MACRO GHOST_X, GHOST_Y, GHOST_PREV_X, GHOST_PREV_Y, GHOST_OVERRIDE_CHAR, GHOST_OVERRIDE_COLOR, GHOST_COLOR
	local TWO_GHOSTS_MEETUP
	LOCAL skip_3
     ; ustawienie pozycji kursora
	setCursor GHOST_PREV_X, GHOST_PREV_Y
     ; rysowanie duszka
	drawSymbol GHOST_OVERRIDE_CHAR, GHOST_OVERRIDE_COLOR, 1

	 ; rysuj nowego duszka
     ; ustawienie pozycji kursora
	setCursor GHOST_X, GHOST_Y

		 ; zapisz symbol który jest na aktualnym polu
	mov AH, 08h
	int 10h
	cmp AL, GHOST_CHAR
	je two_ghosts_meetup

	mov GHOST_OVERRIDE_CHAR, AL
	mov AL, AH
	xor AH, AH
	mov GHOST_OVERRIDE_COLOR, AX
	jmp skip_3
	two_ghosts_meetup:
	mov bh, point_char
	mov GHOST_OVERRIDE_CHAR, bh
	MOV GHOST_OVERRIDE_COLOR, 0Fh
	skip_3:

     ; rysowanie duszka
	drawSymbol GHOST_CHAR, GHOST_COLOR, 1

ENDM

blinky_management proc
	draw_enemy BLINKY_X, BLINKY_Y, BLINKY_PREV_X, BLINKY_PREV_Y, BLINKY_OVERRIDE_CHAR, BLINKY_OVERRIDE_COLOR, BLINKY_COLOR
	move_ghost BLINKY_X, BLINKY_Y, BLINKY_PREV_X, BLINKY_PREV_Y, BACKWARDS_CHECK_BLINKY, BACKWARDS_CHECK_BLINKY_BACKUP

ret
blinky_management endp

pinky_management proc
	draw_enemy PINKY_X, PINKY_Y, PINKY_PREV_X, PINKY_PREV_Y, PINKY_OVERRIDE_CHAR, PINKY_OVERRIDE_COLOR, PINKY_COLOR
	move_ghost PINKY_X, PINKY_Y, PINKY_PREV_X, PINKY_PREV_Y, BACKWARDS_CHECK_PINKY, BACKWARDS_CHECK_PINKY_BACKUP
ret
pinky_management endp

inky_management proc
	draw_enemy INKY_X, INKY_Y, INKY_PREV_X, INKY_PREV_Y, INKY_OVERRIDE_CHAR, INKY_OVERRIDE_COLOR, INKY_COLOR
	move_ghost INKY_X, INKY_Y, INKY_PREV_X, INKY_PREV_Y, BACKWARDS_CHECK_INKY, BACKWARDS_CHECK_INKY_BACKUP
ret
inky_management endp

clyde_management proc
	draw_enemy CLYDE_X, CLYDE_Y, CLYDE_PREV_X, CLYDE_PREV_Y, CLYDE_OVERRIDE_CHAR, CLYDE_OVERRIDE_COLOR, CLYDE_COLOR
	move_ghost CLYDE_X, CLYDE_Y, CLYDE_PREV_X, CLYDE_PREV_Y, BACKWARDS_CHECK_CLYDE, BACKWARDS_CHECK_CLYDE_BACKUP
ret
clyde_management endp

draw_all_movables proc
	call display_lives
	call display_score

	call blinky_management
	call pinky_management

	cmp DIFFICULTY_LEVEL, 1
	jl skip
	call inky_management
	cmp DIFFICULTY_LEVEL, 2
	jl skip
	call clyde_management
	skip:
	call move_pacman
	call draw_pacman
ret
draw_all_movables endp

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

	call draw_all_movables

	cmp TOTAL_POINT, 0
	je POINT_RESET
	jmp CHECK_TIME 		; powtarzamy proces

	MAIN_MENU:
		call draw_main_menu
		jmp CHECK_TIME

	POINT_RESET:
		setCursor PACMAN_X, PACMAN_Y
		drawSymbol ' ', 0, 1
		setCursor BLINKY_X, BLINKY_Y
		drawSymbol ' ', 0, 1

		call load_defaults
		call place_points
		jmp CHECK_TIME

main endp
end main