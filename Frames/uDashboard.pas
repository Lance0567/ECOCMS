unit uDashboard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Skia, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation;

type
  TfDashboard = class(TFrame)
    ScrollBox1: TScrollBox;
    lytBottom: TLayout;
    rRecentContracts: TRectangle;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    ListView1: TListView;
    glytCards: TGridLayout;
    rCard1: TRectangle;
    lytCardD1: TLayout;
    lbTotalContracts: TLabel;
    Image1: TImage;
    lbTotalContractsC: TLabel;
    rCard2: TRectangle;
    Layout1: TLayout;
    lbActiveClients: TLabel;
    Image2: TImage;
    lbActiveClientsC: TLabel;
    rCard3: TRectangle;
    Layout3: TLayout;
    lbFullyPaid: TLabel;
    Image3: TImage;
    lbFullyPaidC: TLabel;
    rCard4: TRectangle;
    Layout4: TLayout;
    lbNotYetPaid: TLabel;
    Image4: TImage;
    lbNotYetPaidC: TLabel;
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uMain;

procedure TfDashboard.FrameResize(Sender: TObject);
begin
  // Cards responsive
  if frmMain.ClientWidth >= 1300 then
  begin
    glytCards.Height := 170;
    glytCards.ItemWidth := 272;
  end
  else
  begin
    glytCards.Height := 321;
    glytCards.ItemWidth := 262;
  end;
end;

end.
