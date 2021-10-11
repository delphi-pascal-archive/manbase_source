unit adsbaz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids, Printers, ShellApi;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Previous: TButton;
    Next: TButton;
    New: TButton;
    Delete: TButton;
    Save: TButton;
    Button1: TButton;
    Label5: TLabel;
    RichEdit1: TRichEdit;
    Button2: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Button4: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit6: TEdit;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Bevel2: TBevel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit7: TEdit;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel4: TBevel;
    Label6: TLabel;
    Bevel7: TBevel;
    SpeedButton1: TSpeedButton;
    Button3: TButton;
    Memo1: TMemo;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure PreviousClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

uses usprint, paswd;

type
 TNote=record
  org: string[200];
  adr: string[255];
  tel: string[150];
  kontl: string[150];
  email: string[100];
  reg: string[200];
  vidd: string[200];
  osnprod: string[200];
  meneg: string[150];
end;

var
 NoteFile: file of TNote;
 NoteData: TNote;
 _Pos: integer;

procedure ShowRecord;
begin
 Form3.Edit1.Text:=NoteData.org;
 Form3.RichEdit1.Text:=NoteData.adr;
 Form3.Edit2.Text:=NoteData.tel;
 Form3.Edit3.Text:=NoteData.kontl;
 Form3.Edit6.Text:=NoteData.email;
 Form3.ComboBox2.Text:=Notedata.reg;
 Form3.ComboBox3.Text:=Notedata.vidd;
 Form3.ComboBox4.Text:=Notedata.osnprod;
 Form3.ComboBox5.Text:=Notedata.meneg;
end;

procedure ClearData;
begin
 Form3.Edit1.Text:='';
 Form3.RichEdit1.Text:='';
 Form3.Edit2.Text:='';
 Form3.Edit3.Text:='';
 Form3.Edit6.Text:='';
 Form3.ComboBox2.Text:='';
 Form3.ComboBox3.Text:='';
 Form3.ComboBox4.Text:='';
 Form3.ComboBox5.Text:='';
end;

// Pos ���������� � ���� - 0,1,2,3,4,5,6,...
// FileSize ���������� � ������� - 1,2,3,4,5,6,7,8,...

function GetProgramPath : String;
begin
 GetProgramPath:=ExtractFilePath(ParamStr(0));
end;

procedure TForm3.FormCreate(Sender: TObject);
var
 pPos, cPos, i, j: integer;
 s: string;
