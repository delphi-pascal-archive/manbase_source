unit paswd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit6: TEdit;
    RichEdit2: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  shif_str: string;

implementation

uses adsbaz, usprint;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
 if Edit1.Text=''
 then ;
 if Edit1.Text=shif_str
 then
  begin
   Form3.Show;
   Form2.Hide;
  end
 else
  begin
   MessageDlg('Íåâåğíûé ïàğîëü!',mtError,[mbOk],0);
   Close;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then Button1.Click;
end;

procedure TForm2.FormCreate(Sender: TObject);
Label M;
var
 i,j,j1,x,n,z,s,s1,tt,c,f: integer;
 st,a: string;
begin
 Application.Title:='Áàçà ïğåäïğèÿòèé è ìåíåäæåğîâ v1.1';
 // ïàğîëü êàê ïğè âõîäå â Win XP
 Edit1.Font.Name:='Wingdings';
 Edit1.PasswordChar:='l'; // ñèìâîë "òî÷êà"
 //
 j:=78575;
 j1:=j;
 Edit6.Text:='1234567890ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~ .,:;"-=+\/|!?@#$%^&*_¹<>()[]{}`';
 try
  RichEdit2.Lines.LoadFromFile('conf.ps');
 except
  MessageDlg('Ôàéë "conf.ps" íå íàéäåí!',mtError,[mbOK],0);
  Close;
 end;
 st:='1234567890ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~ .,:;"-=+\/|!?@#$%^&*_¹<>()[]{}`';
 a:=RichEdit2.Lines.Strings[0];
 x:=length(a);
 try
  for i:=1 to x do
   begin
    if pos(a[i],Edit6.Text)<>0 then
     begin
      Edit6.SelStart:=pos(a[i],Edit6.Text)-1;
      n:=Edit6.SelStart;
      s1:=n+1;
      j:=j1;
      s:=s1-j;
      if ((s<=159) and (s>=0)) then
       begin
        s:=s1-j;
        a[i]:=st[s];
        goto M;
       end;
      j:=j1-n-1;
      repeat
       tt:=j-159;
       s:=abs(tt);
       j:=s;
      until (s<=159);
      s:=159-s;
      a[i]:=st[s];
      M:
     end
    else
   end;
  shif_str:=a;
 except
  MessageDlg('Îøèáêà îòêğûòèÿ ïàğîëÿ!',mtError,[mbOK],0);
 end;
end;

end.
