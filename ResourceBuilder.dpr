program ResourceBuilder;

uses
  Vcl.Forms,
  du_Mainu in 'du_Mainu.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
