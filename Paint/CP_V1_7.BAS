'IF Copyright$ = "Stach Stasiak 19 XII-2000" THEN Program is COOL
'ELSE
'Program is KICHA
'END IF
'wykorzystanie choc czesci programu do uzyrku poza wlasnego i kopiowanie
'bez pozwolenia SUROWO ZABRONIONE!
SCREEN 12
WIDTH , 60
WINDOW (0, 0)-(639, 479)
poczatekY = 10
szerokosc = 10
wysokosc = 10
OPEN "splash.gft" FOR INPUT AS #1
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
LOCATE 56, 10
PRINT "Copyright Stanislaw Stasiak 23-XII-2000 / TSoft (R) "
SLEEP 3
CLS

'ON ERROR GOTO defaultowe
OPEN "cPainter.ini" FOR INPUT AS #1
INPUT #1, szerokoscZapis, wysokoscZapis, smiec$
INPUT #1, RozmiarX, RozmiarY, smiec$
INPUT #1, wstepnyKolor, smiec$
INPUT #1, Undow, smiec$
smiec$ = "Kosz"
CLOSE #1
'ON ERROR GOTO errorLine
kwadrat = 1'jesli 1 then kafle s¥ kwadlatowe jesli nie to maxymalnie wielkie czyli nie koniecznie kwadratowe
GOTO poczatek
defaultowe:
'********************* Czesc parametrow konfigoracyjnych ********************
szerokoscZapis = 1 - 1'jesli 999 to przy zapisie obraz jest pokazany w automatycznych pixelach X else nic w podanych
wysokoscZapis = 1 - 1'jesli 999 to przy zapisie obraz jest pokazany w automatycznych pixelach Y else nic w podanych
wstepnyKolor = 0  'kolor tla
RozmiarX = 40 - 1: RozmiarY = 40 - 1  ' rozmiar obrazu (ile klockow)
Undow = 5000   'ile stopni cofania
' koniec parametrow

poczatek:
'************* Auto obliczanie pozostalych powiazanych parametrow ***************
IF RozmiarX >= 640 - 2 * poczatekX THEN RozmiarX = 640 - 2 * poczatekX
IF RozmiarY >= 365 THEN RozmiarY = 365
ktoryToRaz = 0
opisWiersz = 8: opisKolumna = 3
poczatekX = 15 'poczatek okna parametr X
koniecY = 405 'gdzie liczac od dolu ekranu jest koniec okna (poczatek jest dynamiczny)
kolRamkaKafelOld = 15 'kolor ramki aktywnego kafla
kolRamkaKafel = kolRamkaKafelOld
kolRamkaZmaz = 8
rysowac = 1 ' czy ciagle rysowac 0 = nie tylko po SPACJI 1 = zawsze jesli Rysownik w programie = on po tyldzie
maxymalneOknoX = 640 - poczatekX
maxymalneOknoY = 370 'maxymalne rozmiary X i wczesniej Y okna X=Y and szerokosc=wysokosc to rysownik=kwadrat
kratkaold = 2
kratka = kratkaold
SCREEN 12
WIDTH , 60
WINDOW (0, 0)-(639, 479)
LOCATE 4, 44
PRINT "Kolor : [1]<, [2]>; Odcien : [3]^";
LOCATE 58, opisKolumna
COLOR 9
PRINT "[n] Nowy...";
COLOR 10
PRINT "[s] Zapisz... ";
COLOR 11
PRINT "[o] Otw¢rz... ";
COLOR 12
PRINT "[<] Cofnij ";
COLOR 13
PRINT "[>] Powt¢rz ";
COLOR 14
PRINT "[r] Rozmiar ";
COLOR 15
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), 15, B
LINE (0, 0)-(639, 479), 8, B
szerokosc = CINT(maxymalneOknoX / (RozmiarX + 1)) - 1
wysokosc = CINT(maxymalneOknoY / (RozmiarY + 1)) - 1
IF szerokosc = 0 OR wysokosc = 0 THEN kratka = 1
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
'drogi raz
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
'trzeci raz
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
IF szerokosc < 0 THEN szerokosc = 0
IF wysokosc < 0 THEN wysokosc = 0
IF szerokosc = 0 OR wysokosc = 0 THEN kratka = 1
IF kwadrat = 1 AND szerokosc < wysokosc THEN wysokosc = szerokosc
IF kwadrat = 1 AND szerokosc > wysokosc THEN szerokosc = wysokosc
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
koniecY = koniecY - wysokosc
x = poczatekX
y = koniecY
IF new = 0 AND poczatek = 0 THEN
DIM undo(Undow, 2)
DIM redo(Undow, 2)
END IF
FOR iU = 0 TO Undow
undo(iU, 0) = poczatekX
undo(iU, 1) = koniecY
undo(iU, 2) = POINT(x, y)
redo(iU, 0) = poczatekX
redo(iU, 1) = koniecY
redo(iU, 2) = 0
NEXT iU
iU = 0

LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, koniecY + wysokosc + 1), wstepnyKolor, BF'tlo
LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, koniecY + wysokosc + 1), 8, B'tlo

'siatka
IF kratka = 2 THEN
FOR x = poczatekX + szerokosc + 1 TO koniecX + szerokosc STEP szerokosc + kratka
LINE (x, poczatekY)-(x, koniecY + wysokosc), 8
NEXT x
FOR y = poczatekY + wysokosc + 1 TO koniecY + wysokosc STEP wysokosc + kratka
LINE (poczatekX, y)-(koniecX + szerokosc, y), 8
NEXT y
END IF
SELECT CASE rysowac
CASE 0
LOCATE opisWiersz, opisKolumna + 30
PRINT "[~] Rysownik : OFF"
CASE 1
LOCATE opisWiersz, opisKolumna + 30
PRINT "[~] Rysownik : ON "
END SELECT
LOCATE opisWiersz, opisKolumna + 50
PRINT "Plik noName.gf*"
x = poczatekX
y = koniecY
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
LOCATE opisWiersz, opisKolumna
PRINT ; "Aktualna pozycja  0  0"
FOR xr = poczatekX - 1 TO 300 + poczatekX - 1 STEP 20
LINE (xr, 450)-(xr + 18, 465), (xr - poczatekX + 1) / 20, BF'prostokat kolorow
LINE (xr, 450)-(xr + 18, 465), 15, B
NEXT xr
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), kolor, BF 'wywyrzszony prostokat kolorow
LINE (xr, 450)-(xr + 18, 470), 15, B

glowna:
saveuj = 0
zmianaRozmiaru = 0
'kierunkowe przyciski
KEY(11) ON: KEY(12) ON: KEY(13) ON: KEY(14) ON
KEY 15, CHR$(&H0) + CHR$(&H47) 'goralewo
KEY 16, CHR$(&H0) + CHR$(&H49) 'goraprawo
KEY 17, CHR$(&H0) + CHR$(&H4F) 'dollewo
KEY 18, CHR$(&H0) + CHR$(&H51) 'dolprawo
KEY(15) ON: KEY(16) ON: KEY(17) ON: KEY(18) ON
KEY 19, CHR$(&H0) + CHR$(&H39): KEY(19) ON 'kropa
KEY 20, CHR$(&H0) + CHR$(&H33): KEY(20) ON  'undo
KEY 21, CHR$(&H0) + CHR$(&H1): KEY(21) ON  'esc
KEY 22, CHR$(&H0) + CHR$(&H29): KEY(22) ON  'on-off rysownik
KEY 23, CHR$(&H0) + CHR$(&H34): KEY(23) ON  'redo
KEY 24, CHR$(&H0) + CHR$(&H2): KEY(24) ON 'kolorDown
KEY 25, CHR$(&H0) + CHR$(&H3): KEY(25) ON 'kolorUp

