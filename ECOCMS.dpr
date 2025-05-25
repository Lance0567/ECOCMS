program ECOCMS;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  FMX.Skia,
  uMain in 'Pages\uMain.pas' {frmMain},
  uDm in 'Data module\uDm.pas' {dm: TDataModule},
  uDashboard in 'Frames\uDashboard.pas' {fDashboard: TFrame},
  uContracts in 'Frames\uContracts.pas' {fContracts: TFrame},
  uClients in 'Frames\uClients.pas' {fClients: TFrame},
  uCreateContract in 'Modals\uCreateContract.pas' {fCreateContract: TFrame},
  uCompile in 'Globals\uCompile.pas',
  uPDFCreation in 'Modals\uPDFCreation.pas' {fPDFCreation: TFrame},
  uPDFViewer in 'Pages\uPDFViewer.pas' {frmPDFViewer};

{$R *.res}

begin
  GlobalUseSkia := True;
  GlobalUseMetal := True;
  GlobalUseVulkan := True;
  GlobalUseSkiaRasterWhenAvailable := False;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPDFViewer, frmPDFViewer);
  Application.Run;
end.
