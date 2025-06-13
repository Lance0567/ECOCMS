unit uCreateContract;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ComboEdit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, uContracts,
  uCompile, Data.DB, uPDFCreation;

type
  TfCreateContract = class(TFrame)
    lTitle: TLabel;
    lTitleC: TLayout;
    ScrollBox1: TScrollBox;
    rClientSelection: TRectangle;
    lClientSelection: TLabel;
    lDescription1: TLabel;
    rContractDetails: TRectangle;
    lbContractDetails: TLabel;
    lDescription: TLabel;
    lTreatmentInclusion: TLabel;
    mTreatmentInclusion: TMemo;
    lDate: TLabel;
    dDate: TDateEdit;
    rClientData: TRectangle;
    lName: TLabel;
    lAddress: TLabel;
    lytButtonH: TLayout;
    btnCancel: TCornerButton;
    btnSaveContract: TCornerButton;
    lPaymentStatus: TLabel;
    cbClientSelection: TComboBox;
    BindSourceDBClientSel: TBindSourceDB;
    BindingsListClientSel: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    lClientSelectionR: TLabel;
    Label2: TLabel;
    rButtonH: TRectangle;
    lytContractDetails: TLayout;
    fPDFCreation1: TfPDFCreation;
    GridPanelLayout1: TGridPanelLayout;
    sbPreview: TCornerButton;
    sbContractDetails: TCornerButton;
    Layout1: TLayout;
    cbPaymentStatus: TComboBox;
    ePartialAmount: TEdit;
    procedure btnSaveContractClick(Sender: TObject);
    procedure cbClientSelectionClosePopup(Sender: TObject);
    procedure cbClientSelectionEnter(Sender: TObject);
    procedure sbContractDetailsClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure sbPreviewClick(Sender: TObject);
    procedure cbPaymentStatusChange(Sender: TObject);
  private
    procedure ClearItems;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uDm, uMain;

var
  qName: String;
  qAddress: String;

procedure TfCreateContract.ClearItems;
begin
  cbClientSelection.ItemIndex := -1;
  lName.Text := 'Name: ';
  lAddress.Text := 'Address: ';
  mTreatmentInclusion.Lines.Clear;
  dDate.Date := now;
  cbPaymentStatus.ItemIndex := 0;
end;

procedure TfCreateContract.FrameEnter(Sender: TObject);
begin
  lytContractDetails.Visible := True;
  fPDFCreation1.Visible := False;
end;

procedure TfCreateContract.sbContractDetailsClick(Sender: TObject);
begin
  lytContractDetails.Visible := True;
  fPDFCreation1.Visible := False;
end;

procedure TfCreateContract.sbPreviewClick(Sender: TObject);
begin
  lytContractDetails.Visible := False;
  fPDFCreation1.Visible := True;

  fPDFCreation1.slClientName.Words.Items[1].Text := qName;
  fPDFCreation1.slAddressH.Words.Items[1].Text := qAddress;
  fPDFCreation1.slDateH.Text := dDate.Text;
  fPDFCreation1.slClientNameSig.Words.Items[0].Text := qName;
end;

procedure TfCreateContract.btnSaveContractClick(Sender: TObject);
var
  HasError: Boolean;
  FirstInvalidPOS: Single;
begin
  HasError := False;
  FirstInvalidPOS := -1;

  // Client name selection
  if (cbClientSelection.Text = '') OR (cbClientSelection.Text = 'Select a client') then
  begin
    rClientSelection.Height := 160;
    lClientSelectionR.Visible := True;
    lClientSelection.TextSettings.FontColor := TAlphaColorRec.Red;
    if FirstInvalidPOS = -1 then
      FirstInvalidPOS := cbClientSelection.Position.Y;
    HasError := True;
  end
  else
  begin
    rClientSelection.Height := 135;
    lClientSelection.TextSettings.FontColor := TAlphaColorRec.Black;
  end;

  // Stop if any error is found
  if HasError = True then
  begin
    ScrollBox1.ViewportPosition := PointF(0, FirstInvalidPOS - 100);
    Exit;
  end;

  // Open query
  dm.qContracts.Open;

  // Proceed to save
  if Self.Tag = 0 then
  begin
    dm.qContracts.Append;
  end
  else if Self.Tag = 1 then
  begin
    dm.qContracts.Edit;
  end;

  dm.qContracts.FieldByName('client_name').AsString := qName;
  dm.qContracts.FieldByName('address').AsString := qAddress;
  dm.qContracts.FieldByName('treatment_inclusion').AsString := mTreatmentInclusion.Text;
  dm.qContracts.FieldByName('date').AsDateTime := dDate.Date;
  dm.qContracts.FieldByName('status').AsString := cbPaymentStatus.Text;
  dm.qContracts.FieldByName('partial_amount').AsString := ePartialAmount.Text;
  dm.qContracts.Post;

  dm.qContracts.Refresh;
  dm.qContracts.Close;
  ClearItems;
end;

procedure TfCreateContract.cbClientSelectionClosePopup(Sender: TObject);
begin
  // Disable required warning and return to normal
  if lClientSelectionR.Visible = True then
  begin
    lClientSelectionR.Visible := False;
    rClientSelection.Height := 135;
    lClientSelection.TextSettings.FontColor := TAlphaColorRec.Black;
  end;

  // Safety check
  if rClientData.Visible = False then
  begin
    rClientSelection.Height := 230;  // extend
    rClientData.Visible := true;  // show
  end;

  // Use query qTemp
  dm.qTemp.Close;
  dm.qTemp.SQL.Text := 'SELECT name, address FROM clients WHERE name = ' +
  QuotedStr(cbClientSelection.Text);
  dm.qTemp.Open;

  // Populate variables from extracted query
  if not dm.qTemp.IsEmpty then
  begin
    qName := dm.qTemp.FieldByName('name').AsString;
    qAddress := dm.qTemp.FieldByName('address').AsString;
  end
  else
  begin
    qName := '';
    qAddress := '';
  end;

  // Close query
  dm.qTemp.Close;

  // Display the values
  lName.Text := 'Name: ' + qName;
  lAddress.Text := 'Address: ' + qAddress;
end;

procedure TfCreateContract.cbClientSelectionEnter(Sender: TObject);
begin
  // Ensure dataset is refreshed before LiveBindings display
  if dm.qClientSelection.Active then
    dm.qClientSelection.Refresh
  else
    dm.qClientSelection.Active := True;
end;

procedure TfCreateContract.cbPaymentStatusChange(Sender: TObject);
begin
  if cbPaymentStatus.Text = 'Initially Paid' then
  begin
    ePartialAmount.Visible := True;
    rContractDetails.Height := 470;
  end
  else
  begin
    ePartialAmount.Visible := False;
    rContractDetails.Height := 420;
  end;
end;

end.