ON KEY(24) GOSUB kolorDown
ON KEY(25) GOSUB kolorUp
ON KEY(11) GOSUB gora
ON KEY(12) GOSUB lewo
ON KEY(13) GOSUB prawo
ON KEY(14) GOSUB dol
ON KEY(15) GOSUB goralewo
ON KEY(16) GOSUB goraprawo
ON KEY(17) GOSUB dollewo
ON KEY(18) GOSUB dolprawo
ON KEY(19) GOSUB rysuj
ON KEY(20) GOSUB undo
ON KEY(21) GOSUB koniec
ON KEY(22) GOSUB czyrysuj
ON KEY(23) GOSUB redo
DO
SELECT CASE INKEY$
CASE CHR$(51) ' 3 zmienia odcien
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), 0, BF 'wymaz
LINE (xr, 450)-(xr + 18, 465), kolor, BF 'prostokat kolorow stary
LINE (xr, 450)-(xr + 18, 465), 15, B
IF kolor < 8 THEN kolor = kolor + 8 ELSE kolor = kolor - 8
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), kolor, BF
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), 15, B
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), kolor, BF 'prostokat kolorow
LINE (xr, 450)-(xr + 18, 470), 15, B
IF kolor <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
CASE CHR$(115) ' s saveuje
saveuj = 1
GOSUB saveuj
CASE CHR$(111) ' o openuje
GOSUB openuj
CASE CHR$(112) ' p podglad
podglad = 1
nazwaPliku$ = "temp"
GOTO saveuj
CASE CHR$(110) ' n new file
'tutaj mozna wpisac pytanie o rozmiary nowego rysunku
new = 1
GOSUB poczatek
CASE CHR$(114) ' r new size
KEY(21) OFF 'esc
KEY(20) OFF 'undo
KEY(23) OFF 'redo
KEY(24) OFF 'kolory
KEY(25) OFF 'kolory
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
INPUT "Wprowadz now¥ szerokosc X "; RozmiarX$
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
INPUT "Wprowadz now¥ wysokosc Y "; RozmiarY$
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
new = 1 'po to by nie dim'owal ponownie tablic undo i redo
saveuj = 1
zmianaRozmiaru = 1
nazwaPliku$ = "temp"
GOSUB saveuj
RozmiarXold = RozmiarX
RozmiarYold = RozmiarY
RozmiarX = VAL(RozmiarX$) - 1
RozmiarY = VAL(RozmiarY$) - 1
IF RozmiarX = -1 THEN RozmiarX = RozmiarXold
IF RozmiarY = -1 THEN RozmiarY = RozmiarYold
IF RozmiarX > RozmiarXold THEN RozmiarXinput = RozmiarXold
IF RozmiarY > RozmiarYold THEN RozmiarYinput = RozmiarYold
LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, koniecY + wysokosc + 1), wstepnyKolor, BF'tlo
nazwaPliku$ = "temp"
GOSUB openuj
GOTO glowna
CASE CHR$(52) ' 4 gumka tlana
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), 0, BF 'wymaz
LINE (xr, 450)-(xr + 18, 465), kolor, BF 'prostokat kolorow stary
LINE (xr, 450)-(xr + 18, 465), 15, B
kolor = wstepnyKolor
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), kolor, BF
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), 15, B
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), kolor, BF 'prostokat kolorow
LINE (xr, 450)-(xr + 18, 470), 15, B
END SELECT
LOOP
GOTO koniec

kolorDown:
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), 0, BF 'wymaz
LINE (xr, 450)-(xr + 18, 465), kolor, BF 'prostokat kolorow stary
LINE (xr, 450)-(xr + 18, 465), 15, B
IF kolor > 0 THEN kolor = kolor - 1 ELSE kolor = 15
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), kolor, BF
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), 15, B
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), kolor, BF 'prostokat kolorow
LINE (xr, 450)-(xr + 18, 470), 15, B
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
RETURN

