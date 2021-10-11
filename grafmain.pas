unit grafmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellApi, ComObj, OleServer,  Xmlxform, msxmldom, XMLDoc,XMLINTF, xmldom,
  ComCtrls,StrUtils, Menus,DateUtils,inifiles, ExtCtrls;

type
  TFPGForm = class(TForm)
    pc: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    grbut: TButton;
    plan: TMemo;
    ListBox1: TListBox;
    Button2: TButton;
    sdate: TDateTimePicker;
    Button1: TButton;
    Button3: TButton;
    xmlplan: TEdit;
    Button4: TButton;
    Button5: TButton;
    aprint: TCheckBox;
    od: TOpenDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Label10: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    Label11: TLabel;
    Edit21: TEdit;
    Edit22: TEdit;
    Label12: TLabel;
    Edit23: TEdit;
    Edit24: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    intel: TCheckBox;
    notfull: TCheckBox;
    procedure grbutClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure planKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure planChange(Sender: TObject);
    procedure xmlplanChange(Sender: TObject);
    procedure sdateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPGForm: TFPGForm;

implementation

{$R *.dfm}

procedure TFPGForm.grbutClick(Sender: TObject);
var AsF:TStringList;AsV,AsH:TStringList;i,n:integer;fname,s:string;v1,v2:single;
fil:TextFile;wa:OleVariant;pik:tstringlist;filefound,isgood:boolean;
const mongth:array [1..12] of string=('января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря');
const day:array [1..7] of string=('воскресенье','понедельник','вторник','среду','четверг','пятницу','субботу');
begin
isgood:=false;
if plan.Lines.Count<>24 then begin
ShowMessage('Следует проверить плановые значения.');
exit;
end;
///////// Чтение имп. файла
FileFound:=false;
Fname:=extractfilepath(application.ExeName)+format('%d.txt',[dayof(sdate.Date)]);
if intel.Checked then begin
FileFound:=FileExists(Fname);
if not FileFound then
begin
FName:=extractfilepath(application.ExeName)+format('%d.doc',[dayof(sdate.Date)]);
FileFound:=FileExists(Fname);
end;
end;
if not FileFound then
begin
od.Title:='Укажите файл АСКУЭР для импорта';
od.DefaultExt:='doc';
od.Filter:='WordDocument (*.doc)|*.doc|TextDocument|*.txt';
od.FileName:=format('%d.doc',[dayof(sdate.Date)]);
od.InitialDir:=extractfiledir(application.ExeName);
Filefound:=(od.Execute) and (FileExists(od.FileName));
if FileFound then FName:=Od.FileName;
end;
if FileFound
then
begin
//WordDoc
if ansilowercase(extractfileext(FName))='.doc'
then begin
try
wa:=CreateOleObject('Word.Basic');
wa.FileOpen(FName);
FName:=ChangeFileExt(FName,'.txt');
wa.FileSaveAs(FName,2);
wa.FileClose();
wa.FileQuit;
wa:=Unassigned;
except
ShowMessage('Ошибка при преобразовании WordDoc в TextDocument');
end;
end;

