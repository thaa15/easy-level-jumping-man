.model small
.stack 64h
.data 
    ; deklarasi awal text dan dekorasi game
    nama  db "Proyek Tengah Semester - Kelompok 10"
    guide db "Use The UP Arrow to Jump"
    judul db "JUMPING MAN"
    start db "Press Any Key to Start"
    try_again db "Press space to continue"
    escape db "Press esc to exit"
    line1 db "----------------------------------------"
    line2 db "*. *. *. *. *. *. *. *. *. *. *. *. *. *"
    player_score_label db "SCORE:"

    ; deklarasi benda bergerak (objek, man)
	player db "I"
	obj db "#"
    clean db " "

    ; deklarasi nilai score
	player_score_units db 0h
	player_score_tens db 0h
	player_score_hundreds db 0h

    ; deklarasi kondisi vertikal man
	man_up db ?

    ; deklarasi kondisi objek
	temp db 30
	obj_y db 1

    ; deklarasi variable control
    EXIT db 0h ; kontrol keluar game
	START_AGAIN db ? ; kontrol ulang game
    END_GAME_KEY equ 01h ; kontrol tombol esc
    UP equ 48h ; kontrol tombol up
	DOWN db 0 ; kontrol kondisi vertikal man

.code
    

MainMenu proc near ; tampilan main menu / awal
    LEA BP, nama ; print string nama
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 36
    MOV DL, 0
    MOV DH, 0
    INT 10H
    
    LEA BP, guide ; print string guide
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 24
    MOV DL, 0
    MOV DH, 1
    INT 10H
    
    LEA BP, judul ; print string judul
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 11
    MOV DL, 14
    MOV DH, 10
    INT 10H
    
    LEA BP, start ; print string start
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 22
    MOV DL, 9
    MOV DH, 12
    INT 10H 
    
    LEA BP, player ; print string player
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, 2
    MOV DH, 22
    INT 10H
    
    LEA BP, line1 ; print string line1
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 40
    MOV DL, 0
    MOV DH, 23
    INT 10H
    mov dl, 0  
    mov dh, 23   
    mov bh, 0
    mov ah, 02h 
    int 10h 
    
    LEA BP, line2 ; print string line2
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 40
    MOV DL, 0
    MOV DH, 24
    INT 10H
    mov dl, 0  
    mov dh, 24   
    mov bh, 0
    mov ah, 02h 
    int 10h
    
    MOV AH, 01H
    INT 21H
    ret
MainMenu ENDP

TRY_AGAINS proc ; tampilan try again
    
    call PRINT_PLAYER_SCORE
    
    LEA BP, try_again ; print string try again
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 23
    MOV DL, 8
    MOV DH, 12
    INT 10H
    
    LEA BP, escape ; print string escape
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 17
    MOV DL, 10
    MOV DH, 14
    INT 10H
    
    ; input try again
    MOV AH,0
    INT 16h

    mov [START_AGAIN],AL
    ret
TRY_AGAINS ENDP

StartGame proc near ; tampilan awal game berjalan
    MOV AH, 00H
    MOV AL, 13H
    INT 10H
    
    LEA BP, nama ; print string nama
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 36
    MOV DL, 0
    MOV DH, 0
    INT 10H
    
    LEA BP, guide ; print string guide
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 24
    MOV DL, 0
    MOV DH, 1
    INT 10H
    
    LEA BP, player ; print string player
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, 2
    MOV DH, 22
    INT 10H
    
    LEA BP, line1 ; print string line1
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 40
    MOV DL, 0
    MOV DH, 23
    INT 10H
    
    LEA BP, line2 ; print string line2
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 40
    MOV DL, 0
    MOV DH, 24
    INT 10H
    
    ret
StartGame ENDP

