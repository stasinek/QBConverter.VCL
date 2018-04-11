//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cspin"
#pragma link "CSPIN"
#pragma resource "*.dfm"

TForm2 *Form2;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm2::SpeedButton1Click(TObject *Sender)
{
float skala = CSpinEdit1->Value * 0.01;
Form1->ClientHeight = (int)(Form1->Image1->Picture->Height*skala + 22);
Form1->ClientWidth = (int)(Form1->Image1->Picture->Width*skala + 2);
Form2->Hide();
Form1->FormResize(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm2::SpeedButton2Click(TObject *Sender)
{
Form2->Hide();    
}
//---------------------------------------------------------------------------