kolorUp:
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), 0, BF 'wymaz
LINE (xr, 450)-(xr + 18, 465), kolor, BF 'prostokat kolorow stary
LINE (xr, 450)-(xr + 18, 465), 15, B
IF kolor < 15 THEN kolor = kolor + 1 ELSE kolor = 0
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), kolor, BF
LINE (poczatekX - 1, 445)-(318 + poczatekX - 1, 435), 15, B
xr = kolor * 20 + poczatekX - 1
LINE (xr, 450)-(xr + 18, 470), kolor, BF 'prostokat kolorow
LINE (xr, 450)-(xr + 18, 470), 15, B
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
RETURN

'**********************************  ruch  **********************************

gora:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF y < koniecY THEN y = y + wysokosc + kratka ELSE y = y
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

lewo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF x > poczatekX THEN x = x - szerokosc - kratka ELSE x = x
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

prawo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF x < koniecX THEN x = x + szerokosc + kratka ELSE x = x
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

dol:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF y > poczatekY THEN y = y - wysokosc - kratka ELSE y = y
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN


goralewo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF y < koniecY THEN y = y + wysokosc + kratka ELSE y = y
IF x > poczatekX THEN x = x - szerokosc - kratka ELSE x = x
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

goraprawo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF y < koniecY THEN y = y + wysokosc + kratka ELSE y = y
IF x < koniecX THEN x = x + szerokosc + kratka ELSE x = x
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

dollewo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF x > poczatekX THEN x = x - szerokosc - kratka ELSE x = x
IF y > poczatekY THEN y = y - wysokosc - kratka ELSE y = y
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

dolprawo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF y > poczatekY THEN y = y - wysokosc - kratka ELSE y = y
IF x < koniecX THEN x = x + szerokosc + kratka ELSE x = x
IF rysowac = 1 THEN
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
END IF
LOCATE opisWiersz, opisKolumna
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

rysuj:
IF iU = Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = 0
END IF
IF iU < Undow THEN
undo(iU, 0) = x
undo(iU, 1) = y
undo(iU, 2) = POINT(x, y)
iU = iU + 1
END IF
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
RETURN

