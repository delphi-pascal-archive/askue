program vmaker;

uses
  Forms,
  vmm in 'vmm.pas' {VMF};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'VMaker // EXE';
  Application.CreateForm(TVMF, VMF);
  Application.Run;
end.
