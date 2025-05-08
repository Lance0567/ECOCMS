unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.Layouts, uDashboard, FMX.Objects, FMX.TabControl, FMX.Effects,
  FMX.Filter.Effects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Skia, FMX.Skia, uClients,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

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
    tcController: TTabControl;
    tiDashboard: TTabItem;
    tiClients: TTabItem;
    tiContracts: TTabItem;
    fDashboard1: TfDashboard;
    fClients1: TfClients;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure mvSidebarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sbDashboardClick(Sender: TObject);
    procedure sbClientsClick(Sender: TObject);
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
  fDashboard1.Visible := true;

  // default tab index
  tcController.TabIndex := 0;
  fDashboard1.Visible := true;

  // hide other components
  fClients1.Visible := false;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  Self.Caption := 'Main Form' + ' Height: ' + Self.Height.ToString + ' Width: ' + Self.Width.ToString;
end;

procedure TfrmMain.mvSidebarResize(Sender: TObject);
begin
  lytSidebar.Width := mvSidebar.Width;
end;

{Show Tab for clients}
procedure TfrmMain.sbClientsClick(Sender: TObject);
begin
  tcController.TabIndex := 1;
  fClients1.Visible := true;

  // hide other components
  fDashboard1.Visible := false;
end;

{Show Tab for dashbaord}
procedure TfrmMain.sbDashboardClick(Sender: TObject);
begin
  tcController.TabIndex := 0;
  fDashboard1.Visible := true;

  // hide other components
  fClients1.Visible := false;
end;

end.
