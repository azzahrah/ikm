program IKM;

uses
  System.StartUpCopy,
  FMX.Forms,
  Umain in 'Umain.pas' {FormMain},
  UDM in 'UDM.pas' {DM: TDataModule},
  UPolling in 'UPolling.pas' {FormPolling},
  USetting in 'USetting.pas' {FormSetting},
  UThanks in 'UThanks.pas' {FormThanks};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormPolling, FormPolling);
  Application.CreateForm(TFormSetting, FormSetting);
  Application.Run;
end.
