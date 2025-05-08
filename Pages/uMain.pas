unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.Layouts, uDashboard, FMX.Objects, FMX.TabControl, FMX.Effects,
  FMX.Filter.Effects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Skia, FMX.Skia;

type
  TfrmMain = class(TForm)
    lytContent: TLayout;
    lytSidebar: TLayout;
    mvSidebar: TMultiView;
    sbSettings: TSpeedButton;
    sbMenu: TSpeedButton;
    sbContracts: TSpeedButton;
    sbDashboard: TSpeedButton;
    sbClients: TSpeedButton;
    TabControl1: TTabControl;
    tiDashboard: TTabItem;
    tiClients: TTabItem;
    tiContracts: TTabItem;
    lytHeader: TLayout;
    lbTitle: TLabel;
    btnTrigger: TCornerButton;
    fDashboard1: TfDashboard;
    cbtnViewAllContracts: TCornerButton;
    procedure mvSidebarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uDm;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  mvSidebar.ShowMaster;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  Self.Caption := 'Main Form' + ' Height: ' + Self.Height.ToString + ' Width: ' + Self.Width.ToString;
end;

procedure TfrmMain.mvSidebarResize(Sender: TObject);
begin
  lytSidebar.Width := mvSidebar.Width;
end;

end.
