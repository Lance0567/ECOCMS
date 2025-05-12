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
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Edit, FMX.DateTimeCtrls, uContracts,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

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
    LinkGridToDSBDBClient: TLinkGridToDataSource;
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
    lContractDate: TLabel;
    lContractPrice: TLabel;
    eContractPrice: TEdit;
    lFirstTD: TLabel;
    dContractDate: TDateEdit;
    SpinEditButton1: TSpinEditButton;
    dFirstTD: TDateEdit;
    lSecondTD: TLabel;
    lThirdTD: TLabel;
    lytBtn: TLayout;
    dSecondTD: TDateEdit;
    dThirdTD: TDateEdit;
    btnCancel: TCornerButton;
    btnSave: TCornerButton;
    BindSourceDB2: TBindSourceDB;
    LinkPropertyToFieldText: TLinkPropertyToField;
    lFullnameR: TLabel;
    lytFullnameC: TLayout;
    lytAddressC: TLayout;
    lAddressR: TLabel;
    lContractPriceR: TLabel;
    lytContractPriceC: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    fContracts1: TfContracts;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDSBDBContracts: TLinkGridToDataSource;
    procedure mvSidebarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sbDashboardClick(Sender: TObject);
    procedure sbClientsClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure fClients1btnTriggerClick(Sender: TObject);
    procedure ClearItems;
    procedure HideComponents;
    procedure AdjustLayoutHeight(ALayout: TLayout; AHeight: Single);
    procedure sbContractsClick(Sender: TObject);
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

procedure TfrmMain.HideComponents;
begin
  // from add client modal
  lFullnameR.Visible := False;
  lAddressR.Visible := False;
  lContractPriceR.Visible := False;
end;

{ Adjust Layout height for modal required fields }
procedure TfrmMain.AdjustLayoutHeight(ALayout: TLayout; AHeight: Single);
begin
  if Assigned(ALayout) then
  begin
    ALayout.Height := AHeight;
  end;
end;

procedure TfrmMain.ClearItems;
begin
  frmMain.eFullname.Text := '';
  frmMain.eAddress.Text := '';
  frmMain.eContractPrice.Text := '';
  frmMain.dContractDate.Date := now;
  frmMain.dFirstTD.Date := now;
  frmMain.dSecondTD.Date := now;
  frmMain.dThirdTD.Date := now;

  // Labels color
  lFullname.TextSettings.FontColor := TAlphaColors.Black;
  lAddress.TextSettings.FontColor := TAlphaColors.Black;
  lContractPrice.TextSettings.FontColor := TAlphaColors.Black;

  // Layout height
  AdjustLayoutHeight(lytFullnameC, 75);
  AdjustLayoutHeight(lytAddressC, 75);
  AdjustLayoutHeight(lytContractPriceC, 75);
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
end;

{ Save button }
procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  HasError: Boolean;
  FirstInvalidPos: Single;
begin
  HasError := False;
  FirstInvalidPos := -1;

  // Full Name validation
  if eFullname.Text = '' then
  begin
    rModalAdd.Tag := 1;
    AdjustLayoutHeight(lytFullnameC, 95);
    lFullnameR.Visible := True;
    lFullname.TextSettings.FontColor := TAlphaColors.Red;
    if FirstInvalidPos = -1 then
      FirstInvalidPos := eFullname.Position.Y;
    HasError := True;
  end
  else
  begin
    AdjustLayoutHeight(lytFullnameC, 75);
    lFullnameR.Visible := False;
    lFullname.TextSettings.FontColor := TAlphaColors.Black;
  end;

  // Address validation
  if eAddress.Text = '' then
  begin
    rModalAdd.Tag := 1;
    AdjustLayoutHeight(lytAddressC, 95);
    lAddressR.Visible := True;
    lAddress.TextSettings.FontColor := TAlphaColors.Red;
    if FirstInvalidPos = -1 then
      FirstInvalidPos := eAddress.Position.Y;
    HasError := True;
  end
  else
  begin
    AdjustLayoutHeight(lytAddressC, 75);
    lAddressR.Visible := False;
    lAddress.TextSettings.FontColor := TAlphaColors.Black;
  end;

  // Contract Price validation
  if eContractPrice.Text = '' then
  begin
    rModalAdd.Tag := 1;
    AdjustLayoutHeight(lytContractPriceC, 95);
    lContractPriceR.Visible := True;
    lContractPrice.TextSettings.FontColor := TAlphaColors.Red;
    if FirstInvalidPos = -1 then
      FirstInvalidPos := eContractPrice.Position.Y;
    HasError := True;
  end
  else
  begin
    AdjustLayoutHeight(lytContractPriceC, 75);
    lContractPriceR.Visible := False;
    lContractPrice.TextSettings.FontColor := TAlphaColors.Black;
  end;

  // Stop if any error is found
  if HasError then
  begin
    ScrollBox1.ViewportPosition := PointF(0, FirstInvalidPos - 50);
    Exit;
  end;

  // Proceed to save
  dm.qClients.Append;
  dm.qClients.FieldByName('name').AsString := eFullname.Text;
  dm.qClients.FieldByName('address').AsString := eAddress.Text;
  dm.qClients.FieldByName('contract_price').AsFloat := StrToFloat(eContractPrice.Text);
  dm.qClients.FieldByName('contract_date').AsDateTime := dContractDate.Date;
  dm.qClients.FieldByName('first_treatment').AsDateTime := dFirstTD.Date;
  dm.qClients.FieldByName('second_treatment').AsDateTime := dSecondTD.Date;
  dm.qClients.FieldByName('third_treatment').AsDateTime := dThirdTD.Date;
  dm.qClients.Post;

  dm.qClients.Refresh;
  dm.qActiveClients.Refresh;

  rBackground.Visible := False;
  rModalAdd.Visible := False;

  ClearItems;
end;

procedure TfrmMain.fClients1btnTriggerClick(Sender: TObject);
begin
  fClients1.btnTriggerClick(Sender);
end;

{ Form Close }
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

{ Form Create }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // components to hide
  HideComponents;

  // Add modal layout adjustments
  AdjustLayoutHeight(lytFullnameC, 75);
  AdjustLayoutHeight(lytAddressC, 75);
  AdjustLayoutHeight(lytContractPriceC, 75);

  // default Show sidebar
  mvSidebar.ShowMaster;

  // default hide the visibility of Add client modal
  rBackground.Visible := False;
  rModalAdd.Visible := False;

  // default tab index
  tcController.TabIndex := 0;
  fDashboard1.Visible := True;

  // hide other components
  fClients1.Visible := False;
  fContracts1.Visible := False;
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
  fClients1.Visible := True;
  fClients1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // hide other components
  fDashboard1.Visible := False;
  fContracts1.Visible := False;
end;

{ Show Tab for contracts }
procedure TfrmMain.sbContractsClick(Sender: TObject);
begin
  tcController.TabIndex := 2;
  fContracts1.Visible := True;
  fContracts1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // hide other components
  fClients1.Visible := False;
  fDashboard1.Visible := False;
end;

{ Show Tab for dashbaord }
procedure TfrmMain.sbDashboardClick(Sender: TObject);
begin
  tcController.TabIndex := 0;
  fDashboard1.Visible := True;
  fDashboard1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // hide other components
  fClients1.Visible := False;
  fContracts1.Visible := False;
end;

end.