begin
 Edit4.Text:='1234567890����������������������������������������������������������������ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~ .,:;"-=+\/|!?@#$%^&*_�<>()[]{}`';
 //
 AssignFile(NoteFile,GetProgramPath+'data\'+'adsbaz.dat'); // ��������� ���������� � ������
 if not FileExists(GetProgramPath+'data\'+'adsbaz.dat') then // ���� ���� �� ����������
  begin
   ForceDirectories(GetProgramPath+'\data');
   Rewrite(NoteFile);  // �������� �����
   _Pos:=0;
  end
  else
   begin   // ���� ���� ����������, ��... (CopyFile - ��������� �����������)
    CopyFile(pchar(GetProgramPath+'data\'+'adsbaz.dat'),pchar(GetProgramPath+'data\'+'adsbaz_.dat'),false);
    Reset(NoteFile); // �������� �����
    _Pos:=0;
    if not Eof(NoteFile) then // ���� � ����� ���� ������
     begin
      Seek(NoteFile,_Pos); // ����������� �� Pos
      Read(NoteFile,NoteData); // ������ ������
      ShowRecord; // �������� ������
      if _Pos=0 then Previous.Enabled:=false;
      Delete.Enabled:=true;
      if FileSize(NoteFile)>=2
      then Next.Enabled:=true; // ���� ������ ������ ��� ����� 2
     end;
   end;
///////////////////// ������  //////////////////////////////////
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // ������ ������
 s:=NoteData.reg;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox2.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.reg;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.reg;
   if s<>'' then
    begin
     for i:=0 to ComboBox2.Items.Count-1 do
      if pos(s,ComboBox2.Items.Strings[i])=0
      then j:=2
      else
       begin
        j:=1;
        Break;
       end;
    end;
   if j=2 then ComboBox2.Items.Add(s);
   j:=0;
  end;
 ComboBox2.Sorted:=true;
////////////  ��� ����-��
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // ������ ������
 s:=NoteData.vidd;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox3.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.vidd;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.vidd;
   if s<>'' then
    begin
     for i:=0 to ComboBox3.Items.Count-1 do
     if pos(s,ComboBox3.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox3.Items.Add(s);
   j:=0;
  end;
 ComboBox3.Sorted:=true;
////////////  ���. ���������
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // ������ ������
 s:=NoteData.osnprod;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox4.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.osnprod;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.osnprod;
   if s<>'' then
    begin
     for i:=0 to ComboBox4.Items.Count-1 do
     if pos(s,ComboBox4.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox4.Items.Add(s);
   j:=0;
  end;
 ComboBox4.Sorted:=true;
////////////  ��������
 cPos:=0;
 Seek(NoteFile,cPos);
 Read(NoteFile,NoteData); // ������ ������
 s:=NoteData.meneg;
 for i:=0 to FileSize(NoteFile)-1 do
  begin
   if s<>'' then
    begin
     ComboBox5.Items.Add(s);
     break;
    end;
   inc(cPos);
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.meneg;
  end;
 for cPos:=0 to FileSize(NoteFile)-1 do
  begin
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.meneg;
   if s<>'' then
    begin
     for i:=0 to ComboBox5.Items.Count-1 do
     if pos(s,ComboBox5.Items.Strings[i])=0
     then j:=2
     else
      begin
       j:=1;
       Break;
      end;
    end;
   if j=2 then ComboBox5.Items.Add(s);
   j:=0;
  end;
 ComboBox5.Sorted:=true;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����   end;
 Label4.Caption:='������ �  '+IntToStr(_pos+1)+' �� '+IntToStr(pPos);
end;

procedure TForm3.NewClick(Sender: TObject);
var
 pPos: integer;
begin
 ClearData; //������� ����
 Edit1.SetFocus;
 _Pos:=FileSize(NoteFile); //����������� ���-�� ����������� �����
 Seek(NoteFile,_Pos); //�������. ��������� �� ����� �����
 Button2.Enabled:=false;
 Previous.Enabled:=false;
 Next.Enabled:=false;
 Delete.Enabled:=false;
 Save.Enabled:=true;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); //����������� ���-�� ����������� �����   end;
 Label4.Caption:='������ �  '+IntToStr(_pos+1)+' �� '+IntToStr(pPos+1);
end;

procedure TForm3.SaveClick(Sender: TObject);
begin
 NoteData.org:=Edit1.Text;
 NoteData.adr:=RichEdit1.Text;
 NoteData.tel:=Edit2.Text;
 NoteData.kontl:=Edit3.Text;
 NoteData.email:=Edit6.Text;
 Notedata.reg:=ComboBox2.Text;
 Notedata.vidd:=ComboBox3.Text;
 Notedata.osnprod:=ComboBox4.Text;
 Notedata.meneg:=ComboBox5.Text;
 Write(NoteFile,NoteData); // ������ � ����
 Button2.Enabled:=true;
 Next.Enabled:=false;
 Save.Enabled:=false;
 Delete.Enabled:=true;
 if FileSize(NoteFile)>=2 then
 Previous.Enabled:=true;
end;

procedure TForm3.PreviousClick(Sender: TObject);
var
 pPos: integer;
begin
 Next.Enabled:=true;
 if _Pos<>0 then dec(_Pos); // ���� ��������� �� ����� 0, �� ��s-1
 Seek(NoteFile,_Pos); // ����������� �� Pos-1
 Read(NoteFile,NoteData); // ������ Pos-1
 ShowRecord; // �������� ������
 if _Pos=0 then Previous.Enabled:=false; //���� �����-0, ��...
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����   end;
 Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos);
end;

procedure TForm3.NextClick(Sender: TObject);
var
  pPos:integer;
begin
 Previous.Enabled:=true;
 if _Pos=FileSize(NoteFile)-2  // ���� ����� �������=���-��
 then Next.Enabled:=false;     // �������, ��...
 inc(_Pos); // Pos+1
 Seek(NoteFile,_Pos); // ������� ��������� �� Pos+1
 Read(NoteFile,NoteData); // ������ ������
 ShowRecord; // �������� ������
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����   end;
 Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos);
end;

procedure TForm3.DeleteClick(Sender: TObject);
var
 i:integer;
 pPos: integer;
begin
 if MessageDlg('�� ������������� ������ ������� ������?', mtConfirmation,
    [mbYes, mbNo],0)=mrYes
 then
  begin
   if _Pos=FileSize(NoteFile)-1 then // ���� ��������� ��-� ���������
    begin
     Seek(NoteFile,_Pos);
     Truncate(NoteFile);
     Next.Enabled:=false;
     if _Pos<>0
     then dec(_Pos) // ���� ���� ������, �� Pos-1
     else
      begin
       Delete.Enabled:=false;
       ClearData;
       exit;
      end;
    end
   else
    begin
     for i:=_Pos+1 to FileSize(NoteFile)-1 do
      begin
       Seek(NoteFile,i); // ������� �� Pos+1
       Read(NoteFile,NoteData); // ������
       Seek(NoteFile,i-1); // ������� �� Pos
       Write(NoteFile,Notedata); // ������ Pos+1 � Pos
      end;
     Seek(NoteFile,FileSize(NoteFile)-1);
     Truncate(NoteFile);
    end;
   Seek(NoteFile,_Pos);
   Read(NoteFile,NoteData);
   ShowRecord;
   if _Pos=0 then Previous.Enabled:=false;
   /////////////////////////////////////////////////////////////
   pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����   end;
   Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos);
  end
 else
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
 NoteData.org:=Edit1.Text;
 NoteData.adr:=RichEdit1.Text;
 NoteData.tel:=Edit2.Text;
 NoteData.kontl:=Edit3.Text;
 NoteData.email:=Edit6.Text;
 Notedata.reg:=ComboBox2.Text;
 Notedata.vidd:=ComboBox3.Text;
 Notedata.osnprod:=ComboBox4.Text;
 Notedata.meneg:=ComboBox5.Text;
 if _Pos=0
 then _Pos:=0
 else _Pos:=FilePos(NoteFile)-1; // ����������� ��������. ���������
 Seek(NoteFile,_Pos);
 Write(NoteFile,NoteData); // ������ � ����
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
  CloseFile(NoteFile);
 except
  MessageDlg('������ �������� �����!',mtError,[mbOK],0);
 end;
 Form2.Close;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
 Form1.Show;
end;

procedure TForm3.Button7Click(Sender: TObject);
var
 pPos, p: integer;
begin
 ClearData; // ������� ����
 Edit1.SetFocus;
 _Pos:=0; // ����������� ���-�� ����������� �����
 Seek(NoteFile,_Pos); // �������. ��������� �� ����� �����
 Read(NoteFile,NoteData); // ������ Pos-1
 ShowRecord; // �������� ������
 Previous.Enabled:=false;
 Next.Enabled:=true;
 Delete.Enabled:=true;
 Save.Enabled:=false;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile)-1; // ����������� ���-�� ����������� �����
 Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos+1);
