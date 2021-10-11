//<?xml version="1.0" encoding="windows-1251"?>
//<package class="52005" version="1" sender_code="" sender_name="" created=""></package>

unit vmm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ComObj,Xmlxform, msxmldom, XMLDoc,XMLINTF, xmldom,dateutils,StrUtils,
  ExtCtrls, Menus,inifiles,clipbrd, Buttons;

type
  TVMF = class(TForm)
    sdate: TDateTimePicker;
    Button1: TButton;
    od: TOpenDialog;
    pc: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FPP: TListBox;
    hourd: TListBox;
    newd: TEdit;
    Label2: TLabel;
    Button3: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Panel1: TPanel;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    TabSheet3: TTabSheet;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Button4: TButton;
    log: TListBox;
    Button5: TButton;
    sb: TStatusBar;
    dayauto: TCheckBox;
    Button6: TButton;
    Panel2: TPanel;
    Bevel2: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure logClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure sdateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VMF: TVMF;

implementation

{$R *.dfm}


procedure TVMF.Button1Click(Sender: TObject);
var AsF:TStringList;AsV,AsH:TStringList;i,n:integer;s:string;v1,v2:single;node:IXMLNODE;
xml:TXMLDocument;wa:OleVariant;nd,nh:integer;
var thedata:array[1..31,0..23] of string;
begin
if newd.Text='' then
begin
ShowMessage('Следует указать документ Plan750 ФППЭ.');
exit;
end;
button1.Enabled:=false;
screen.Cursor:=crHourGlass;
FPP.Clear;
Hourd.Clear;
for i:=1 to 31 do
for n:=0 to 23 do thedata[i][n]:='0';
if fileexists(newd.Text) then
begin
xml:=TXMLDocument.Create(vmf);
xml.LoadFromFile(newd.Text);
for i:=0 to xml.DocumentElement.ChildNodes.Count-1 do
begin
if xml.DocumentElement.ChildNodes.Nodes[i].NodeName='consumption'
then begin
s:=xml.DocumentElement.ChildNodes.Nodes[i].Attributes['date_time'];
thedata[strtoint(copy(s,7,2))][strtoint(copy(s,9,2))]:=xml.DocumentElement.ChildNodes.Nodes[i].Attributes['energy'];
end;
end;
xml.Active:=false;
xml.Free;
xml:=nil;
end;
///////// Чтение имп. файла
od.Title:='Укажите файл АСКУЭР для импорта';
od.DefaultExt:='txt';
od.Filter:='WordDocument (*.doc)|*.doc|Text Document (*.txt)|*.txt|';
od.InitialDir:=extractfiledir(application.exename);
od.FileName:=format('%d.txt',[dayof(sdate.Date)]);
if od.Execute then if fileexists(od.FileName) then
begin
///
//WordDoc
if ansilowercase(extractfileext(od.FileName))='.doc'
then begin
try
wa:=CreateOleObject('Word.Basic');
wa.FileOpen(Od.FileName);
Od.FileName:=ChangeFileExt(od.FileName,'.txt');
wa.FileSaveAs(od.FileName,2);
wa.FileClose();
wa.FileQuit;
wa:=Unassigned;
except
ShowMessage('Ошибка при преобразовании WordDoc в TextDocument');
end;
end;
///
AsF:=TStringList.Create;
AsF.LoadFromFile(od.FileName);
AsV:=TStringList.create;
AsH:=TStringList.Create;
for n := 0 to 23 do
begin
s:=Format('%.2d:30',[n]);
i:=AsF.indexof(s);
if i=-1 then
begin
showmessage(format('Неверный формат: не найдено значение: %s',[s]));
continue;
end;
AsV.Values[s]:=Trim(AsF[i+1]);
v1:=StrToFloat(Trim(AsF[i+1]));
s:=Format('%.2d:00',[n+1]);
i:=AsF.indexof(s);
if i=-1 then
begin
showmessage(format('Неверный формат: не найдено значение: %s',[s]));
continue;
end;
AsV.Values[s]:=Trim(AsF[i+1]);
v2:=StrToFloat(Trim(AsF[i+1]));
v2:=v1+v2;
AsH.Values[format('%.2d',[n])]:=format('%.3f',[v2/1000]);
TheData[dayof(sdate.Date)][n]:=format('%.3f',[v2/1000]);
end;
hourd.Items.AddStrings(ash);
FPP.Items.AddStrings(asv);
AsH.Free;
AsV.Free;
AsF.Free;
///////////////////////
if fileexists(newd.Text) then begin
copyfile(pchar(newd.Text),pchar('копия__'+newd.Text),false);
deletefile(newd.Text);
end;
xml:=TXMLDocument.Create(vmf);
xml.XML.Add('<?xml version="1.0" encoding="windows-1251"?>');
xml.XML.Add('<package class="52005" version="1" sender_code="" sender_name="" created=""></package>');
xml.Active:=true;
node:=xml.documentElement;
node.Attributes['class']:='52005';
node.Attributes['version']:='1';
node.Attributes['sender_code']:=edit1.Text;
node.Attributes['sender_name']:=edit2.Text;
node.Attributes['created']:=formatdatetime('yyyyMMddHHnnss',now);
for i:=1 to dateutils.DaysInAMonth(yearof(sdate.Date),monthof(sdate.Date)) do for n:=0 to 23
do begin
node:=xml.DocumentElement.AddChild('consumption');
node.Attributes['date_time']:=format('%.4d%.2d%.2d%.2d',[yearof(sdate.Date),
monthof(sdate.Date),i,n]);
node.Attributes['energy']:=AnsiReplaceText(thedata[i][n],',','.');
end;
xml.SaveToFile (newd.Text);
xml.Active:=false;
xml.Free;
xml:=nil;
node:=nil;
//
s:=format('z52005%s',[edit1.text])+formatdatetime('yyyyMMddHHnnss',now);
log.Items.Add('Готово! Обработаны данные за '+datetostr(sdate.Date));
log.Items.Add('Имя файла для отправки:');
log.ItemIndex:=log.Items.Add(s);
if dayauto.Checked then button2.Click;
end;

