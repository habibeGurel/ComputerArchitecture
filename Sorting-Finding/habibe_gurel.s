		AREA ORNEK,CODE,READONLY
		ENTRY
		EXPORT main
		
main	PROC
		LDR R3,=array
        LDR R2, =2 ; hangi islem yapilacak
        CMP R2, #1 ; R2nin degeri 2 mi diye compare ediliyor
        BEQ find ; eger islem 1e esitse find fonksiyonuna gidiliyor
        CMP R2, #2 ; R2nin degeri 2 mi diye compare ediliyor
        BEQ sort ; eger islem 2ye esitse sort fonksiyonuna gidiliyor
        B son
		
find	LDR R7,[R3,#0] ; length
		MOV R4,#4 ; index tutma
		MOV R0,#2 ; bulunacak degeri R0a atadim. ornegin 2
        
loop	LDR R1,[R3,R4] ;arrayin R4. elemani
		ADD R4,R4,#4 ;int 4 byte, bir yana kaydirmak icin 4 ekliyorum
		CMP R0,R1 ;bulmak istedigim degerle suanki degeri karsilastirma
        BEQ iffind ; bulduysam iffind fonksiyonuna gidiyorum
        SUBS R7,R7,#1 ;loopun donme sayisini belirliyor
        CMP R7,#1 ;ilk elemana geldi mi kontrolu
        BNE loop ; eger R7 1den farkliysa loop doner
        MOV R0, #0 ;bulunamadiysa R0 degerini 0 yapiyorum
        B son

iffind	MOV R0, #1 ;bulunduysa R0 degerini 1 yapiyorum.
		B son
		
sort	LDR R0,[R3,#0] ;size
		LDR R6,[R3,#4] ;max eleman
		MOV R8,#8 
		
sortLoop	LDR R7,[R3,R8] ; bu dongu diziyi gezer ve max elemani bulur.
			ADD R8,#4 ; sonraki elemana gecmek icin 4 artiriyorum.
			CMP R6,R7 ; R6 ve R7 degerlerini karsilastirir.
			BGT moveItem ; R6 R7den buyukse moveItem a dallanir.
			MOV R6,R7 ; buyuk degilse R7, R6ya atanir.
			
moveItem	SUBS R0,R0,#1 ; R0 1 azaldi.
			CMP R0,#2 ;kontrolde son elemana geldi mi
			BNE sortLoop
		
createArr	ADD R9,R6,#1 ;max elemanin bir fazlasini R9a atadim, yeni dizinin boyutu bu kadar olacak.
			MOV R5,R9 ;yeni dizinin boyutunu tutacak, R9un degerini R5e atadim.
			MOV R8,#0 ; yeni dizinin indexini tutacak.
			SUB SP,SP,R9,LSL #2 ; yeni dizi icin bellekte yer ayiriyor.
			MOV R10,SP
			
ArrLoop		MOV R1,#0 ; bu dongude yeni dizinin elemanlari sifirlanir.
			STR R1,[R10,R8] ; R10 adresindeki bellek bolgesine R8 indexli eleman olarak R1 ataniyor.
			ADD R8,#4 ; sonraki elemana gezmek icin 4 artti.
			SUBS R5,R5,#1 ; dongunun donme sayisini belirtir, 1 azaltiyorum.
			CMP R5,#0 ; R5 0 degeri ile karsilastiriliyor.
			BNE ArrLoop 
			MOV R8,#4 ; ilk index
			LDR R0,[R3,#0] ; size
			
IndexFill	LDR R5,[R3,R8] ; bu dongude indexler doldurulacak.
			MOV R7,#4
			MUL R5,R5,R7 ; hesaplanacak index hesabi
			LDR R1,[R10,R5] ; indexteki eleman
			ADD R1,R1,#1 ; elemani bir artir
			STR R1,[R10,R5] ; R1i R10 adresindeki bellek bolgesinin R5 indexli elemani olarak atar.
			ADD R8,#4 ; sonraki elemana gecmek icin 4 artti.
			SUBS R0,R0,#1 ; dizi boyutu
			CMP R0,#1 ; R0 1 mi karsilastirmasi
			BNE IndexFill
			MOV R0,#0 ; R0a 0 atamasi
			MOV R1,#4 ; R1e 4 atamasi
			MOV R5,R9 ;yeni dizi boyutu
			
Adding		LDR R2,[R10,R0] ; bu dongude elemanlar toplanacak
			LDR R8,[R10,R1]
			ADD R8,R2,R8 ; R2+R8 sonucu R8e yazilir
			STR R8,[R10,R1]
			ADD R1,#4
			ADD R0,#4
			SUBS R5,R5,#1
			CMP R5,#1
			BNE Adding
			LDR R0,[R3,#0] ;size
			
createArr2	MOV R5,R0 ;LENGTH
			SUB SP,SP,R5,LSL #2
			MOV R8,SP
			
output		MOV R1,#4
			MUL R1,R1,R0 ;index
			LDR R2,[R3,R1]
			MOV R5,#4
			MUL R5,R5,R2
			LDR R4,[R10,R5]
			SUBS R4,R4,#1
			MOV R5,#4
			MUL R5,R5,R4
			STR R2,[R8,R5]
			MOV R5,#4
			MUL R5,R5,R2
			STR R4,[R10,R5]
			SUBS R0,R0,#1
			CMP R0,#0
			BNE output
			MOV R0,R8
			
son	b son
	ENDP
			
array	dcd		8,4,2,2,8,3,3,1
		AREA    MyData,DATA,READWRITE

		align
            END
            END