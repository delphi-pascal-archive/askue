program grafmaker;

uses
  Forms,
  grafmain in 'grafmain.pas' {FPGForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FactPlanGraf // EXE';
  Application.CreateForm(TFPGForm, FPGForm);
  Application.Run;
end.
