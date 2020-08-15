'IF Copyright$ = "Stach Stasiak 19 XII-2000" THEN Program is COOL
'ELSE
'Program is KICHA
'END IF
'wykorzystanie choc czesci programu do uzyrku poza wlasnego i kopiowanie
'bez pozwolenia SUROWO ZABRONIONE!
SCREEN 12
WIDTH , 60
WINDOW (0, 0)-(639, 479)
poczatekY = 0
szerokosc = 2 - 1
wysokosc = 2 - 1
OPEN "plus!.gft" FOR INPUT AS #1
INPUT #1, RozmiarX, RozmiarY
poczatekX = INT((640 - RozmiarX * (szerokosc + 1)) / 2)
koniecY = INT(240 + (RozmiarY * (wysokosc + 1)) / 2)
x = poczatekX
y = koniecY

FOR wiersz = 1 TO RozmiarY + 1
INPUT #1, col$
FOR num = 1 TO LEN(col$)
pixel$ = MID$(col$, num, 1)
IF ASC(pixel$) < 58 THEN col = (ASC(pixel$) - 48) ELSE col = ASC(pixel$) - 55
LINE (x, y)-(x + szerokosc, y + wysokosc), col, BF
x = x + szerokosc + 1
NEXT num
x = poczatekX
y = y - wysokosc - 1
NEXT wiersz
CLOSE #1
DO
LOOP UNTIL INKEY$ = CHR$(27)
END

