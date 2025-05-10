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
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Edit, FMX.DateTimeCtrls;

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
    eSearch: TEdit;
    SearchEditButton1: TSearchEditButton;
    rBackground: TRectangle;
    lytContainer: TLayout;
    rModalAdd: TRectangle;
    ScrollBox1: TScrollBox;
    lytTitle: TLayout;
    Label1: TLabel;
    btnClose: TButton;
    lFullname: TLabel;
    eFullname: TEdit;
    lAddress: TLabel;
    eAddress: TEdit;
    lContactDate: TLabel;
    lContactPrice: TLabel;
    eContactPrice: TEdit;
    lFirstTD: TLabel;
    dContactDate: TDateEdit;
    SpinEditButton1: TSpinEditButton;
    dFirstTD: TDateEdit;
    lSecondTD: TLabel;
    lThirdTD: TLabel;
    lytBtn: TLayout;
    dSecondTD: TDateEdit;
    dThirdTD: TDateEdit;
    btnCancel: TCornerButton;
    btnSave: TCornerButton;
    procedure mvSidebarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sbDashboardClick(Sender: TObject);
    procedure sbClientsClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uDm, uModal;

{ Cancel button }
procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  // hide the visibility of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;
end;

{ Close modal button }
procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  // visibility show of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;
end;s

{ Form Close }
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

{ Form Create }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // default Show
  mvSidebar.ShowMaster;

  // default hide the visibility of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;

  // default tab index
  tcController.TabIndex := 0;
  fDashboard1.Visible := true;

  // hide other components
  fClients1.Visible := false;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  { Remove code below after the application is completed }
  Self.Caption := 'Main Form' + ' Height: ' + Self.Height.ToString + ' Width: ' + Self.Width.ToString;
end;

procedure TfrmMain.mvSidebarResize(Sender: TObject);
begin
  lytSidebar.Width := mvSidebar.Width;
end;

{ Show Tab for clients }
procedure TfrmMain.sbClientsClick(Sender: TObject);
begin
  tcController.TabIndex := 1;
  fClients1.Visible := true;

  // hide other components
  fDashboard1.Visible := false;
end;

{ Show Tab for dashbaord }
procedure TfrmMain.sbDashboardClick(Sender: TObject);
begin
  tcController.TabIndex := 0;
  fDashboard1.Visible := true;

  // hide other components
  fClients1.Visible := false;
end;

end.