undo:
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF iU > 0 THEN
iU = iU - 1
IF czyOstatnia = 0 THEN iOstatnia = iU 'jesli poraz pierwszy jest undo od skonczenia rysowania to zapamietane jest iU dzieki temu redo dziala tylko do ostatniego miejsca
czyOstatnia = 1
x = undo(iU, 0)
y = undo(iU, 1)
redo(iU, 0) = x
redo(iU, 1) = y
redo(iU, 2) = POINT(x, y)
LOCATE opisWiersz, opisKolumna
LINE (x, y)-(x + szerokosc, y + wysokosc), undo(iU, 2), BF
IF undo(iU, 2) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
ELSE
iU = Undow
x = undo(iU, 0)
y = undo(iU, 1)
redo(iU, 0) = x
redo(iU, 1) = y
redo(iU, 2) = POINT(x, y)
LOCATE opisWiersz, opisKolumna
LINE (x, y)-(x + szerokosc, y + wysokosc), undo(iU, 2), BF
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (undo(iU, 2) <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
END IF
RETURN

redo:
IF iU - 1 = iOstatnia THEN 'jesli to ostatnia rysowana pozycja przed undowaniem to nic nie robi i wraca
czyOstatnia = 0
RETURN
END IF
'wyroznia sie kratka zmaz starej
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaZmaz, B
IF iU = Undow THEN
x = redo(iU, 0)
y = redo(iU, 1)
kolor = redo(iU, 2)
iU = 0
END IF
IF iU < Undow THEN
x = redo(iU, 0)
y = redo(iU, 1)
kolor = redo(iU, 2)
iU = iU + 1
END IF
LOCATE opisWiersz, opisKolumna
LINE (x, y)-(x + szerokosc, y + wysokosc), kolor, BF
PRINT "Aktualna pozycja "; INT((x - poczatekX) / (szerokosc + kratka)); INT(RozmiarY - (y - poczatekY) / (wysokosc + kratka)); "   "
IF (kolor <> 15 AND rysowac = 1) OR POINT(x, y) <> 15 THEN kolRamkaKafel = kolRamkaKafelOld ELSE kolRamkaKafel = 12
'wyroznia sie kratka
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
RETURN

czyrysuj:
SELECT CASE ktoryToRaz
CASE 0
ktoryToRaz = 1
rysowac = 0
LOCATE opisWiersz, opisKolumna + 30
PRINT "[~] Rysownik : OFF"
CASE 1
ktoryToRaz = 0
rysowac = 1
LOCATE opisWiersz, opisKolumna + 30
PRINT "[~] Rysownik : ON "
END SELECT
RETURN

openuj:
koniecY = koniecY + wysokosc
KEY(21) OFF 'esc
KEY(20) OFF 'undo
KEY(23) OFF 'redo
KEY(24) OFF 'kolory
KEY(25) OFF 'kolory
IF zmianaRozmiaru <> 1 THEN 'jesli skok tu jest po zmianie rozmiaru to pomijam
LOCATE 58, 2
PRINT SPACE$(76)
LOCATE 58, opisKolumna
nazwaPlikuold$ = nazwaPliku$
INPUT ; "Otw¢rz plik ( bez rozszerzenia ) "; nazwaPliku$
nazwaPliku$ = LEFT$(nazwaPliku$, 8)
IF nazwaPliku$ = "" THEN nazwaPliku$ = nazwaPlikuold$
LOCATE opisWiersz, opisKolumna + 50
PRINT "Plik "; nazwaPliku$; ".gft        "
END IF
kratka = kratkaold 'jak 2 to kratka jak 1 to nie
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
PRINT "Otwieram plik, prosze czeka†..."
OPEN nazwaPliku$ + ".gft" FOR INPUT AS #3
IF zmianaRozmiaru = 1 THEN 'jesli zmiana rozmiaru to nie mozna starego
INPUT #3, RozmiarXinput, RozmiarYinput
IF RozmiarXinput > RozmiarX THEN RozmiarXinput = RozmiarX
IF RozmiarYinput > RozmiarY THEN RozmiarYinput = RozmiarY
ELSE
INPUT #3, RozmiarX, RozmiarY
RozmiarXinput = RozmiarX
RozmiarYinput = RozmiarY
END IF
LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, 405 + 1), 0, BF'clear tlo
szerokosc = CINT(maxymalneOknoX / (RozmiarX + 1)) - 1
wysokosc = CINT(maxymalneOknoY / (RozmiarY + 1)) - 1
IF szerokosc = 0 OR wysokosc = 0 THEN kratka = 1
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
'drogi raz
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
'trzeci raz
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
IF koniecX + szerokosc > 640 - poczatekX THEN
szerokosc = szerokosc - 1
END IF
IF poczatekY < 40 THEN
wysokosc = wysokosc - 1
END IF
IF szerokosc < 0 THEN szerokosc = 0
IF wysokosc < 0 THEN wysokosc = 0
IF szerokosc = 0 OR wysokosc = 0 THEN kratka = 1
IF kwadrat = 1 AND szerokosc < wysokosc THEN wysokosc = szerokosc
IF kwadrat = 1 AND szerokosc > wysokosc THEN szerokosc = wysokosc
poczatekY = koniecY - RozmiarY * (wysokosc + kratka) - wysokosc
koniecX = poczatekX + RozmiarX * (szerokosc + kratka)
koniecY = koniecY - wysokosc
LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, koniecY + wysokosc + 1), wstepnyKolor, BF'tlo
LINE (poczatekX - 1, poczatekY - 1)-(koniecX + szerokosc + 1, koniecY + wysokosc + 1), 8, B'tlo