end;

procedure TForm3.Button6Click(Sender: TObject);
var
 pPos: integer;
begin
 ClearData; // ������� ����
 Edit1.SetFocus;
 _Pos:=FileSize(NoteFile)-1;
 Seek(NoteFile,_Pos); // �������. ��������� �� ����� �����
 Read(NoteFile,NoteData);
 ShowRecord;
 Previous.Enabled:=true;
 Next.Enabled:=false;
 Delete.Enabled:=true;
 Save.Enabled:=false;
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����
 Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos);
end;

procedure TForm3.Button8Click(Sender: TObject);
var
 pPos: integer;
begin
 pPos:=FileSize(NoteFile);
 if StrToInt(Edit7.Text)>pPos
 then
  begin
   MessageDlg('�������� ����� ('+Edit7.Text+') ������, ��� ���������� ������� ('+IntToStr(pPos)+') !',mtError,[mbOK],0);
   Edit7.Text:='1';
   Edit7.SetFocus;
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
   Exit;
  end;
 if StrToInt(Edit7.Text)=0 then
  begin
   MessageDlg('�������� ����� ('+Edit7.Text+') ������ 1!',mtError,[mbOK],0);
   Edit7.Text:='1';
   Edit7.SetFocus;
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
   Exit;
  end;
 ClearData; // ������� ����
 Edit1.SetFocus;
 _Pos:=StrToInt(Edit7.Text);
 Seek(NoteFile,_Pos-1);
 Read(NoteFile,NoteData);
 ShowRecord; // �������� ������
 if _Pos-1=FileSize(NoteFile)-1    // ���� ����� �������=���-��
 then                              // �������, ��...
  begin
   Next.Enabled:=false;
   Previous.Enabled:=true;
  end;
 if _Pos-1=0                   // ���� ����� �������=���-��
 then                          // �������, ��...
  begin
   Next.Enabled:=true;
   Previous.Enabled:=false;
  end;
 if (_Pos-1>0) and (_Pos-1<FileSize(NoteFile)-1)
 then
  begin
   Next.Enabled:=true;
   Previous.Enabled:=true;
  end;
 Delete.Enabled:=true;
 Save.Enabled:=false;
 Button2.Enabled:=true;
 pPos:=FileSize(NoteFile);
 dec(_Pos);
