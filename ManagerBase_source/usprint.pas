unit usprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Printers, ComCtrls, DBGrids, Clipbrd,
  OleServer, EXCEL97, EXCEL2000, ComObj, ActiveX, ExtCtrls, ExcelXP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    SaveDialog1: TSaveDialog;
    Button7: TButton;
    Button10: TButton;
    Button11: TButton;
    XLApp: TExcelApplication;
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    Button3: TButton;
    ComboBox1: TComboBox;
    Button8: TButton;
    Button9: TButton;
    ComboBox2: TComboBox;
    Button4: TButton;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses adsbaz;

{$R *.dfm}

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

function GetProgramPath : String;
begin
 GetProgramPath:=ExtractFilePath(ParamStr(0));
end;

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

procedure TForm1.Button1Click(Sender: TObject);
var
 Stroka: System.Text;
 i: integer;
begin
 Button2.Click;
 AssignPrn(Stroka);
 Rewrite(Stroka);
 Printer.Canvas.Font:=RichEdit2.Font;
 for i:=0 to RichEdit2.Lines.Count-1 do
  Writeln(Stroka,RichEdit2.Lines[i]);
 System.Close(stroka);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 i,l:integer;
 a,b,c,d,e,x:string;
begin
 RichEdit2.Lines.Clear;
 RichEdit2.Lines.Add('|-------------------------------------------------------------------------------------------------------------------------|');
 RichEdit2.Lines.Add('|   �   |  �������.  |  �����  |  �������  |  ����. ����  |  E-mail  |  ������  |  ��� ����.  |  ���. ����.  |  ��������  |');
 RichEdit2.Lines.Add('|-------------------------------------------------------------------------------------------------------------------------|');
 for i:=1 to StringGrid1.RowCount-1 do
  begin
   a:=StringGrid1.Cells[1,i];
   b:=StringGrid1.Cells[2,i];
   c:=StringGrid1.Cells[3,i];
   d:=StringGrid1.Cells[4,i];
   e:=StringGrid1.Cells[5,i];
   ////////////////////////////////////////////////
   l:=Length(a);
   x:=a;
   Delete(x,l,1);
   if (StrToInt(x)<10)
   then a:=a+'      ';
   if (StrToInt(x)>=10) and (StrToInt(x)<100)
   then a:=a+'     ';
   ////////////////////////////////////////////////
   RichEdit2.Lines.Add('|  '+a+'  |   '+b+'   |   '+c+'   |   '+d+'   |   '+e+'   |');
  end;
 RichEdit2.Lines.Add('|-------------------------------------------------------------------------------------------------------------------------|');
 StringGrid1.Row:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 AssignFile(NoteFile,GetProgramPath+'data\'+'adsbaz.dat'); // ��������� ���������� � ������
 Reset(NoteFile); // �������� �����
 _Pos:=0;
  if not Eof(NoteFile) then // ���� � ����� ���� ������
   begin
    Read(NoteFile,NoteData); // ������ ������
    _Pos:=FilePos(NoteFile)-1; // ����������� ��������. ���������
    ShowRecord; // �������� ������
   end;
 StringGrid1.ColWidths[0]:=10;
 StringGrid1.ColWidths[1]:=50;
 StringGrid1.ColWidths[2]:=100;
 StringGrid1.ColWidths[3]:=100;
 StringGrid1.ColWidths[4]:=98;
 StringGrid1.ColWidths[5]:=100;
 StringGrid1.ColWidths[6]:=95;
 StringGrid1.ColWidths[7]:=95;
 StringGrid1.ColWidths[8]:=100;
 StringGrid1.ColWidths[9]:=100;
 StringGrid1.ColWidths[10]:=100;
 StringGrid1.RowHeights[0]:=20;
 StringGrid1.RowCount:=2;
 StringGrid1.Cells[1,0]:='�';
 StringGrid1.Cells[2,0]:='�������-�';
 StringGrid1.Cells[3,0]:='�����';
 StringGrid1.Cells[4,0]:='�������';
 StringGrid1.Cells[5,0]:='����. ����';
 StringGrid1.Cells[6,0]:='E-mail';
 StringGrid1.Cells[7,0]:='������';
 StringGrid1.Cells[8,0]:='��� ����-��';
 StringGrid1.Cells[9,0]:='���. ����-�';
 StringGrid1.Cells[10,0]:='��������';
 Form1.Caption:='�������... (0 ������� �� '+IntToStr(FileSize(NoteFile))+')';
end;

procedure TForm1.Button3Click(Sender: TObject);
Label Thenext1;
Label Thenext2;
Label Thenext3;
var
 pPos,i,ch,zap: integer;
 s: string;
begin
 ch:=0;
 for i:=1 to StringGrid1.RowCount-1 do
  StringGrid1.Rows[i].Clear;
 StringGrid1.RowCount:=2;
 StringGrid1.FixedCols:=1;
 StringGrid1.FixedRows:=1;
////////////////////////////////////////////////////////////////
 if ComboBox1.Text='�����������'
 then
  begin
   zap:=0;
   for pPos:=0 to FileSize(NoteFile)-1 do
    begin
     Seek(NoteFile,pPos);
     Read(NoteFile,NoteData); // ������ ������
     if NoteData.org=''
     then goto Thenext2;
     s:=NoteData.org;
     if pos(ComboBox2.Text,s)<>0
     then
      begin
       ch:=ch+1;
       StringGrid1.Cells[1,ch]:=IntToStr(ch)+'.';
       StringGrid1.Cells[2,ch]:=NoteData.org;
       StringGrid1.Cells[3,ch]:=NoteData.adr;
       StringGrid1.Cells[4,ch]:=NoteData.tel;
       StringGrid1.Cells[5,ch]:=NoteData.kontl;
       StringGrid1.Cells[6,ch]:=NoteData.email;
       StringGrid1.Cells[7,ch]:=NoteData.reg;
       StringGrid1.Cells[8,ch]:=NoteData.vidd;
       StringGrid1.Cells[9,ch]:=NoteData.osnprod;
       StringGrid1.Cells[10,ch]:=NoteData.meneg;
       StringGrid1.RowCount:=StringGrid1.RowCount+1;
       zap:=zap+1;
       Form1.Caption:='������� ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
       Application.ProcessMessages;
      end;
     Thenext2:
    end;
   Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
   StringGrid1.RowCount:=StringGrid1.RowCount-1;
  end;
////////////////////////////////////////////////////////////////
 if ComboBox1.Text='������'
 then
  begin
   zap:=0;
   for pPos:=0 to FileSize(NoteFile)-1 do
    begin
     Seek(NoteFile,pPos);
     Read(NoteFile,NoteData); // ������ ������
     if NoteData.reg='' then goto Thenext1;
     s:=NoteData.reg;
     if s=ComboBox2.Text then
      begin
       ch:=ch+1;
       StringGrid1.Cells[1,ch]:=IntToStr(ch)+'.';
       StringGrid1.Cells[2,ch]:=NoteData.org;
       StringGrid1.Cells[3,ch]:=NoteData.adr;
       StringGrid1.Cells[4,ch]:=NoteData.tel;
       StringGrid1.Cells[5,ch]:=NoteData.kontl;
       StringGrid1.Cells[6,ch]:=NoteData.email;
       StringGrid1.Cells[7,ch]:=NoteData.reg;
       StringGrid1.Cells[8,ch]:=NoteData.vidd;
       StringGrid1.Cells[9,ch]:=NoteData.osnprod;
       StringGrid1.Cells[10,ch]:=NoteData.meneg;
       StringGrid1.RowCount:=StringGrid1.RowCount+1;
       zap:=zap+1;
       Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
       Application.ProcessMessages;
      end;
     Thenext1:
    end;
   Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
   StringGrid1.RowCount:=StringGrid1.RowCount-1;
  end;
////////////////////////////////////////
 if ComboBox1.Text='��������'
 then
  begin
   zap:=0;
   for pPos:=0 to FileSize(NoteFile)-1 do
    begin
     Seek(NoteFile,pPos);
     Read(NoteFile,NoteData); // ������ ������
     if NoteData.meneg='' then goto Thenext3;
     s:=NoteData.meneg;
     if s=ComboBox2.Text then
      begin
       ch:=ch+1;
       StringGrid1.Cells[1,ch]:=IntToStr(ch)+'.';
       StringGrid1.Cells[2,ch]:=NoteData.org;
       StringGrid1.Cells[3,ch]:=NoteData.adr;
       StringGrid1.Cells[4,ch]:=NoteData.tel;
       StringGrid1.Cells[5,ch]:=NoteData.kontl;
       StringGrid1.Cells[6,ch]:=NoteData.email;
       StringGrid1.Cells[7,ch]:=NoteData.reg;
       StringGrid1.Cells[8,ch]:=NoteData.vidd;
       StringGrid1.Cells[9,ch]:=NoteData.osnprod;
       StringGrid1.Cells[10,ch]:=NoteData.meneg;
       StringGrid1.RowCount:=StringGrid1.RowCount+1;
       zap:=zap+1;
       Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
       Application.ProcessMessages;
      end;
     Thenext3:
    end;
   Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
   StringGrid1.RowCount:=StringGrid1.RowCount-1;
  end;
////////////////////////////////////////////////////////////////
 if ComboBox1.Text='���'
 then
  begin
   zap:=0;
   for pPos:=0 to FileSize(NoteFile)-1 do
    begin
     Seek(NoteFile,pPos);
     Read(NoteFile,NoteData); //������ ������
     StringGrid1.Cells[1,pPos+1]:=IntToStr(pPos+1)+'.';
     StringGrid1.Cells[2,pPos+1]:=NoteData.org;
     StringGrid1.Cells[3,pPos+1]:=NoteData.adr;
     StringGrid1.Cells[4,pPos+1]:=NoteData.tel;
     StringGrid1.Cells[5,pPos+1]:=NoteData.kontl;
     StringGrid1.Cells[6,pPos+1]:=NoteData.email;
     StringGrid1.Cells[7,pPos+1]:=NoteData.reg;
     StringGrid1.Cells[8,pPos+1]:=NoteData.vidd;
     StringGrid1.Cells[9,pPos+1]:=NoteData.osnprod;
     StringGrid1.Cells[10,pPos+1]:=NoteData.meneg;
     StringGrid1.RowCount:=StringGrid1.RowCount+1;
     zap:=zap+1;
     Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
     Application.ProcessMessages;
    end;
   Form1.Caption:='�������... ('+IntToStr(zap)+' ������� �� '+IntToStr(FileSize(NoteFile))+')';
   StringGrid1.RowCount:=StringGrid1.RowCount-1;
  end;
////////////////////////////////////////////////////////////////
 Button1.Enabled:=true;
 Button2.Enabled:=true;
 Button6.Enabled:=true;
 Button6.Enabled:=true;
 Button8.Enabled:=true;
 Button9.Enabled:=true;
 Button12.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
 pPos: integer;
begin
 for pPos:=0 to StringGrid1.RowCount-2 do
  begin
   Seek(NoteFile,pPos); // �������. ��������� �� ����� �����
   NoteData.org:=StringGrid1.Cells[2,pPos+1];
   NoteData.adr:=StringGrid1.Cells[3,pPos+1];
   NoteData.tel:=StringGrid1.Cells[4,pPos+1];
   NoteData.kontl:=StringGrid1.Cells[5,pPos+1];
   NoteData.email:=StringGrid1.Cells[6,pPos+1];
   Notedata.reg:=StringGrid1.Cells[7,pPos+1];
   Notedata.vidd:=StringGrid1.Cells[8,pPos+1];
   Notedata.osnprod:=StringGrid1.Cells[9,pPos+1];
   Notedata.meneg:=StringGrid1.Cells[10,pPos+1];
   Write(NoteFile,NoteData); // ������ � ����
  end;
 Form3.Close;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
 EditFile:string;
begin
 Button2.Click;
 if SaveDialog1.Execute then
  begin
   EditFile:=SaveDialog1.FileName;
   RichEdit2.Lines.SaveToFile(EditFile);
  end;
end;

procedure AutoSizeGridColumn(Grid: TStringGrid; column: integer);
var
 i: integer;
 temp: integer;
 max: integer;
begin
 max:=0;
 for i:=0 to Grid.RowCount-1 do
  begin
   temp:=Grid.Canvas.TextWidth(Grid.Cells[column, i]);
   if temp>max
   then max:=temp;
  end;
 Grid.ColWidths[column]:=Max+Grid.GridLineWidth+6;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
 i: integer;
begin
 for i:=0 to StringGrid1.ColCount-1 do
  AutoSizeGridColumn(StringGrid1, i);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
 n: integer;
begin
 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'num.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[1,n+1]:=RichEdit1.Lines.Strings[n];
     StringGrid1.RowCount:=StringGrid1.RowCount+1;
    end;
   StringGrid1.RowCount:=StringGrid1.RowCount-1;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'org.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[2,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'adr.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[3,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'tel.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[4,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'kontl.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[5,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'email.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[6,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'reg.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[7,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'vidd.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[8,n+1]:=RichEdit1.Lines.Strings[n];
    end;

 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'osnprod.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[9,n+1]:=RichEdit1.Lines.Strings[n];
    end;
 RichEdit1.Lines.LoadFromFile(GetProgramPath+'data\'+'meneg.txt');
   for n:=0 to RichEdit1.Lines.Count-1 do
    begin
     StringGrid1.Cells[10,n+1]:=RichEdit1.Lines.Strings[n];
    end;
end;


procedure TForm1.Button9Click(Sender: TObject);
var
 i,j,cl,rt,cr,rb: integer;
 s: string;
 CopySel: Boolean;
begin
 // CopySel:=true - ���������� ���������
 // CopySel:=false - ��� ������
 CopySel:=false;
 CL:=-1;
 RT:=-1;
 CR:=-1;
 RB:=-1;
 s:='';
 with StringGrid1 do
  begin
   if CopySel then
    begin
     CL:=Selection.Left;
     CR:=Selection.Right;
     RT:=Selection.Top;
     RB:=Selection.Bottom;
    end;
   // ��� ������������� FixedRows � FixedCols ����� �������� �� 0
   if (CL<FixedCols) or (CL>CR) or (CL>=ColCount) then CL:=FixedCols;
   if (CR<FixedCols) or (CL>CR) or (CR>=ColCount) then CR:=ColCount-1;
   if (RT<FixedRows) or (RT>RB) or (RT>=RowCount) then RT:=FixedRows;
   if (RB<FixedCols) or (RT>RB) or (RB>=RowCount) then RB:=RowCount-1;
   for i:=RT to RB do
    begin
     for j:=CL to CR do
      begin
       s:=s+Cells[j,i];
       if j<CR then s:=s+#9;
      end;
     s:=s+#13#10;
    end;
  end;
 ClipBoard.AsText:=s;
end;

function IsOLEObjectInstalled(Name: String): boolean;
var
 ClassID: TCLSID;
 Rez: HRESULT;
begin
 // ���� CLSID OLE-�������
 Rez:=CLSIDFromProgID(PWideChar(WideString(Name)), ClassID);
 if Rez=S_OK
 then Result:=true // ������ ������
 else Result:=false;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
 XL: variant; // ���������� � ������� �������� ������ EXCEL
 i,j,n: integer;
begin
 // �������� ��������� (������ Excel)
 XL:=CreateOleObject('Excel.Application');
 // ���� �� ������� ������ � ���������� ���������
 XL.DisplayAlerts:=false;
 // ����� ��������
 XL.WorkBooks.Add;
 // ��� ��������� ���
 XL.WorkBooks.Open('akt.xls');
 // ������ ��� �������
 XL.Visible:=true;
 // ����� ����� ��� �������������, ����� ��� ������ � �����,
 // ������� ��������, � ���� ���, ����� � ������
 // ����� � ������ ���� ������� ��� ������
 XL.WorkBooks[1].WorkSheets[1].PageSetup.LeftMargin:=30;
 XL.WorkBooks[1].WorkSheets[1].PageSetup.RightMargin:=10;
 // ��� �������� ���������
 XL.WorkBooks[1].WorkSheets[1].Name:='����� ����';
 // ������ ���������� �� ������ ����� ��� ������
 XL.WorkBooks[1].WorkSheets[1].PageSetup.PrintTitleRows:='$3:$3';
 XL.WorkBooks[1].WorkSheets[1].PageSetup.PrintTitleColumns:='$A:$A';
 // ������ �����
 for i := 4 to 13 do
  XL.WorkBooks[1].WorkSheets[1].Columns[i].NumberFormat:='0,00';
 XL.WorkBooks[1].WorkSheets[1].Columns[4].NumberFormat:='0';
 // ����� �������� ����� �������� ������ �������
 XL.WorkBooks[1].WorkSheets[1].Columns[1].ColumnWidth:=4.5;
 XL.WorkBooks[1].WorkSheets[1].Columns[2].ColumnWidth:=50;
 for i := 3 to 13 do
  XL.WorkBooks[1].WorkSheets[1].Columns[i].ColumnWidth := 8;
 // ����� ������
 XL.WorkBooks[1].WorkSheets[1].Rows[1].Font.Bold:=True;
 XL.WorkBooks[1].WorkSheets[1].Rows[1].Font.Color:=clBlack;
 XL.WorkBooks[1].WorkSheets[1].Rows[1].Font.Size:=16;
 XL.WorkBooks[1].WorkSheets[1].Rows[1].Font.Name:='Times New Roman';
 XL.WorkBooks[1].WorkSheets[1].Cells[1,4]:='����� ����';
 // ���������� �� ������ �� ���������
 XL.WorkBooks[1].WorkSheets[1].Rows[1].VerticalAlignment:=2;
 // ���������� �� ������ �� �����������
 XL.WorkBooks[1].WorkSheets[1].Rows[1].HorizontalAlignment:=3;
 // ���������� ������
 XL.WorkBooks[1].WorkSheets[1].Range['A1:D1'].Merge;
 // ���������� �� ������ �� ���������
 XL.WorkBooks[1].WorkSheets[1].Rows[3].VerticalAlignment:=2;
 // ���������� �� ������ �� �����������
 XL.WorkBooks[1].WorkSheets[1].Rows[3].HorizontalAlignment:=3;
 // ���������� �� ������ ����
 XL.WorkBooks[1].WorkSheets[1].Cells[3,2].HorizontalAlignment:=2;
 XL.WorkBooks[1].WorkSheets[1].Cells[3,3].HorizontalAlignment:=2;
 // ���������� �� ������� ����
 XL.WorkBooks[1].WorkSheets[1].Cells[3,4].HorizontalAlignment:=4;
 XL.WorkBooks[1].WorkSheets[1].Rows[3].Font.Color:=clBlack;
 XL.WorkBooks[1].WorkSheets[1].Rows[3].Font.Name:='Times New Roman';
 XL.WorkBooks[1].WorkSheets[1].Rows[3].Font.Size:=12;
 XL.WorkBooks[1].WorkSheets[1].Rows[3].Font.Bold:=True;
 XL.WorkBooks[1].WorkSheets[1].Cells[3,1]:='�';
 XL.WorkBooks[1].WorkSheets[1].Cells[3,2]:='������������ ���������';
 XL.WorkBooks[1].WorkSheets[1].Cells[3,3]:='��. ���.';
 // ��������� ��������� ����� ������ �����
 // Borders[1] .... [4] - ��� ���� ������ ColorIndex -4142 - ������ ���� i � n - ����������
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders.LineStyle:=1;
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders.Weight:=2;
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders[4].ColorIndex := 1;
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders[1].ColorIndex := -4142;
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders[2].ColorIndex := -4142;
 XL.WorkBooks[1].WorkSheets[1].Range['A'+IntToStr(i)+':'+chr(ord('C')+n)+IntToStr(i)].Borders[3].ColorIndex := -4142;
 // ��������� ��������� �����
 XL.WorkBooks[1].WorkSheets[1].Range['A3:'+chr(ord('C')+n)+IntToStr(i)].Borders.LineStyle:=1;
 XL.WorkBooks[1].WorkSheets[1].Range['A3:'+chr(ord('C')+n)+IntToStr(i)].Borders.Weight:=2;
 XL.WorkBooks[1].WorkSheets[1].Range['A3:'+chr(ord('C')+n)+IntToStr(i)].Borders.ColorIndex:=1;
 // ���������� ������ ��������
 XL.WorkBooks[1].WorkSheets[1].Cells[i,j]:='�-��';
 // ������������ �����, ������ �����������, ��� ����� � �.�.
 XL.WorkBooks[1].WorkSheets[1].Rows[2].Orientation:=90;
 XL.WorkBooks[1].WorkSheets[1].Range['A2:B2'].Orientation:=0;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
 cPos, i, j: integer;
 s: string;
begin
 if ComboBox1.Text='���'
 then ComboBox2.Enabled:=false
 else ComboBox2.Enabled:=true;
 ///////////////////////////////  �����������
 ComboBox2.Clear;
 ComboBox2.Text:='���';
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('���');
 ComboBox2.Items.Add('����');
 ////////////  ������
 if ComboBox1.Text='������' then
  begin
   ComboBox2.Text:='';
   ComboBox2.Items.Clear;
   cPos:=0;
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.reg;
   for i:=0 to FileSize(NoteFile)-1 do
    begin
     if s<>'' then
      begin
       ComboBox2.Text:=s;
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
  end;
 ////////////  ��������
 if ComboBox1.Text='��������' then
  begin
   ComboBox2.Text:='';
   ComboBox2.Items.Clear;
   cPos:=0;
   Seek(NoteFile,cPos);
   Read(NoteFile,NoteData); // ������ ������
   s:=NoteData.meneg;
   for i:=0 to FileSize(NoteFile)-1 do
    begin
     if s<>'' then
      begin
       ComboBox2.Text:=s;
       ComboBox2.Items.Add(s);
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
  end;
////////////////////////////////////////////////////////////////
 ComboBox2.Sorted:=true;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
 i,j,r,c: integer;
 WorkBk: _WorkBook;      //  ���������� WorkBook
 WorkSheet: _WorkSheet;  //  ���������� WorkSheet
 iIndex: OleVariant;
 TabGrid: Variant;
begin
 iIndex:=1;
 r:=StringGrid1.RowCount; // ���-�� �����
 c:=StringGrid1.ColCount; // ���-�� ��������
 // ������ ������-�������
 TabGrid:=VarArrayCreate([0,(r-1),0,(c-1)],VarOleStr);
 i:=0;
 // ���������� ���� ��� ���������� �������-�������
 repeat
  for j:=0 to (c-1) do     // ���������� TabGrid �� StringGrid1
   TabGrid[i,j]:=StringGrid1.Cells[j+1,i];
   inc(i,1);
 until i>(r-1);
 // ����������� � �������� TExcelApplication
 XLApp.Connect;
 // ��������� WorkBooks � ExcelApplication
 XLApp.WorkBooks.Add(xlWBatWorkSheet,0); // �� �������� � XP !!!
 // �������� ������ WorkBook
 WorkBk:=XLApp.WorkBooks.Item[iIndex];
 // ���������� ������ WorkSheet
 WorkSheet:=WorkBk.WorkSheets.Get_Item(1) as _WorkSheet;
 // ������������ Delphi ������-������� � �������� � WorkSheet
 // Worksheet.Range['A1',Worksheet.Cells.Item[r,c]].Value:=TabGrid;
 // ��������� �������� WorkSheet
 WorkSheet.Name:='�����';
 // ����������� (������� ����� ����������� ������ '.')
 WorkSheet.PageSetup.HeaderMargin:=XLApp.CentimetersToPoints(0.5);
 WorkSheet.PageSetup.RightHeader:='�������� &[��������] �� &[�������] - &[����]';
 // ���������� ��������: ������� (xlPortrait(:=1)) ���� ���������
 Worksheet.PageSetup.Orientation:=xlLandscape; // ��������� (:=2)
 Worksheet.Columns.WrapText:=true; // ���������� �� ������
 Worksheet.Columns.AutoFit; // ����������
 Worksheet.Columns.HorizontalAlignment:=xlRight;
 Worksheet.Columns.VerticalAlignment:=xlCenter;
 WorkSheet.Columns.ColumnWidth:=12;
 WorkSheet.Columns.Font.Size:=8;
 // ����������  (xlDouble,...)
 WorkSheet.Columns.Borders.LineStyle:=xlContinuous;
 // ������ ������ ������
 WorkSheet.Range['A'+IntToStr(1),'A'+IntToStr(R)].ColumnWidth:=6;
 // ������ ������ 1-�� �������
 Worksheet.Range['A'+IntToStr(1),'M'+IntToStr(1)].Font.Size:=10;
 // ������������ ������� �������
 WorkSheet.Range['A'+IntToStr(1),'A'+IntToStr(R)].HorizontalAlignment:=xlHAlignLeft;
 // ������������ ������ ������
 Worksheet.Range['A'+IntToStr(1),'M'+IntToStr(1)].HorizontalAlignment:=xlCenter;
 // ���������� Excel
 XLApp.Visible[0]:=true;
 XLApp.ScreenUpdating[0]:=true;
 // ��������� ����� � ��������
 XLApp.Disconnect;
 // Unassign the Delphi Variant Matrix
 TabGrid:=Unassigned;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
 i,j,r,c: integer;
 Excel,WorkBook,Sheet,TabGrid: Variant;
 iIndex: OleVariant;
 s: string;
 f: textfile;
begin
 AssignFile(f,ExtractFilePath(Application.ExeName)+'\data\firm_name.txt');
 if FileExists(ExtractFilePath(Application.ExeName)+'\data\firm_name.txt')
 then
  begin
   Reset(f);
   Read(f,s);
  end
 else
  begin
   s:='������������ �����������';
   Rewrite(f);
   Write(f,s);   
  end;
 CloseFile(f);
 //
 s:=InputBox('������������ ����� �����������','������� ������������:',s);
 if s='' then
  begin
   MessageDlg('��� �������� ������ � Excel ��������� ������ �������� ����� �����������!',mtInformation,[mbOK],0);
   Exit;
  end;
 //
 AssignFile(f,ExtractFilePath(Application.ExeName)+'\data\firm_name.txt');
 Rewrite(f);
 Write(f,s);
 CloseFile(f);
 // '������������ ����� �����������:'
 //
 iIndex:=1;
 r:=StringGrid1.RowCount; // ���-�� �����
 c:=StringGrid1.ColCount; // ���-�� ��������
 // ������ ������-�������
 TabGrid:=VarArrayCreate([0,(r-1),0,(c-1)],VarOleStr);
 i:=0;
 // ���������� ���� ��� ���������� �������-�������
 repeat
  for j:=0 to (c-1) do     // ���������� TabGrid �� StringGrid1
   TabGrid[i,j]:=StringGrid1.Cells[j+1,i];
   inc(i,1);
 until i>(r-1);
 // ��������� Excel
 try
  Excel:=CreateOleObject('Excel.Application'); // ��� ���������
 except
  Excel:=CreateOleObject('Excel.Application.10'); // ��� Office XP
 end;
 Excel.SheetsInNewWorkbook:=1;
 WorkBook:=Excel.WorkBooks.Add;
 Sheet:=WorkBook.WorkSheets[1];
 Sheet.Name:='���� ���������� - �����';
 Sheet.Range['A6',Sheet.Cells.Item[r+5,c-1]].Value:=TabGrid;
 // ���������� ��������: ������� (xlPortrait ��� :=1)
 Sheet.PageSetup.CenterHorizontally:=true;
 Sheet.PageSetup.Orientation:=xlLandscape; // ��������� (��� :=2)
 // ���� (������� ����� ����������� ������ '.')
 Sheet.PageSetup.LeftMargin:=Excel.CentimetersToPoints(1);
 Sheet.PageSetup.RightMargin:=Excel.CentimetersToPoints(1);
 Sheet.PageSetup.TopMargin:=Excel.CentimetersToPoints(1);
 Sheet.PageSetup.BottomMargin:=Excel.CentimetersToPoints(1);
 // ����������� (������� ����� ����������� ������ '.')
 Sheet.PageSetup.HeaderMargin:=Excel.CentimetersToPoints(0.5);
 // &�, &�, &� - ��������, ����� (�����), ���� (dd,mm,yy)
 // ������ ��� �������� MS-Office; ��� English - &P, &N, &D
 Sheet.PageSetup.RightHeader:='�������� &� �� &� - &�';
 // �������� �������
 Sheet.Columns.WrapText:=true; // ���������� �� ������
 Sheet.Cells.Columns.AutoFit;  // ���������� �����
 Sheet.Range['A'+IntToStr(6),'J'+IntToStr(6)].RowHeight:=28;
 Sheet.Columns.HorizontalAlignment:=xlLeft;
 Sheet.Columns.VerticalAlignment:=xlCenter;
 Sheet.Columns.ColumnWidth:=12;
 Sheet.Columns.Font.Size:=8;
 // ����� ��� �������� ([3,4] - ������, �������)
 Sheet.Cells[3,4]:=s+' - ���� ���������� �� '+DateToStr(Date);
 Sheet.Range['A3','J3'].HorizontalAlignment:=xlHAlignCenter;
 Sheet.Range['A3','J3'].Font.Name:='Times New Roman';
 Sheet.Range['A3','J3'].Font.Bold:=true;
 Sheet.Range['A3','J3'].Font.Size:=14;
 Sheet.Range['A3','J3'].Columns.WrapText:=false;
 // ���������� ����� (xlDouble,...)
 Sheet.Range['A'+IntToStr(6),'J'+IntToStr(r+5)].Columns.Borders.LineStyle:=xlContinuous;
 // ������ ��������
 Sheet.Range['A'+IntToStr(6),'A'+IntToStr(r+5)].ColumnWidth:=6;
 Sheet.Range['B'+IntToStr(6),'B'+IntToStr(r+5)].ColumnWidth:=24;
 Sheet.Range['C'+IntToStr(6),'C'+IntToStr(r+5)].ColumnWidth:=22;
 Sheet.Range['D'+IntToStr(6),'D'+IntToStr(r+5)].ColumnWidth:=14;
 Sheet.Range['E'+IntToStr(6),'E'+IntToStr(r+5)].ColumnWidth:=12;
 Sheet.Range['F'+IntToStr(6),'F'+IntToStr(r+5)].ColumnWidth:=12;
 Sheet.Range['G'+IntToStr(6),'G'+IntToStr(r+5)].ColumnWidth:=8;
 Sheet.Range['H'+IntToStr(6),'H'+IntToStr(r+5)].ColumnWidth:=12;
 Sheet.Range['I'+IntToStr(6),'I'+IntToStr(r+5)].ColumnWidth:=12;
 Sheet.Range['J'+IntToStr(6),'J'+IntToStr(r+5)].ColumnWidth:=12;
 // ������ ������ 6-�� �������
 Sheet.Range['A'+IntToStr(6),'J'+IntToStr(6)].Font.Size:=10;
 // ������������ ������� �������
 Sheet.Range['A'+IntToStr(6),'A'+IntToStr(r+5)].HorizontalAlignment:=xlHAlignCenter;
 Sheet.Range['A'+IntToStr(6),'A'+IntToStr(r+5)].Font.Bold:=true;
 // ������������ ������ ������
 Sheet.Range['A'+IntToStr(6),'J'+IntToStr(6)].HorizontalAlignment:=xlCenter;
 Sheet.Range['A'+IntToStr(6),'J'+IntToStr(6)].Font.Bold:=true;
 // ���������� Excel
 Excel.Visible:=True;
 Excel.ScreenUpdating:=true;
 // Unassign the Delphi Variant Matrix
 Excel:=Unassigned;
 WorkBook:=Unassigned;
 Sheet:=Unassigned;
 TabGrid:=Unassigned;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
 StringGrid1.ShowHint:=false;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
var
 i,j:integer;
begin
 StringGrid1.ShowHint:=true;
 j:=StringGrid1.Row;
 StringGrid1.Hint:=StringGrid1.Cells[1,j];
 for i:=2 to StringGrid1.ColCount-1 do
  StringGrid1.Hint:=StringGrid1.Hint+' - '+StringGrid1.Cells[i,j];
end;

end.
