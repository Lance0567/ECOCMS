unit uDashboard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Skia, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.ImgList, Math;

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
    lbTotalContractsC: TLabel;
    rCard2: TRectangle;
    lytCardD2: TLayout;
    lbActiveClients: TLabel;
    lbActiveClientsC: TLabel;
    rCard3: TRectangle;
    lytCardD3: TLayout;
    lbFullyPaid: TLabel;
    lbFullyPaidC: TLabel;
    rCard4: TRectangle;
    lytCardD4: TLayout;
    lbNotYetPaid: TLabel;
    lbNotYetPaidC: TLabel;
    cbtnViewAllContracts: TCornerButton;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    Glyph3: TGlyph;
    Glyph4: TGlyph;
    lytHeader: TLayout;
    lbTitle: TLabel;
    btnTrigger: TCornerButton;
    procedure FrameResize(Sender: TObject);
    procedure glytCardsResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uMain, uDm;

procedure TfDashboard.FrameResize(Sender: TObject);
begin
  // Cards responsive
  if frmMain.ClientWidth >= 1300 then
  begin
    glytCards.Height := 170;
    glytCards.ItemWidth := 280;
  end
  else if frmMain.ClientWidth <= 800 then
  begin
    glytCards.Height := 610;
  end
  else
  begin
    glytCards.Height := 321;
    glytCards.ItemWidth := 270;
  end;
end;

procedure TfDashboard.glytCardsResize(Sender: TObject);
var
  AvailableWidth, ItemsPerRow: Integer;
begin
  AvailableWidth := Trunc(glytCards.Width);
  ItemsPerRow := Max(1, AvailableWidth div 280); // 270 + 10 margin
  glytCards.ItemWidth := Trunc((AvailableWidth - (ItemsPerRow + 1) * 10) / ItemsPerRow);
end;

end.