////////////////////////////////////////////////////////////////
 pPos:=FileSize(NoteFile); // ����������� ���-�� ����������� �����
 Label4.Caption:='������ �  '+IntToStr(_Pos+1)+' �� '+IntToStr(pPos);
end;

procedure TForm3.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then
  begin
   Edit7.Text:='1';
   Edit7.SelStart:=0;
   Edit7.SelLength:=1;
  end;
 if (Key<'0') or (Key>'9') then Key:=#0;
 if Length(Edit7.Text)>=4 then Key:=#0;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
 ShowMessage('-------  ���� ����������� � ���������� v1.1  -------'+#10#13+
             '��������� ������������� ��� ������� ����'+#10#13+
             '������ � ������������, � �������� ������������'+#10#13+
             '���� �����������, � ����� ��� ����� ���������'+#10#13+
             '����������, ���������� � �����������'+#10#13+
             '�������������.'+#10#13+
             'Created by Simagin Andrey V., 2003-2005.'+#10#13+
             '-------------------------------------------------------------------'+#10#13+
             '�������, ��������� � ��������� �� ������'+#10#13+
             '��������� ���������� �� �����:'+#10#13+
             'E-mail: admin_ds@delphisources.ru'+#10#13+
             'Web-site: www.delphisources.ru');
 ShellExecute(0,'open','http://www.delphisources.ru','','',SW_SHOW);             
end;

procedure TForm3.Button3Click(Sender: TObject);
Label M;
var
 newp,st,a: string;
 i,x,j,j1,n,s,s1,tt: integer;
begin
 if MessageDlg('�� ������������� ������ �������� ������?', mtConfirmation,
    [mbYes, mbNo],0)=mrYes
 then
  begin
  // �������� 78575
  newp:=InputBox('������� ����� ������','����� ������:','');
  if newp='' then
   begin
    MessageDlg('������ �� ���� � ��������� �� �������!',mtError,[mbOK],0);
    Exit;
   end;
  //
  j:=78575;
  j1:=j;
  st:='1234567890����������������������������������������������������������������ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~ .,:;"-=+\/|!?@#$%^&*_�<>()[]{}`';
  a:=newp;
  x:=length(a);
  try
   for i:=1 to x do
    begin
     if pos(a[i],Edit4.Text)<>0 then
      begin
       Edit4.SelStart:=pos(a[i],Edit4.Text)-1;
       n:=Edit4.SelStart;
       s1:=n+1;
       j:=j1;
       s:=s1+j;
       if (s<=159) then
        begin
         s:=s1+j;
         a[i]:=st[s];
         goto M;
        end;
       s:=159-(n+1);
       j:=j1-s;
       repeat
        tt:=j-159;
        s:=abs(tt);
        j:=s;
       until (s<=159);
       a[i]:=st[s];
       M:
      end
     else
    end;
   Memo1.Lines.LoadFromFile('conf.ps');
   Memo1.Lines.Strings[0]:=a;
   Memo1.Lines.SaveToFile('conf.ps');
   MessageDlg('������ �� ���� � ��������� ������� �������!',mtInformation,[mbOK],0);
  except
   MessageDlg('������ ���������� ������!'+#10#13+'������ �� �������',mtError,[mbOK],0);
  end;
 end;
end;

end.
