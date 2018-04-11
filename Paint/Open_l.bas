SCREEN 12

WINDOW (0, 0)-(639, 479)
LINE (0, 0)-(639, 439), 0, B
INPUT ; "Nazwa pliku "; nazwaPliku$
nazwaPliku$ = LEFT$(nazwaPliku$, 8)

'odczytuje
OPEN nazwaPliku$ + ".gft" FOR INPUT AS #3
INPUT #3, RozmiarX, RozmiarY
miejsceX = 20
miejsceY = 40

szerokoscZapis = CINT((620 - miejsceX) / (RozmiarX + 1)) - 1
dlugoscZapis = CINT((460 - miejsceY) / (RozmiarY + 1)) - 1
koniecY = (dlugoscZapis + 1) * (RozmiarY + 1) + miejsceY
poczatekY = koniecY - RozmiarY * (dlugoscZapis + 1) - dlugoscZapis
koniecX = 11 + RozmiarX * (szerokoscZapis + 1)
IF koniecX + szerokoscZapis > 630 THEN
szerokoscZapis = szerokoscZapis - 1
END IF
IF poczatekY < 10 THEN
dlugoscZapis = dlugoscZapis - 1
END IF
'drogi raz
poczatekY = koniecY - RozmiarY * (dlugoscZapis + 1) - dlugoscZapis
koniecX = 11 + RozmiarX * (szerokoscZapis + 1)
IF koniecX + szerokoscZapis > 630 THEN
szerokoscZapis = szerokoscZapis - 1
END IF
IF poczatekY < 10 THEN
dlugoscZapis = dlugoscZapis - 1
END IF

IF szerokoscZapis < 0 THEN szerokoscZapis = 0
IF dlugoscZapis < 0 THEN dlugoscZapis = 0
koniecY = (dlugoscZapis + 1) * RozmiarY + miejsceY


x = miejsceX
y = koniecY

'ramki
LINE (miejsceX - 10, miejsceY - 1)-(miejsceX + RozmiarX * (szerokoscZapis + 1) + 10 + szerokoscZapis, miejsceY - 1), 8, BF
LINE (miejsceX - 10, miejsceY + RozmiarY * (dlugoscZapis + 1) + 1 + dlugoscZapis)-(miejsceX + RozmiarX * (szerokoscZapis + 1) + 10 + szerokoscZapis, miejsceY + RozmiarY * (dlugoscZapis + 1) + 1 + dlugoscZapis), 8, BF
LINE (miejsceX - 1, miejsceY - 10)-(miejsceX - 1, miejsceY + RozmiarY * (dlugoscZapis + 1) + 10 + dlugoscZapis), 8, BF
LINE (miejsceX + RozmiarX * (szerokoscZapis + 1) + 1 + szerokoscZapis, miejsceY - 10)-(miejsceX + RozmiarX * (szerokoscZapis + 1) + 1 + szerokoscZapis, miejsceY + RozmiarY * (dlugoscZapis + 1) + 10 + dlugoscZapis), 8, BF
FOR wiersz = 1 TO RozmiarY + 1
INPUT #3, col$
FOR num = 1 TO LEN(col$)
pixel$ = MID$(col$, num, 1)
IF ASC(pixel$) < 58 THEN col = (ASC(pixel$) - 48) ELSE col = ASC(pixel$) - 55
LINE (x, y)-(x + szerokoscZapis, y + dlugoscZapis), col, BF
x = x + szerokoscZapis + 1
NEXT num
x = miejsceX
y = y - dlugoscZapis - 1
NEXT wiersz
CLOSE #3


END