PRINT_PLAYER_SCORE proc near ; menampilkan skor
    lea BP,player_score_label
    mov ah, 13h
    mov bh, 0h
    mov bl, 0fh
    mov al, 00h
    mov cx, 5
    mov dl, 0
    mov dh, 3
    int 10h
    PUSH AX
	PUSH BX
	mov dl, 5  
    mov dh, 3   
    mov bh, 0
    mov ah, 02h 
    int 10h
    
	mov al, ':'
    mov bl, 0Fh
    mov bh, 0
    mov ah, 0Eh
    int 10h
    
    mov dl, 6  
    mov dh, 3   
    mov bh, 0
    mov ah, 02h 
    int 10h
    
    mov al, [player_score_hundreds] ;print digit ratusan
    mov bl, 0Fh
    mov bh, 0
    mov ah, 0eh
    add ax, '0'
    int 10h
    
    mov al, [player_score_tens]     ;print digit puluhan
    mov bl, 0Fh                     
    mov bh, 0
    mov ah, 0eh
    add ax, '0'
    int 10h
    
	mov al, [player_score_units]    ;print digit satuan
    mov bl, 0Fh
    mov bh, 0
    mov ah, 0eh
    add ax, '0'
    int 10h
	POP BX
	POP AX
	ret
PRINT_PLAYER_SCORE endp


UP_KEY proc near ; input untuk lompat
	; check for a key storke
	push ax
	push bx
	mov ax, 0h
	mov ah,01h
	int 16h	
	
	; Gak mencet apa apa
	jz KEY_STILL
	; Mencet ESC
	cmp ah,END_GAME_KEY
	jz GAME_ENDED ; game selesai
	
	; mencet samting
	mov bh,ah
	mov byte ptr [man_up], bh ; mengubah kondisi man ke atas
	call MAN_PRINT
	mov ah,0Ch
	int 21h	
	jmp KEY_STILL
	
    ; keluar game	
    GAME_ENDED:
    	mov byte ptr [EXIT], 1h
    	; clear key buffer
    		
    KEY_STILL:
    	pop bx
    	pop ax
    	ret
UP_KEY endp

MAN_PRINT proc ;	
	UP_GAN:
		LEA BP, player ; print string head
        MOV AH, 13H
        MOV BH, 0H
        MOV BL, 0FH
        MOV AL, 00H
        MOV CX, 1
        MOV DL, 2
        MOV DH, 19
        INT 10H
        
        LEA BP, clean ; clean string head
        MOV AH, 13H
        MOV BH, 0H
        MOV BL, 0FH
        MOV AL, 00H
        MOV CX, 1
        MOV DL, 2
        MOV DH, 21
        INT 10H
		
    END_MAN_PRINT: 	
    	ret
MAN_PRINT endp
    
MOVE_MAN_GROUND proc ; turunkan man
    
    LEA BP, clean ; clean string head
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, 2
    MOV DH, 19
    INT 10H
    
    LEA BP, player ; print string legs
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, 2
    MOV DH, 21
    INT 10H
    
    mov byte ptr[man_up], 0 ; membalikan kondisi man ke bawah        
    mov byte ptr[DOWN], 0 ; mengulang delay waktu di udara
    ret                      
MOVE_MAN_GROUND endp

Up_Score proc ; fungsi penambah skor
    cmp player_score_units, 9h ; menentukan apakah digit puluhan akan bertambah
    jne unit_inc    ;jika jumlah digit skor TIDAK akan berubah, program masuk ke penambah skor biasa
    
    Change_units: ; jika digit puluhan akan berganti
        mov byte ptr [player_score_units],0h ;nol kan satuan
        cmp player_score_tens, 9h            ;jika skor akan menjadi orde ratusan..
        je Change_tens                       ;..loncat lansunh ke tambah puluhan
        inc byte ptr [player_score_tens]     ;jika skor belum akan menjadi orde ratusan, incremen digit puluhan 
        jmp end_inc
    Change_tens:
        mov byte ptr [player_score_units],0h ;nol kan satuan
        mov byte ptr [player_score_tens],0h  ;nol kan puluhan
        cmp player_score_hundreds, 9h        ;jika skor akan menjadi orde ribuan..
        je Change_hundreds                   ;..jadikan skor 999
        inc byte ptr [player_score_hundreds] ;jika tidak tambah digit ratusan
        jmp end_inc
    Change_hundreds:
        mov byte ptr [player_score_units],9h
        mov byte ptr [player_score_tens],9h
        mov byte ptr [player_score_hundreds],9h
        jmp end_inc   
    unit_inc:
        inc byte ptr [player_score_units]
    end_inc:
       ret
