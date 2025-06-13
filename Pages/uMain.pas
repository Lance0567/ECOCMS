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
  FMX.Memo.Types, FMX.DialogService, FMX.ScrollBox, FMX.Memo, uCreateContract,
  uCompile, FMX.Ani;

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
    tiCreateContract: TTabItem;
    fCreateContract1: TfCreateContract;
    Line1: TLine;
    lytPopUpBottom: TLayout;
    lytPopUpMessage: TLayout;
    rPopUp: TRectangle;
    lbPopUp: TLabel;
    FloatAnimation1: TFloatAnimation;
    gPopUp: TGlyph;
    Timer1: TTimer;
    procedure mvSidebarResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbDashboardClick(Sender: TObject);
    procedure sbClientsClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure fClients1btnTriggerClick(Sender: TObject);
    procedure ClearItems;
    procedure HideComponents;
    procedure sbContractsClick(Sender: TObject);
    procedure tcControllerChange(Sender: TObject);
    procedure mvSidebarResized(Sender: TObject);
    procedure fContracts1btnTriggerClick(Sender: TObject);
    procedure lytSidebarResized(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure fCreateContract1btnCancelClick(Sender: TObject);
    procedure fCreateContract1btnSaveContractClick(Sender: TObject);
    procedure fDashboard1cbtnViewAllContractsClick(Sender: TObject);
    procedure fClients1eSearchChangeTracking(Sender: TObject);
    procedure fContracts1eSearchChangeTracking(Sender: TObject);
    procedure fClients1EditClick(Sender: TObject);
    procedure fClients1DeleteClick(Sender: TObject);
    procedure fContracts1DeleteClick(Sender: TObject);
    procedure fContracts1EditClick(Sender: TObject);
    procedure SpinEditButton1UpClick(Sender: TObject);
    procedure SpinEditButton1DownClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    procedure HideFrames;
    procedure ShowConfirmationDialog(const TheMessage: string);
    procedure ShowMessageDialog(const TheMessage: string);
    { Private declarations }
  public
    { Public declarations }
    procedure QueryHandler;
    procedure dashboard;
  end;

var
  frmMain: TfrmMain;
  setDelete: String;

implementation

{$R *.fmx}

uses uDm, FireDAC.Stan.Param;

{ Query Management }
procedure TfrmMain.QueryHandler;
begin
  dm.qActiveClients.Active := false;
  dm.qFullyPaid.Active := false;
  dm.qPartiallyPaid.Active := false;
  dm.qTotalContracts.Active := false;
  dm.qClients.Active := false;
  dm.qContracts.Active := false;
end;

{ Hide fields from the add client modal }
procedure TfrmMain.HideComponents;
begin
  // Default hide Label Required fields
  lFullnameR.Visible := False;
  lAddressR.Visible := False;
  lContractPriceR.Visible := False;
end;

{ Clear items for add client modal }
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

{ Hide Frames }
procedure TfrmMain.HideFrames;
begin
  fDashboard1.Visible := False;
  fClients1.Visible := False;
  fContracts1.Visible := False;
  fCreateContract1.Visible := False;
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
  dm.qClients.Cancel;
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
  if HasError = True then
  begin
    ScrollBox1.ViewportPosition := PointF(0, FirstInvalidPos - 50);
    Exit;
  end;

  dm.qClients.Edit;

  // Proceed to save
  dm.qClients.FieldByName('name').AsString := eFullname.Text;
  dm.qClients.FieldByName('address').AsString := eAddress.Text;
  dm.qClients.FieldByName('contract_price').AsFloat := StrToFloat(eContractPrice.Text);
  dm.qClients.FieldByName('contract_date').AsString := dContractDate.Text;
  dm.qClients.FieldByName('first_treatment').AsString := dFirstTD.Text;
  dm.qClients.FieldByName('second_treatment').AsString := dSecondTD.Text;
  dm.qClients.FieldByName('third_treatment').AsString := dThirdTD.Text;
  dm.qClients.Post;
  dm.qClients.Refresh;

  rBackground.Visible := False;
  rModalAdd.Visible := False;

  ClearItems;

  // pop up function
  rPopUp.Height := 0;
  lytPopUpBottom.Visible := True;
  FloatAnimation1.Enabled := True;
  Timer1.Enabled := True; // Start the 5-second countdown

  // Message of the pop up and color setting
  if Self.Tag = 0 then
  begin
    lbPopUp.Text := 'Successfully added the client!';
    rPopUp.Fill.Color := TAlphaColorRec.Green;
  end
  else if Self.Tag = 1 then
  begin
    lbPopUp.Text := 'Successfully updated the client!';
    rPopUp.Fill.Color := TAlphaColorRec.Yellow;
  end
  else
  begin
    lbPopUp.Text := 'Successfully deleted the client!';
    rPopUp.Fill.Color := TAlphaColorRec.Red;
  end;
end;

{ Timer }
procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False; // Stop the timer
  lytPopUpBottom.Visible := False; // Hide the snackbar
end;

{ Float animation }
procedure TfrmMain.FloatAnimation1Finish(Sender: TObject);
begin
  FloatAnimation1.Enabled := False;
end;

{ Add client }
procedure TfrmMain.fClients1btnTriggerClick(Sender: TObject);
begin
  fClients1.btnTriggerClick(Sender);

  // Set Date components
  dContractDate.Date := Now;
  dFirstTD.Date := Now;
  dSecondTD.Date := IncMonth(Now, 1); // Add 1 month to today
  dThirdTD.Date := IncMonth(Now, 2);
end;

{ Delete client }
procedure TfrmMain.fClients1DeleteClick(Sender: TObject);
begin
  setDelete := 'client';
  ShowConfirmationDialog('You wish to delete the selected client?');

  frmMain.Tag := 2;
end;

{ Delete contract }
procedure TfrmMain.fContracts1DeleteClick(Sender: TObject);
begin
  setDelete := 'contract';
  ShowConfirmationDialog('You wish to delete the selected contract?');
end;

{ Show Confirmation dialog for client & contract }
procedure TfrmMain.ShowConfirmationDialog(const TheMessage: string);
begin
  TDialogService.MessageDialog(TheMessage, TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbYes, 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYES then
      begin
        TDialogService.MessageDialog('Are you sure? This will permanently delete the data!',
          TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
          TMsgDlgBtn.mbYes, 0,
          procedure(const AResult: TModalResult)
          begin
            if AResult = mrYES then
            begin
              // Delete input data from the database
              try
                if setDelete = 'client' then
                begin
                  dm.qClients.Delete;
                  setDelete := '';
                end
                else if setDelete = 'contract' then
                begin
                  dm.qContracts.Delete;
                  setDelete := '';
                end;
              except
                ShowMessageDialog('Cannot be deleted unless the saved datas inside are deleted');
              end;
            end
            else
              ShowMessageDialog('Deletion canceled');
          end);
      end
      else if AResult = mrNo then
        ShowMessageDialog('You chose No');
    end);
end;

{ Alert Show Dialog message }
procedure TfrmMain.ShowMessageDialog(const TheMessage: string);
begin
  TDialogService.MessageDialog(TheMessage, TMsgDlgType.mtInformation,
    [TMsgDlgBtn.mbOk], TMsgDlgBtn.mbOk, 0, nil);
end;

{ Spin down }
procedure TfrmMain.SpinEditButton1DownClick(Sender: TObject);
var
  Value: Double;
begin
  if TryStrToFloat(eContractPrice.Text, Value) then
    Value := Value - 0.1
  else
    Value := 0;
  eContractPrice.Text := FormatFloat('0.0', Value);
end;

{ Spin up }
procedure TfrmMain.SpinEditButton1UpClick(Sender: TObject);
var
  Value: Double;
begin
  if TryStrToFloat(eContractPrice.Text, Value) then
    Value := Value + 0.1
  else
    Value := 0;
  eContractPrice.Text := FormatFloat('0.0', Value);  // Format as 1 decimal place
end;

{ Edit client }
procedure TfrmMain.fClients1EditClick(Sender: TObject);
begin
  // Populate the form
  eFullname.Text := dm.qClients.FieldByName('name').AsString;;
  eAddress.Text := dm.qClients.FieldByName('address').AsString;;
  dContractDate.DateTime := dm.qClients.FieldByName('contract_date').AsDateTime;
  eContractPrice.Text := dm.qClients.FieldByName('contract_price').AsString;
  dFirstTD.DateTime := dm.qClients.FieldByName('first_treatment').AsDateTime;
  dSecondTD.DateTime := dm.qClients.FieldByName('second_treatment').AsDateTime;
  dThirdTD.DateTime := dm.qClients.FieldByName('third_treatment').AsDateTime;

  // visibility show of Add client modal
  frmMain.rBackground.Visible := True;
  frmMain.rModalAdd.Visible := True;

  ScrollBox1.ViewportPosition := PointF(0,0);
  HideComponents;

  frmMain.Tag := 1;
end;

{ Edit contract }
procedure TfrmMain.fContracts1EditClick(Sender: TObject);
var
  clientName: String;
  clientAddress: String;
begin
  // Hide other components
  HideFrames;
  fCreateContract1.cbClientSelection.Visible := false;
  fCreateContract1.lClientSelectionR.Visible := false;
  fCreateContract1.cbPaymentStatus.Visible := false;

  // adjust height
  fCreateContract1.rClientSelection.Height := 200;

  // Show component
  fCreateContract1.ePartialAmount.Visible := true;

  // Populate fields
  clientName := 'Name: ' + dm.qContracts.FieldByName('client_name').AsString;
  clientAddress := 'Address: ' + dm.qContracts.FieldByName('address').AsString;
  fCreateContract1.lName.Text := clientName;
  fCreateContract1.lAddress.Text := clientAddress;
  fCreateContract1.mTreatmentInclusion.Text := dm.qContracts.FieldByName('treatment_inclusion').AsString;
  fCreateContract1.dDate.DateTime := dm.qContracts.FieldByName('date').AsDateTime;
  fCreateContract1.ePartialAmount.Text := dm.qContracts.FieldByName('status').AsString;

  // Switch tab index
  tcController.TabIndex := 3;
  fCreateContract1.Visible := True;
  fCreateContract1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar
  fCreateContract1.Tag := 1;
end;

{ Client Search Procedure }
procedure TfrmMain.fClients1eSearchChangeTracking(Sender: TObject);
var
  SearchText: string;
begin
  dm.qClients.DisableControls;
  try
    dm.qClients.Close;

    if Trim(fClients1.eSearch.Text) = '' then
    begin
      // No search: load all records
      dm.qClients.SQL.Text := 'SELECT * FROM clients';
    end
    else
    begin
      // Search with parameter
      dm.qClients.SQL.Text := 'SELECT * FROM clients WHERE name LIKE :search';
      SearchText := '%' + fClients1.eSearch.Text + '%';
      dm.qClients.ParamByName('search').AsString := SearchText;
    end;

    dm.qClients.Open;
  finally
    dm.qClients.EnableControls;
  end;
end;

{ Form Close }
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

{ Form Create }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fClients1.Tag := 0;
  fContracts1.Tag := 0;

  // Components to hide
  HideComponents;

  // Add modal layout adjustments
  AdjustLayoutHeight(lytFullnameC, 75);
  AdjustLayoutHeight(lytAddressC, 75);
  AdjustLayoutHeight(lytContractPriceC, 75);

  // default Show sidebar
  mvSidebar.ShowMaster;
  mvSidebar.NavigationPaneOptions.CollapsedWidth := 50;

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

{ Form Resize }
procedure TfrmMain.FormResize(Sender: TObject);
begin
  case tcController.TabIndex of
    1:fClients1.GridContentsResponsive;
    2:fContracts1.GridContentsResponsive;
  end;
end;

{ Sidebar Resize }
procedure TfrmMain.mvSidebarResize(Sender: TObject);
begin
  lytSidebar.Width := mvSidebar.Width;
//  Self.Caption := 'Main Form' + ' Height: '
//  + Self.Height.ToString + ' Width: ' + Self.Width.ToString
//  + ' Multiview collapsed width: ' + FloatToStr(mvSidebar.Width);
  Self.Caption := 'Eco Pro Disinfecting and Pest Management Services';
end;

procedure TfrmMain.lytSidebarResized(Sender: TObject);
begin
  if lytSidebar.Width = 50 then
  begin
    case tcController.TabIndex of
      1:fClients1.GridContentsResponsive;
      2:fContracts1.GridContentsResponsive;
    end;
  end;

  if lytSidebar.Width = 200 then
  begin
    case tcController.TabIndex of
      1:fClients1.GridContentsResponsive;
      2:fContracts1.GridContentsResponsive;
    end;
  end;
end;

procedure TfrmMain.mvSidebarResized(Sender: TObject);
begin
  if lytSidebar.Width <= 51 then
  begin
    lytSidebar.Width := 50
  end;

  if lytSidebar.Width >= 199 then
  begin
    lytSidebar.Width := 200
  end;
end;

// dashboard query active handler
procedure TfrmMain.dashboard;
begin
//  fDashboard1.ListView1.Items[1].Data['Text2'] := 'Created:';
  dm.qTotalContracts.Active := true;
  dm.qActiveClients.Active := true;
  dm.qFullyPaid.Active := true;
  dm.qPartiallyPaid.Active := true;
  dm.qRecentContracts.Open;
end;

{ Open query based on the tab }
procedure TfrmMain.tcControllerChange(Sender: TObject);
begin
  // Deactivate first all queries
  QueryHandler;

  case tcController.TabIndex of
    0: dashboard;
    1: dm.qClients.Open;
    2: dm.qContracts.Open;
    3: dm.qContracts.Open;
  end;
end;

{ Show Tab for dashbaord }
procedure TfrmMain.sbDashboardClick(Sender: TObject);
begin
  // Switch tab index
  tcController.TabIndex := 0;
  fDashboard1.Visible := True;
  fDashboard1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // hide other components
  fClients1.Visible := False;
  fContracts1.Visible := False;
end;

{ Show Tab for clients }
procedure TfrmMain.sbClientsClick(Sender: TObject);
begin
  // hide other components
  HideFrames;

  // Switch tab index
  tcController.TabIndex := 1;
  fClients1.Visible := True;
  fClients1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // Activate responsiveness
  fClients1.GridContentsResponsive;
end;

{ Show Tab for contracts }
procedure TfrmMain.sbContractsClick(Sender: TObject);
begin
  // hide other components
  HideFrames;

  // Switch tab index
  tcController.TabIndex := 2;
  fContracts1.Visible := True;
  fContracts1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // Activate responsiveness
  fContracts1.GridContentsResponsive;
end;

{ Create contract }
procedure TfrmMain.fContracts1btnTriggerClick(Sender: TObject);
begin
  // hide other components
  HideFrames;
  fCreateContract1.cbClientSelection.Visible := true;
  fCreateContract1.lClientSelectionR.Visible := true;
  fCreateContract1.cbPaymentStatus.Visible := true;

   // Show component
  fCreateContract1.ePartialAmount.Visible := true;

  // adjust height
  fCreateContract1.rClientSelection.Height := 255;

  // Switch tab index
  tcController.TabIndex := 3;
  fCreateContract1.Visible := True;
  fCreateContract1.ScrollBox1.ViewportPosition := PointF(0,0); // reset scroll bar

  // Populate cbClientSelection (ComboBox)
  fCreateContract1.cbClientSelection.Items.Clear;
  fCreateContract1.cbClientSelection.Items.Add('Select a client');
  fCreateContract1.cbClientSelection.ItemIndex := 0;
  fCreateContract1.cbPaymentStatus.ItemIndex := 0;
  fCreateContract1.rClientSelection.Height := 135;
  fCreateContract1.lClientSelectionR.Visible := False;
  fCreateContract1.rClientData.Visible := False;
  fCreateContract1.Tag := 0;

  // Empty the Partial payment input
  fCreateContract1.ePartialAmount.Text := '';
end;

// Contract Search Procedure
procedure TfrmMain.fContracts1eSearchChangeTracking(Sender: TObject);
var
  SearchText: string;
begin
  dm.qContracts.DisableControls;
  try
    dm.qContracts.Close;

    if Trim(fContracts1.eSearch.Text) = '' then
    begin
      // No search: load all records
      dm.qContracts.SQL.Text := 'SELECT * FROM contracts';
    end
    else
    begin
      // Search with parameter
      dm.qContracts.SQL.Text := 'SELECT * FROM contracts WHERE client_name LIKE :search';
      SearchText := '%' + fContracts1.eSearch.Text + '%';
      dm.qContracts.ParamByName('search').AsString := SearchText;
    end;

    dm.qContracts.Open;
  finally
    dm.qContracts.EnableControls;
  end;
end;

{ Cancel button from Create Contract }
procedure TfrmMain.fCreateContract1btnCancelClick(Sender: TObject);
begin
  // hide other components
  HideFrames;

  // Switch tab index
  tcController.TabIndex := 2;
  fContracts1.Visible := True;
  fContracts1.ScrollBox1.ViewportPosition := PointF(0, 0); // reset scroll bar

  fContracts1.GridContentsResponsive;
end;

{ Save button from Create contract }
procedure TfrmMain.fCreateContract1btnSaveContractClick(Sender: TObject);
begin
  fCreateContract1.btnSaveContractClick(Sender);

  if not fCreateContract1.lClientSelectionR.Visible = True then
  begin
    // hide other components
    HideFrames;

    // Switch tab index
    tcController.TabIndex := 2;
    fContracts1.Visible := True;
    fContracts1.ScrollBox1.ViewportPosition := PointF(0, 0); // reset scroll bar

    fContracts1.GridContentsResponsive;
  end;
end;

// View all contract
procedure TfrmMain.fDashboard1cbtnViewAllContractsClick(Sender: TObject);
begin
  tcController.TabIndex := 2;
  fContracts1.Visible := True;
end;

end.