AssignFile(fil,extractfilepath(application.ExeName)+'data.txt');
ReWrite(Fil);
for i:=1 to 24 do write(fil,format('%d',[i])+#$9);
write(fil,#13#10);
AsF:=TStringList.Create;
AsF.LoadFromFile(FName);
AsV:=TStringList.create;
AsH:=TStringList.Create;
for n := 0 to 23 do
begin
s:=Format('%.2d:30',[n]);
i:=AsF.indexof(s);
if i=-1 then
begin
if not ((notfull.Checked) and (isgood))
then
begin
if isgood then
showmessage(format('Неверный формат: не найдено значение: %s'+#13+'Возможно, день еще не закончился?',[s]))
else
showmessage(format('Неверный формат: не найдено значение: %s'+#13+'Возможно, текстовый файл имеет неверный формат?',[s]));
end;
continue;
end;
AsV.Values[s]:=Trim(AsF[i+1]);
v1:=StrToFloat(Trim(AsF[i+1]));
s:=Format('%.2d:00',[n+1]);
i:=AsF.indexof(s);
if i=-1 then
begin
if not ((notfull.Checked) and (isgood)) then
begin
if isgood then
showmessage(format('Неверный формат: не найдено значение: %s'+#13+'Возможно, день еще не закончился?',[s]))
else
showmessage(format('Неверный формат: не найдено значение: %s'+#13+'Возможно, текстовый файл имеет неверный формат?',[s]));
end;

continue;
end;
AsV.Values[s]:=Trim(AsF[i+1]);
v2:=StrToFloat(Trim(AsF[i+1]));
v2:=v1+v2;
AsH.Values[format('%.2d',[n])]:=format('%.3f',[v2/1000]);
write(fil,format('%.3f',[v2/1000])+#$9);
isgood:=true;
end;
AsH.Free;
AsV.Free;
AsF.Free;
write(fil,#13#10);
for i:=0 to 23 do write(fil,plan.lines[i]+#$9);
write(fil,#13#10);
write(fil,format('График почасовых мощностей за %s, ',[day[dayofweek(sdate.Date)]])+formatdatetime('dd ',sdate.DateTime)+mongth[monthof(sdate.datetime)]+formatdatetime(' yyyy г.',sdate.date)+#$9);
write(fil,'ФПП'+#$9);
write(fil,'ДПП'+#$9);
write(fil,'ПИК'+#$9);
write(fil,'ЛИМ'+#$9+#13#10);
//часы пик здесь
pik:=tstringlist.Create;
pik.Delimiter:=',';
pik.DelimitedText:=TEdit(Fpgform.FindComponent('Edit'+inttostr(monthof(sdate.Date)*2))).Text;
for i:=1 to 24
 do
begin
if pik.IndexOf(inttostr(i))<>-1 then
write(fil,0,#$9)
else write(fil,''+#$9)
end;
pik.Free;
write(fil,#13#10);
for i:=1 to 24
 do
write(fil,
TEdit(Fpgform.FindComponent('Edit'+inttostr(monthof(sdate.Date)+(monthof(sdate.Date)-1)))).Text,#$9);
CloseFile(fil);
deletefile(extractfilepath(application.exename)+'data.xls');
wa:=CreateOleObject('Excel.Application');
wa.visible:=true;
wa.Workbooks.Open(FileName:=extractfilepath(application.exename)+'data.txt',Format:=1);
wa.ActiveWorkBook.SaveAs(FileName:=extractfilepath(application.exename)+'data.xls',FileFormat:=1);
wa.Workbooks.Close;
//wa.Quit;
wa := Unassigned;
if not aprint.Checked then
ShellExecute(handle,'open',pchar(extractfilepath(application.exename)+'autograf.xls'),pchar(extractfiledir(application.ExeName)),'',0)
else ShellExecute(handle,'print',pchar(extractfilepath(application.exename)+'autograf.xls'),pchar(extractfiledir(application.ExeName)),'',0)
end;
end;

procedure TFPGForm.Button2Click(Sender: TObject);
var xml:TXMLDocument;i,cnt:integer;s:string;okm,okd:string;
DAT:array[0..23]of string;
begin
button2.Caption:='Ждем...';
button2.Enabled:=false;
plan.Lines.Clear;
cnt:=0;
for i:=0 to 23 do dat[i]:='';
okm:=formatdatetime('MM',sdate.Date);
okd:=formatdatetime('dd',sdate.Date);
xml:=TXMLDocument.Create(FPGForm);
xml.LoadFromFile(xmlplan.Text);
xml.Active:=true;
for i:=0 to xml.DocumentElement.ChildNodes.Count-1 do
begin
if xml.DocumentElement.ChildNodes.Nodes[i].NodeName='consumption'
then begin
s:=xml.DocumentElement.ChildNodes.Nodes[i].Attributes['date_time'];
if copy(s,5,2)=okm then if copy(s,7,2)=okd
then begin
dat[strtoint(copy(s,9,2))]:=AnsiReplaceText(xml.DocumentElement.ChildNodes.Nodes[i].Attributes['energy'],'.',',');
inc(cnt,1);
if cnt=24 then
begin
break;
end;
end;
end;
end;
for i:=0 to 23 do plan.Lines.Add(dat[i]);
xml.Active:=false;
xml.Free;
button2.Caption:='Считать ДПП';
button2.Enabled:=true;
end;

procedure TFPGForm.Button1Click(Sender: TObject);
begin
button2.Click;
grbut.Click;
end;

procedure TFPGForm.N4Click(Sender: TObject);
begin
ShowMessage('FactPlanGraf'#13'Автор: A.Dark'#13'Кольчугино-2007');
end;

procedure TFPGForm.N2Click(Sender: TObject);
begin
Close;
end;

procedure TFPGForm.planKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var p:TPoint;
  begin
if key=vk_return then
if plan.CaretPos.Y<23 then
begin
if plan.Lines.Count-1=plan.CaretPos.Y then
plan.Lines.Append('') else
begin
p:=plan.CaretPos;
p.Y:=p.Y+1;
plan.CaretPos:=p;
end;
end;
end;

procedure TFPGForm.Button3Click(Sender: TObject);
begin
sdate.Date:=incday(sdate.Date);
sdate.OnChange(self);
end;

procedure TFPGForm.Button4Click(Sender: TObject);
begin
od.Title:='Укажите XML-файл Plan750 ДПП';
od.DefaultExt:='xml';
od.Filter:='Plan750 XML (*.xml)|*.xml';
od.FileName:=extractfilename(xmlplan.Text);
od.InitialDir:=extractfiledir(od.FileName);
if od.Execute then xmlplan.Text:=od.FileName;
end;

procedure TFPGForm.FormClose(Sender: TObject; var Action: TCloseAction);
var ini:Tinifile; i:integer;
begin
ini:=TIniFile.Create(application.ExeName+'.dat');
ini.WriteString('main','plan750xmlfile',xmlplan.Text);
ini.WriteBool('main','autoprint',aprint.Checked);
ini.WriteBool('main','intelinside',intel.Checked);
ini.WriteBool('main','optimist',notfull.Checked);
for i:=1 to 24 do
ini.WriteString('main','Edit1'+inttostr(i),TEdit(Fpgform.FindComponent('Edit'+inttostr(i))).Text);
ini.Free;
end;

procedure TFPGForm.FormActivate(Sender: TObject);
var ini:Tinifile;i:integer;
begin
onactivate:=nil;
pc.ActivePageIndex:=0;
ini:=TIniFile.Create(application.ExeName+'.dat');
xmlplan.Text:=ini.ReadString('main','plan750xmlfile','');
aprint.Checked:=ini.ReadBool('main','autoprint',false);
intel.Checked:=ini.ReadBool('main','intelinside',true);
notfull.Checked:=ini.ReadBool('main','optimist',false);
for i:=1 to 24 do
TEdit(Fpgform.FindComponent('Edit'+inttostr(i))).Text:=
ini.ReadString('main','Edit1'+inttostr(i),'');

ini.Free;
sdate.Date:=incday(now,-1);
Sdate.OnChange(self);
end;

procedure TFPGForm.Button5Click(Sender: TObject);
begin
sdate.Date:=incday(sdate.Date,-1);
sdate.OnChange(self);
end;

procedure TFPGForm.planChange(Sender: TObject);
begin
grbut.Enabled:=plan.Lines.Count=24;
end;

procedure TFPGForm.xmlplanChange(Sender: TObject);
begin
button2.Enabled:=FileExists(xmlplan.Text);
end;

procedure TFPGForm.sdateChange(Sender: TObject);
begin
caption:='FactPlanGraf '+formatdatetime(' [ГПМ за dddd, dddddd]',sdate.DateTime);
end;

end.