Up_Score endp

moving_obj proc near ; memindahkan objek 
    update_obj: ; mengubah lokasi objek
    mov al, temp            ; menentukan lokasi awal objek
    dec al                  ; mengubah lokasi objek 1 char
    mov byte ptr[temp], al
    cmp al, 02h             ; mengecek objek berarda pada lokasi x yang sama dengan man
    je cek_obj              ; jika sama maka akan di cek lebih lanjut

    cmp al, 00h             ; mengecek posisi objek di ujung kiri
    jne print_obj
    mov byte ptr[temp], 30h ; mengubah posisi objek ke posisi awal
    
    print_obj: ; menampilkan objek
    LEA BP, obj
    MOV AH, 13H
    MOV BH, 01H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, byte ptr[temp]
    MOV DH, 20
    INT 10H
    
    clear_obj: ; menghapus objek lama
    LEA BP, clean
    MOV AH, 13H
    MOV BH, 0H
    MOV BL, 0FH
    MOV AL, 00H
    MOV CX, 1
    MOV DL, byte ptr[temp]
    add DL, 1
    MOV DH, 20
    INT 10H
    jmp end_obj
    
    cek_obj: ; mengecek lokasi vertikal objek terhadap man
    cmp man_up, UP
    je end_obj ;jika lokasi berbeda maka game berlanjut
    ; perlakuan jika objek mengenai man
    mov byte ptr [EXIT], 1h

    end_obj:   
    ret
moving_obj endp

delay proc near
    mov cx, 01h
    mov dx, 5000h
    mov ah, 86h
    int 15h
    ret    
delay endp 
    
.startup

setup:
    MOV AH, 00H  ; Set Video Mode 
    MOV AL, 13H
    INT 10H
    

MAIN:
	MOV AX, @DATA
    MOV ES, AX

    ; deklarasi variabel awal	
	mov BYTE PTR [player_score_units],0h
	mov BYTE PTR [player_score_tens],0h
	mov BYTE PTR [player_score_hundreds],0h
	mov BYTE PTR [EXIT],0h
	mov BYTE PTR [START_AGAIN],0h
	
	CALL MainMenu ; menampilkan menu utama
	CALL StartGame ; menampilkan kondisi awal game
	MAIN_LOOP: ;bagian kendali player dan gameplay
	    call moving_obj ; fungsi penggerak obstacle	
		call UP_KEY     ; fungsi pengecek tombol up
		call Up_Score   ; fungsi penambah skor
		call PRINT_PLAYER_SCORE ;fungsi print skor
		inc DOWN        ; counter delay di udara jika melompat
		cmp DOWN, 20    ; lama waktu di udara
		jne SECOND_LOOP ; kalau delay belum terpenuhi maka program loncat agar player tidak turun
		call MOVE_MAN_GROUND ; jika delay sudah dipenuhi maka jne tidak dipenuhi sehingga program memanggil fungsi untuk menurunkan player ke tanah
		
	SECOND_LOOP:
		call delay
		cmp [EXIT],1h   ; mengecek apakah tombol exit ditekan atau tidak  
		jnz MAIN_LOOP   ; jika tidak exit program akan loncat ke main loop
    
    TRY_LOOP: ; loop untuk mengecek input try again
        mov [EXIT], 0h ; mengembalikan exit ke kondisi awal
        call TRY_AGAINS 
	    cmp [START_AGAIN],20h ; mengecek apakah tombol space dipencet
	    je setup ; ulang permainan
        cmp [START_AGAIN], 1bh ; mengecek apakah tombol esc dipencet
        je DONE ; keluar program
        jne TRY_LOOP ; ulang input try again

    DONE:    
	mov ah,4ch
	int 21h

.exit
END