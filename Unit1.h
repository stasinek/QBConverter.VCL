//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>
#include <vcl\Menus.hpp>
#include <vcl\Dialogs.hpp>
#include <string.h>
#include <condefs.h>
#include <fstream.h>
#include <conio.h>
#include <vcl\ComCtrls.hpp>
#include <Graphics.hpp>

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TPopupMenu *PopupMenu1;
	TMenuItem *Open1;
	TMenuItem *Exit1;
	TOpenDialog *OpenDialog1;
	TSaveDialog *SaveDialog1;
	TMenuItem *Save1;
	TMenuItem *About1;
	TPanel *Panel1;
	TProgressBar *ProgressBar1;
	TMenuItem *SaveAs1;
	TBevel *Bevel1;
	TImage *Image1;
	TMenuItem *N1;
    TMenuItem *Skala111;
    TMainMenu *MainMenu1;
    TMenuItem *N2;
    TMenuItem *Open2;
    TMenuItem *Save2;
    TMenuItem *Exit2;
    TMenuItem *Scale1;
    TMenuItem *Stretchtowindow1;
    TMenuItem *Skala1;
	void __fastcall Exit1Click(TObject *Sender);
	void __fastcall Open1Click(TObject *Sender);
	void __fastcall Save1Click(TObject *Sender);
	void __fastcall About1Click(TObject *Sender);
	void __fastcall SaveAs1Click(TObject *Sender);
    void __fastcall FormResize(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall Stretch1Click(TObject *Sender);
    
    void __fastcall Skala111Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TForm1 *Form1;
//---------------------------------------------------------------------------
#endif

