//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#include <Controls.hpp>
#pragma hdrstop
#include "Unit2.h"
#include "Unit1.h"
#include "./../../FORM_TEMPLATES/About_frm.h"
#include <dir.h>
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TForm1 *Form1;
String NazwaPlikuSave = "";
String NazwaPliku = "";
unsigned __int32 Dlugo = 0;
bool First = false; // od�wierza�?
bool Original = false;
bool Robie = false;
bool Nad = false; // w orginalnych rozmiarach?
unsigned __int32 XMax = 250;
unsigned __int32 YMax = 200;
Graphics::TBitmap* Bm = new Graphics::TBitmap;
char* Linia = new char[1024];

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Exit1Click(TObject *Sender)
{
Close();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Open1Click(TObject *Sender)
{
if (Robie==true) return;
Robie=true;

try
{
if (!OpenDialog1->Execute())
    {
     Robie = false;
     return;
    }
First = true;
Dlugo = OpenDialog1->FileName.Length();
NazwaPliku = OpenDialog1->FileName;

if (UpperCase(NazwaPliku.SubString(OpenDialog1->FileName.Length()-2,3))!="GFT")
   {
    NazwaPlikuSave = OpenDialog1->FileName;
    SaveDialog1->FileName = OpenDialog1->FileName;
    Image1->Picture->LoadFromFile(NazwaPliku);

    Image1->Left = 1;
    XMax = Image1->Picture->Width;
    Image1->Width = Image1->Picture->Width;
    Form1->ClientWidth = XMax+2;
    Image1->Top = 1;
    YMax = Image1->Picture->Height;
    Image1->Height = Image1->Picture->Height;
    Form1->ClientHeight = YMax + 22;

    ProgressBar1->Width = Form1->ClientWidth - 8;
   }
else
   {
    NazwaPlikuSave = OpenDialog1->FileName;
    SaveDialog1->FileName = OpenDialog1->FileName;
    ifstream plik2; 								// odczyt formatu cpalonga
    // Open file
    plik2.open(OpenDialog1->FileName.c_str());
    // read Line
    strcpy(Linia, "XXXXXXXXXXX");
    plik2.getline(Linia,11);
    String XMaxS = "XXXXX";
    String YMaxS = "XXXXX";
    __int32 cX = 0, cY = 0;
    for (__int32 i = 0, SecondOrFirst = 0; i <= 8; i++)
        {
         if (Linia[i]!='X')
            {
             if (Linia[i]==',')
                {
                 SecondOrFirst = 1;
                }
             else
                {
                 if (SecondOrFirst==0)
                    {
                     cX++; XMaxS[cX] = Linia[i];
                    }
                 else
                    {
                     cY++; YMaxS[cY] = Linia[i];
                    }
                }
            }
        }
//....................................................
     XMaxS.SetLength(cX);
     XMax = XMaxS.ToInt();
     Bm->Width = XMax + 1;
     YMaxS.SetLength(cY);
     YMax = YMaxS.ToInt();
     Bm->Height = YMax + 1;
//....................................................
     for (unsigned __int32 Y = 0; Y <= YMax; Y++)
         {
          plik2.getline(Linia,1024);

          for (unsigned __int32 X = 0; X <= XMax; X++, Application->ProcessMessages())
              {
               unsigned char Pixel = Linia[X];
               unsigned __int32 Kolor = 0;
               //
               if (Pixel=='0') Kolor = RGB(0,0,0);
               if (Pixel=='1') Kolor = RGB(0,0,128);
               if (Pixel=='2') Kolor = RGB(0,128,0);
               if (Pixel=='3') Kolor = RGB(0,128,128);
               if (Pixel=='4') Kolor = RGB(128,0,0);
               if (Pixel=='5') Kolor = RGB(128,0,128);
               if (Pixel=='6') Kolor = RGB(128,128,0);
               if (Pixel=='7') Kolor = RGB(192,192,192);
               if (Pixel=='8') Kolor = RGB(128,128,128);
               if (Pixel=='9') Kolor = RGB(0,0,255);
               if (Pixel=='A') Kolor = RGB(0,255,0);
               if (Pixel=='B') Kolor = RGB(0,255,255);
               if (Pixel=='C') Kolor = RGB(255,0,0);
               if (Pixel=='D') Kolor = RGB(255,0,255);
               if (Pixel=='E') Kolor = RGB(255,255,0);
               if (Pixel=='F') Kolor = RGB(255,255,255);
               //
               Bm->Canvas->Pixels[X][Y] = (TColor)Kolor;
              }
          Form1->ProgressBar1->Position = __int32(Form1->ProgressBar1->Max * Y/YMax);
         }
    Image1->Left = 1;
    Image1->Width = ++XMax;
    Image1->Top = 1;
    Image1->Height = ++YMax;
    Form1->ProgressBar1->Position=0;
    if (XMax>200) Form1->ClientWidth = XMax + 2;
    if (YMax>300) Form1->ClientHeight = YMax + Panel1->Height;

    plik2.close();

    Bm->SaveToFile(NazwaPlikuSave+".bmp");
    Image1->Picture->LoadFromFile(NazwaPlikuSave+".bmp");
    remove(AnsiString(NazwaPlikuSave+".bmp").c_str());
   }
}
catch (...) { First = false; ShowMessage("Unknown ERROR"); }

Form1->Caption= "QBPaint Converter "+ ExtractFileName(NazwaPliku)+
                " "+(AnsiString)Image1->Picture->Width + " X " + (AnsiString)Image1->Picture->Height + " | "+
                (AnsiString)Image1->Width + " X " +(AnsiString)Image1->Height;
First = false;
Robie = false;
FormResize(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Save1Click(TObject *Sender)
{
try {

if (Robie==true) return;
Robie=true;

if (Original==false)
   {
    NazwaPlikuSave.Delete(Dlugo-2,3);
    NazwaPlikuSave.Insert("GFT",Dlugo-2);
   }
if (NazwaPlikuSave=="*.GFT")
   {
    SaveAs1Click(Sender);
   }
if ((NazwaPlikuSave.SubString(Dlugo-2,3)).UpperCase()=="BMP") Image1->Picture->SaveToFile(NazwaPlikuSave);
if ((NazwaPlikuSave.SubString(Dlugo-2,3)).UpperCase()=="GFT")
   {
    ofstream plik;
    plik.open(NazwaPlikuSave.c_str());

    XMax = Image1->Width;
    YMax = Image1->Height;

    plik << XMax-1 << ',' << YMax-1 << endl; // zapis rozmiar�w

    TRect rect = Rect(Image1->Left,Image1->Top,Image1->Left+Image1->Width,Image1->Top+Image1->Height);
    Form1->Canvas->StretchDraw(rect,Image1->Picture->Graphic);
    ProgressBar1->Width = Form1->ClientWidth-8;

    for (unsigned __int32 Y = 0; Y < YMax; Y++)
        {
        for (unsigned __int32 X = 0; X < XMax; X++, Application->ProcessMessages())
            {
             unsigned char Pixel = 'X';
             unsigned __int32 Kolor = Form1->Canvas->Pixels[X+Image1->Left][Y+Image1->Top];
             /*if (Kolor == RGB(0,0,0))                                    Pixel = "0"; // czarny
             if (Kolor <= RGB(128,0,0) && Kolor > RGB(0,0,0))            Pixel = "4"; // magneta
             if (Kolor <= RGB(128,128,128) && Kolor > RGB(0,255,255))    Pixel = "8"; // szary ciemny
             if (Kolor <= RGB(192,192,192) && Kolor > RGB(128,128,128))  Pixel = "7"; // szary
             if (Kolor <= RGB(255,255,255) && Kolor > RGB(192,192,192))  Pixel = "F"; // bia�y
             if (Kolor <= RGB(0,128,128) && Kolor > RGB(255,0,255))      Pixel = "3"; // zielony ciemny
             if (Kolor <= RGB(255,0,0) && Kolor > RGB(128,0,0))          Pixel = "C"; // czerwiny
             if (Kolor <= RGB(128,0,128) && Kolor > RGB(0,0,255))        Pixel = "5"; // czerwony ciemny
             if (Kolor <= RGB(0,128,0) && Kolor > RGB(255,0,0))          Pixel = "2"; // zielony
             if (Kolor <= RGB(0,255,0) && Kolor > RGB(0,128,0))          Pixel = "A"; // zielony jasny
             if (Kolor <= RGB(128,128,0) && Kolor > RGB(0,255,0))        Pixel = "6"; // fiolet ciemny
             if (Kolor <= RGB(255,0,255) && Kolor > RGB(128,0,128))      Pixel = "D"; // fioletowy
             if (Kolor <= RGB(255,255,0) && Kolor > RGB(128,128,0))      Pixel = "E"; // ��ty
             if (Kolor <= RGB(0,0,128) && Kolor > RGB(255,255,0))        Pixel = "1"; // niebieski
             if (Kolor <= RGB(0,0,255) && Kolor > RGB(0,0,128))          Pixel = "9"; // niebieski jasny
             if (Kolor <= RGB(0,255,255) && Kolor > RGB(0,128,128))      Pixel = "B"; // b��kit
             */// to na g�rze nie dzia�a dobrze bo nie ma prawa wi�c poprawia to to na dole
             if (Kolor==RGB(0,0,0))       Pixel = '0';
             if (Kolor==RGB(128,0,0))     Pixel = '4';
             if (Kolor==RGB(255,0,0))     Pixel = 'C';
             if (Kolor==RGB(0,128,0))     Pixel = '2';
             if (Kolor==RGB(0,255,0))     Pixel = 'A';
             if (Kolor==RGB(128,128,0))   Pixel = '6';
             if (Kolor==RGB(255,255,0))   Pixel = 'E';
             if (Kolor==RGB(0,0,128))     Pixel = '1';
             if (Kolor==RGB(0,0,255))     Pixel = '9';
             if (Kolor==RGB(128,0,128))   Pixel = '5';
             if (Kolor==RGB(255,0,255))   Pixel = 'D';
             if (Kolor==RGB(0,128,128))   Pixel = '3';
             if (Kolor==RGB(0,255,255))   Pixel = 'B';
             if (Kolor==RGB(128,128,128)) Pixel = '8';
             if (Kolor==RGB(192,192,192)) Pixel = '7';
             if (Kolor==RGB(255,255,255)) Pixel = 'F';
             if (Pixel=='X') Pixel ='0';
             plik << Pixel;
            }
         plik << endl;
         //
         if (Y&4) Form1->ProgressBar1->Position = __int32(Form1->ProgressBar1->Max * Y/YMax);
        }
plik.close();
//
// jeszcze tylko progress bar
//
ProgressBar1->Width = Form1->ClientWidth - 8;
Form1->ProgressBar1->Position = 0;
}
}
catch (...) { ShowMessage("Unknown ERROR"); }

Original = false;
Robie = false;
FormResize(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::About1Click(TObject *Sender)
{
if (About_form->ShowModal()!=mrOk) Close();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SaveAs1Click(TObject *Sender)
{
if (Robie==true) return;
Robie=true;

NazwaPlikuSave = SaveDialog1->FileName;
Dlugo = SaveDialog1->FileName.Length();
NazwaPlikuSave.Delete(Dlugo-2,3);
NazwaPlikuSave.Insert("GFT",Dlugo-2);
SaveDialog1->FileName = NazwaPlikuSave;

if (!SaveDialog1->Execute())
   {Robie = false;
    return;
   }
NazwaPlikuSave = SaveDialog1->FileName;
Dlugo = SaveDialog1->FileName.Length();
Original = true;
Robie = false;
Save1Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormResize(TObject *Sender)
{
ProgressBar1->Width = Form1->ClientWidth-8;
Form1->Caption= "QBPain Converter "+ ExtractFileName(NazwaPliku)+
                " "+(String)XMax + " X "+(String)YMax + " | "+
                (String)Image1->Width + " X " +(String)Image1->Height;
if (First==true)
    return; // jesli otwierany nowy plik to wr��

if (Stretchtowindow1->Checked==true)
   {
    Image1->Height = Bevel1->Height - 2;
    Image1->Width  = Bevel1->Width - 2;
    Image1->Left   = 1;
    Image1->Top    = 1;
    return;
   }
if ((Bevel1->Width-2) > Image1->Width && (unsigned __int32)Bevel1->Height >= (Bevel1->Width * YMax) / XMax) // powi�kszanie
   {
    Image1->Height = ((Bevel1->Width-2) * YMax) / XMax;
    Image1->Width  =   Bevel1->Width-2;
    Image1->Top    =  (Bevel1->Height-2-Image1->Height) / 2 + 1;
    return;
   }
if ((Bevel1->Height-2)>Image1->Height && (unsigned __int32)Bevel1->Width >= (Bevel1->Height * XMax) / YMax)
   {
    Image1->Height =   Bevel1->Height-2;
    Image1->Width  = ((Bevel1->Height-2) * XMax) / YMax;
    Image1->Left   =  (Bevel1->Width-2-Image1->Width) / 2 + 1;
    return;
   }
if (XMax > (unsigned __int32)Bevel1->Width-2)   // pomniejszanie
   {
    Image1->Height = (Image1->Width * YMax) / XMax;
    Image1->Width  =  Bevel1->Width - 2;
   }
if (Image1->Height > Bevel1->Height - 2)
   {
    Image1->Height =  Bevel1->Height - 2;
    Image1->Width  = (Image1->Height * XMax) / YMax;
   }
if (YMax > (unsigned __int32)Bevel1->Height-2)
   {
    Image1->Height =  Bevel1->Height - 2;
    Image1->Width  = (Image1->Height * XMax) / YMax;
   }
if (Image1->Width > Bevel1->Width - 2)
   {
    Image1->Height = (Image1->Width * YMax) / XMax;
    Image1->Width  =  Bevel1->Width - 2;
   }
Image1->Left = (Bevel1->Width-2-Image1->Width)/2 + 1;
 Image1->Top = (Bevel1->Height-2-Image1->Height)/2 + 1;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
delete Bm;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Stretch1Click(TObject *Sender)
{
if (Robie == true) return;

Robie = true;
Stretchtowindow1->Checked = !Stretchtowindow1->Checked;
Robie = false;

FormResize(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Skala111Click(TObject *Sender)
{
Form2->Show();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender)
{
if (About_form->ShowModal()!=mrOk) Close();
}
//---------------------------------------------------------------------------




