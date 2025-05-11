program ECOCMS;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'Pages\uMain.pas' {frmMain},
  uDm in 'Data module\uDm.pas' {dm: TDataModule},
  uDashboard in 'Frames\uDashboard.pas' {fDashboard: TFrame},
  uContracts in 'Frames\uContracts.pas' {fContracts: TFrame},
  uClients in 'Frames\uClients.pas' {fClients: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
