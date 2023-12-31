.model small
.stack 100h
.data
	WINDOW_WIDTH DW 80d ; 80 znaków / 80 kolumn
	WINDOW_HEIGHT DW 25d ; 25 znaków / 25 rzędów
	
	GAME_WINDOW_START_X DB 4 ; początek okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_END_X DB 76  ; koniec okna właściwego gry (z pominięciem ramek) - nr kolumny
	GAME_WINDOW_START_Y DB 2 ; początek okna właściwego gry (z pominięciem ramek) - nr rzędu
	GAME_WINDOW_END_Y DB 22  ; koniec okna właściwego gry (z pominięciem ramek) - nr rzędu
	
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
	CURRENT_SCENE DB 0 ; 1 - GRA, 0 - MAIN MENU
.code

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
	
	;nowy delay - chyba dziala
	mov cx,0h
	mov dx,0F000h
	mov ah,86h
	int 15h
	
	call display_lives
	call display_score
	call move_pacman
	call draw_pacman
	
	 ; stary chyba nie dziala
	 ; jakis delay - powoduje jakies random bledy ktorych nie umiem naprawic, ale niby dziala
	;mov AL, 0
	;mov CX, 1
	;mov AH, 86H
	;int 15H
	
	jmp CHECK_TIME 		; powtarzamy proces
	
	MAIN_MENU:
		call draw_main_menu
		jmp CHECK_TIME
	
	;mov AX, 4C00h 		; zakończenie programu
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

	 ; rysowanie znaku '#'
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
	
	 ; rysowanie znaku '#'
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
	
	 ; rysowanie znaku '#'
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
	
     ; rysowanie znaku '#'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 4	; liczba powtorzen
    int 10h		; przerwanie
	
	 ; right border
    mov AH, 02h  ; tryb ustawiania kursora
    mov BH, 0    ; numer strony
    mov DH, BL	 ; rzad
    mov DL, 76	 ; kolumna
    int 10h		 ; przerwanie

     ; rysowanie znaku '#'
    mov AH, 0Ah ; tryb rysowania znaku
    mov AL, BORDER_CHAR ; symbol ktory ma zostac wyswietlony
    mov BH, 0   ; numer strony
    mov CX, 4	; liczba powtorzen
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


draw_main_menu proc
	call clear_screen
	
	mov AH, 02h
	mov BH, 00h
	mov DH, 4
	mov DL, 4
	int 10h
	
	mov ah, 09h
	lea DX, MAIN_MENU_STRING
	int 21h

	mov AH, 02h
	mov BH, 00H
	mov DH, 5
	mov DL, 5
	int 10h
	
	mov ah, 09h
	lea DX, PLAY_STRING
	int 21h
	
	mov AH, 02h
	mov BH, 00H
	mov DH, 6
	mov DL, 5
	int 10h
	
	mov ah, 09h
	lea DX, HELP_STRING
	int 21h
	
	call play_sound
	WRONG_BUTTON:
	
	mov AH, 00h
	int 16h
	
	cmp AL, 'P'
	je PLAY
	cmp AL, 'p'
	je PLAY
	
	jmp WRONG_BUTTON
	
	PLAY:
		mov CURRENT_SCENE, 01h
			call clear_screen
			call draw_border
			call draw_box
			call place_points
	
	ret
draw_main_menu endp
;generate_ghosts proc ; kit wie jak to zrobicXD

play_music_main_menu proc


	ret
play_music_main_menu endp

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
	out 61h,al
	ret
ret
play_sound endp


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

end main