'siatka
IF kratka = 2 THEN
FOR x = poczatekX + szerokosc + 1 TO koniecX + szerokosc STEP szerokosc + kratka
LINE (x, poczatekY)-(x, koniecY + wysokosc), 8
NEXT x
FOR y = poczatekY + wysokosc + 1 TO koniecY + wysokosc STEP wysokosc + kratka
LINE (poczatekX, y)-(koniecX + szerokosc, y), 8
NEXT y
END IF
x = poczatekX
y = koniecY
IF kratka = 2 THEN LINE (x - 1, y - 1)-(x + szerokosc + 1, y + wysokosc + 1), kolRamkaKafel, B
x = poczatekX

FOR wiersz = 1 TO RozmiarYinput + 1
INPUT #3, col$
FOR num = 1 TO RozmiarXinput + 1
pixel$ = MID$(col$, num, 1)
IF ASC(pixel$) < 58 THEN col = (ASC(pixel$) - 48) ELSE col = ASC(pixel$) - 55
LINE (x, y)-(x + szerokosc, y + wysokosc), col, BF
x = x + szerokosc + kratka
NEXT num
x = poczatekX
y = y - wysokosc - kratka
NEXT wiersz
CLOSE #3
x = poczatekX
y = koniecY
FOR iU = 0 TO Undow ' czyszczenie tablicy cofniec
undo(iU, 0) = poczatekX
undo(iU, 1) = koniecY
undo(iU, 2) = POINT(x, y)
redo(iU, 0) = poczatekX
redo(iU, 1) = koniecY
redo(iU, 2) = 0
NEXT iU
iU = 0
KEY(21) ON 'esc
KEY(20) ON 'undo
KEY(23) ON 'redo
KEY(24) ON 'kolory
KEY(25) ON 'kolory
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
PRINT "Odczytywanie zakonczone OK"
SLEEP 1
LOCATE 58, opisKolumna
COLOR 9
PRINT "[n] Nowy ";
COLOR 10
PRINT "[s] Zapisz... ";
COLOR 11
PRINT "[o] Otw¢rz... ";
COLOR 12
PRINT "[<] Cofnij ";
COLOR 13
PRINT "[>] Powt¢rz ";
COLOR 14
PRINT "[r] Rozmiar ";
COLOR 15
IF podglad = 1 THEN
GOTO poczatek
END IF
RETURN

koniec:
KEY(21) OFF 'esc
KEY(20) OFF 'undo
KEY(23) OFF 'redo
KEY(24) OFF 'kolory
KEY(25) OFF 'kolory
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
INPUT ; "Czy zapisac zmiany w rysunku [t/n] "; potwierdzenie$
potwierdzenie$ = LEFT$(potwierdzenie$, 1)
IF potwierdzenie$ = "t" THEN

