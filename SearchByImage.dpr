program SearchByImage;

uses
  Vcl.Forms,
  sfrmMain in 'sfrmMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