screen.Cursor:=0;
button1.Enabled:=true;
end;

procedure TVMF.Button2Click(Sender: TObject);
begin
sdate.date:=dateutils.IncDay(sdate.Date,1);
sdate.OnChange(self);
end;

procedure TVMF.Button3Click(Sender: TObject);
begin
od.Title:='Укажите XML-файл Plan750 для создания/обновления';
od.DefaultExt:='xml';
od.Filter:='Файл Plan750 XML (*.xml)|*.xml';
od.InitialDir:=extractfiledir(application.ExeName);
od.FileName:=extractfilename(newd.Text);
if od.Execute then newd.Text:=od.FileName;
end;

procedure TVMF.N4Click(Sender: TObject);
begin
close;
end;

procedure TVMF.N3Click(Sender: TObject);
begin
ShowMessage('VMaker for Plan750'#13'Автор: A.Dark'#13'Кольчугино-2007');
end;

procedure TVMF.FormClose(Sender: TObject; var Action: TCloseAction);
var ini:Tinifile;
begin
ini:=tinifile.Create(application.ExeName+'.dat');
ini.WriteString('main','plan750fpp',newd.Text);
ini.WriteString('main','acode',edit1.Text);
ini.WriteString('main','aname',edit2.Text);
ini.WriteBool('main','dayauto',dayauto.Checked);
ini.Free;
end;

procedure TVMF.FormCreate(Sender: TObject);
var ini:Tinifile;
begin
pc.ActivePageIndex:=0;
ini:=tinifile.Create(application.ExeName+'.dat');
newd.Text:=ini.ReadString('main','plan750fpp','');
edit1.Text:=ini.ReadString('main','acode','200000003080');
edit2.Text:=ini.ReadString('main','aname','ЗАО ТД ''Кольчуг-Мицар''');
dayauto.Checked:=ini.ReadBool('main','dayauto',true);
ini.Free;

end;

procedure TVMF.Button4Click(Sender: TObject);
begin
sdate.date:=dateutils.IncDay(sdate.Date,-1);
sdate.OnChange(self);
end;

procedure TVMF.logClick(Sender: TObject);
begin
if log.ItemIndex<>-1 then
begin
clipboard.Clear;
clipboard.AsText:=log.Items[log.ItemIndex];
showmessage('Скопировано в буфер обмена: '+log.Items[log.ItemIndex]);
end;
end;

procedure TVMF.Button5Click(Sender: TObject);
begin
newd.Text:=extractfilepath(application.ExeName)+formatdatetime('ФПП_yyyy_MM',sdate.Date)+'.xml';
end;

procedure TVMF.sdateChange(Sender: TObject);
begin
caption:='VMaker [ '+formatdatetime('ФПП за MMMM-месяц, ',sdate.Date)+edit2.Text+' ]';
end;

procedure TVMF.FormActivate(Sender: TObject);
begin
onactivate:=nil;
sdate.Date:=incday(now,-1);
sdate.OnChange(self);
end;

procedure TVMF.Button6Click(Sender: TObject);
begin
sdate.Date:=dateutils.StartOfTheMonth(sdate.Date);
sdate.OnChange(self);
end;

end.