saveuj:  'modul zapisu wykorzystywany przy zmianie rozmiaru i wyjsciu
KEY(21) OFF 'esc
KEY(20) OFF 'undo
KEY(23) OFF 'redo
KEY(24) OFF 'kolory
KEY(25) OFF 'kolory
IF zmianaRozmiaru <> 1 THEN 'jesli skok tu jest po zmianie rozmiaru to pomijam
LOCATE 58, 2
PRINT SPACE$(76)
LOCATE 58, opisKolumna
nazwaPlikuold$ = nazwaPliku$
INPUT ; "Zapisz jako ( bez rozszerzenia ) "; nazwaPliku$
nazwaPliku$ = LEFT$(nazwaPliku$, 8)
IF nazwaPliku$ = "" THEN nazwaPliku$ = nazwaPlikuold$
LOCATE opisWiersz, opisKolumna + 50
PRINT "Plik "; nazwaPliku$; ".gft        "
END IF 'koniec zmianaRozmiaru
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
PRINT "Zapisuj© do pliku, prosze czeka†..."
OPEN nazwaPliku$ + ".gft" FOR OUTPUT AS #1
WRITE #1, RozmiarX, RozmiarY
FOR ys = koniecY + wysokosc TO poczatekY STEP -(wysokosc + kratka)
col$ = ""
FOR xs = poczatekX TO koniecX + szerokosc STEP (szerokosc + kratka)
IF POINT(xs, ys) < 10 THEN col$ = col$ + CHR$(POINT(xs, ys) + 48) ELSE col$ = col$ + CHR$(POINT(xs, ys) + 55)
NEXT xs
WRITE #1, col$
NEXT ys
CLOSE #1
LOCATE 58, opisKolumna
PRINT SPACE$(79 - opisKolumna)
LOCATE 58, opisKolumna
PRINT "Zapisywanie zakonczone OK"
SLEEP 1
LOCATE 58, opisKolumna
COLOR 9
PRINT "[n] Nowy ";
COLOR 10
PRINT "[s] Zapisz... ";
COLOR 11
PRINT "[o] Otw¢rz... ";
COLOR 12
PRINT "[<] Cofnij ";
COLOR 13
PRINT "[>] Powt¢rz ";
COLOR 14
PRINT "[r] Rozmiar ";
COLOR 15
IF saveuj = 1 THEN ' ewentualny powrot gdy to tylko save bez wyjscia
KEY(21) ON 'esc
KEY(20) ON 'undo
KEY(23) ON 'redo
KEY(24) ON 'kolory
KEY(25) ON 'kolory
saveuj = 0
RETURN
END IF
CLS
WINDOW (0, 0)-(639, 479)
LINE (0, 0)-(639, 439), 0, B

'odczytuje
OPEN nazwaPliku$ + ".gft" FOR INPUT AS #3
INPUT #3, RozmiarX, RozmiarY
IF szerokoscZapis = 999 THEN szerokoscZapis = CINT((620) / (RozmiarX + 1))
IF wysokoscZapis = 999 THEN wysokoscZapis = CINT((460) / (RozmiarY + 1))
koniecX = INT(320 + (RozmiarX * (szerokoscZapis + 1)) / 2)
koniecY = INT(240 + (RozmiarY * (wysokoscZapis + 1)) / 2)
IF koniecX + szerokoscZapis > 629 THEN
szerokoscZapis = szerokoscZapis - 1
END IF
IF koniecY + wysokoscZapis > 469 THEN
wysokoscZapis = wysokoscZapis - 1
END IF
'drogi raz
koniecX = INT(320 + (RozmiarX * (szerokoscZapis + 1)) / 2)
koniecY = INT(240 + (RozmiarY * (wysokoscZapis + 1)) / 2)
IF koniecX + szerokoscZapis > 629 THEN
szerokoscZapis = szerokoscZapis - 1
END IF
IF koniecY + wysokoscZapis > 469 THEN
wysokoscZapis = wysokoscZapis - 1
END IF
'trzeci raz
koniecX = INT(320 + (RozmiarX * (szerokoscZapis + 1)) / 2)
koniecY = INT(240 + (RozmiarY * (wysokoscZapis + 1)) / 2)
IF koniecX + szerokoscZapis > 629 THEN
szerokoscZapis = szerokoscZapis - 1
END IF
IF koniecY + wysokoscZapis > 469 THEN
wysokoscZapis = wysokoscZapis - 1
END IF
IF szerokoscZapis < 0 THEN szerokoscZapis = 0
IF wysokoscZapis < 0 THEN wysokoscZapis = 0
IF kwadrat = 1 AND szerokoscZapis < wysokoscZapis THEN wysokoscZapis = szerokoscZapis
IF kwadrat = 1 AND szerokoscZapis > wysokoscZapis THEN szerokoscZapis = wysokoscZapis
miejsceX = INT(320 - ((RozmiarX) * (szerokoscZapis + 1)) / 2)
miejsceY = INT(240 - ((RozmiarY) * (wysokoscZapis + 1)) / 2)
x = miejsceX
y = koniecY

