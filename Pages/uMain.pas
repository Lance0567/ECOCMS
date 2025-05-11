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
    procedure btnSaveClick(Sender: TObject);
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

procedure ClearItems;
begin
  frmMain.eFullname.Text.Empty;
  frmMain.eAddress.Text.Empty;
  frmMain.eContactPrice.Text.Empty;
  frmMain.dContactDate.Date := now;
  frmMain.dFirstTD.Date := now;
  frmMain.dSecondTD.Date := now;
  frmMain.dThirdTD.Date := now;
end;

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
  // visibility hide of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;

  // Close query
  dm.qClients.Close;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  dm.qClients.Append;

  // fields to save
  dm.qClients.FieldByName('name').AsString := eFullname.Text;
  dm.qClients.FieldByName('address').AsString := eAddress.Text;
  dm.qClients.FieldByName('contract_price').AsFloat := StrToFloat(eContactPrice.Text);
  dm.qClients.FieldByName('contract_date').AsDateTime := dContactDate.Date;
  dm.qClients.FieldByName('first_treatment').AsDateTime := dFirstTD.Date;
  dm.qClients.FieldByName('second_treatment').AsDateTime := dSecondTD.Date;
  dm.qClients.FieldByName('third_treatment').AsDateTime := dThirdTD.Date;

  dm.qClients.Post;
  dm.qClients.Refresh;

  // visibility hide of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;

  // Clear items from the modal
  ClearItems;
end;

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
  fClients1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar
end;

{ Show Tab for dashbaord }
procedure TfrmMain.sbDashboardClick(Sender: TObject);
begin
  tcController.TabIndex := 0;
  fDashboard1.Visible := true;

  // hide other components
  fClients1.Visible := false;
  fDashboard1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar
end;

end.