'ramki
LINE (miejsceX - 10, miejsceY - 1)-(miejsceX + (RozmiarX + 1) * (szerokoscZapis + 1) + 10, miejsceY - 1), 8, BF
LINE (miejsceX - 10, miejsceY + RozmiarY * (wysokoscZapis + 1) + 1 + wysokoscZapis)-(miejsceX + (RozmiarX + 1) * (szerokoscZapis + 1) + 10, miejsceY + (RozmiarY + 1) * (wysokoscZapis + 1)), 8, BF
LINE (miejsceX - 1, miejsceY - 10)-(miejsceX - 1, miejsceY + (RozmiarY + 1) * (wysokoscZapis + 1) + 10), 8, BF
LINE (miejsceX + (RozmiarX + 1) * (szerokoscZapis + 1), miejsceY - 10)-(miejsceX + (RozmiarX + 1) * (szerokoscZapis + 1), miejsceY + RozmiarY * (wysokoscZapis + 1) + 10 + wysokoscZapis), 8, BF
FOR wiersz = 1 TO RozmiarY + 1
INPUT #3, col$
IF LEN(col$) < RozmiarX + 1 THEN col$ = col$ + SPACE$(RozmiarX + 1 - LEN(col$))
FOR num = 1 TO RozmiarX + 1
pixel$ = MID$(col$, num, 1)
IF ASC(pixel$) < 58 THEN col = (ASC(pixel$) - 48) ELSE col = ASC(pixel$) - 55
LINE (x, y)-(x + szerokoscZapis, y + wysokoscZapis), col, BF
x = x + szerokoscZapis + 1
NEXT num
x = miejsceX
y = y - wysokoscZapis - 1
NEXT wiersz
CLOSE #3
IF podglad = 1 THEN
GOTO openuj
END IF
END

ELSE  'inny wariant wjscia lub nie
IF potwierdzenie$ = "n" THEN
END ' koniec programu
ELSE
KEY(21) ON 'esc
KEY(20) ON 'undo
KEY(23) ON 'redo
KEY(24) ON 'kolory
KEY(25) ON 'kolory
LOCATE 58, opisKolumna
COLOR 9
PRINT "[n] Nowy ";
COLOR 10
PRINT "[s] Zapisz... ";
COLOR 11
PRINT "[o] Otw¢rz... ";
COLOR 12
PRINT "[<] Cofnij ";
COLOR 13
PRINT "[>] Powt¢rz ";
COLOR 14
PRINT "[r] Rozmiar ";
COLOR 15
RETURN
END IF
END IF

errorLine:
LOCATE 58, opisKolumna
PRINT "Co˜ nie tak?"
END 'nie dokonczone i w og¢le nie dziala wi©c koniec jesli poprawi© to b©dzie rozpoznawal blod
errorLine = 1
SELECT CASE ERR
CASE 53 'file not found
LOCATE opisWiersz, opisKolumna + 50
PRINT "Nie znalazlem pliku "; nazwaPliku$
GOTO openuj
CASE 64 'bad file name
IF saveuj = 1 THEN
LOCATE opisWiersz, opisKolumna + 50
PRINT "Zˆa nazwa pliku "; nazwaPliku$
GOTO saveuj
END IF
IF saveuj = 0 AND potwierdzenie$ = "t" THEN
LOCATE opisWiersz, opisKolumna + 50
PRINT "Zˆa nazwa pliku "; nazwaPliku$
GOTO saveuj
END IF
LOCATE opisWiersz, opisKolumna + 50
PRINT "Zˆa nazwa pliku "; nazwaPliku$
GOTO openuj
CASE 9
END SELECT
END

