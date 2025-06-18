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
    lContractDate: TLabel;
    dContractDate: TDateEdit;
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
    gbTreatmentPhases: TGroupBox;
    lTreatmentPhaseW: TLabel;
    cbFirstTreatment: TCheckBox;
    cbSecondTreatment: TCheckBox;
    cbThirdTreatment: TCheckBox;
    lLabelPartialAmount: TLabel;
    procedure btnSaveContractClick(Sender: TObject);
    procedure cbClientSelectionClosePopup(Sender: TObject);
    procedure cbClientSelectionEnter(Sender: TObject);
    procedure sbContractDetailsClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure sbPreviewClick(Sender: TObject);
    procedure cbPaymentStatusChange(Sender: TObject);
    procedure cbSecondTreatmentChange(Sender: TObject);
    procedure cbThirdTreatmentChange(Sender: TObject);
  private
    procedure ClearItems;
    { Private declarations }
  public
    { Public declarations }
    RecordsStatus: String;
  end;

implementation

{$R *.fmx}

uses uDm, uMain;

var
  qName: String;
  qAddress: String;
  qDate: String;
  firstT: Boolean;
  secondT: Boolean;
  thirdT: Boolean;

procedure TfCreateContract.ClearItems;
begin
  cbClientSelection.ItemIndex := -1;
  lName.Text := 'Name: ';
  lAddress.Text := 'Address: ';
  mTreatmentInclusion.Lines.Clear;
  dContractDate.Date := now;
  cbPaymentStatus.ItemIndex := 0;
end;

{ On Enter Frame }
procedure TfCreateContract.FrameEnter(Sender: TObject);
begin
  lytContractDetails.Visible := True;
  fPDFCreation1.Visible := False;

  // Reset components
  lTreatmentPhaseW.Visible := False;
  gbTreatmentPhases.Height := 125;

  // checkbox reset trigger
  firstT := False;
  secondT := False;
  thirdT := False;
end;

{ Contract Details }
procedure TfCreateContract.sbContractDetailsClick(Sender: TObject);
begin
  lytContractDetails.Visible := True;
  fPDFCreation1.Visible := False;
end;

{ Number to word contract price }
function NumberToWords(Number: Integer): string;

  function ConvertHundreds(N: Integer): string;
  const
    Units: array[0..19] of string =
      ('ZERO', 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT',
       'NINE', 'TEN', 'ELEVEN', 'TWELVE', 'THIRTEEN', 'FOURTEEN', 'FIFTEEN',
       'SIXTEEN', 'SEVENTEEN', 'EIGHTEEN', 'NINETEEN');
    Tens: array[2..9] of string =
      ('TWENTY', 'THIRTY', 'FORTY', 'FIFTY', 'SIXTY', 'SEVENTY', 'EIGHTY', 'NINETY');
  var
    Res: string;
  begin
    Res := '';
    if N >= 100 then
    begin
      Res := Res + Units[N div 100] + ' HUNDRED';
      N := N mod 100;
      if N > 0 then
        Res := Res + ' ';
    end;

    if N >= 20 then
    begin
      Res := Res + Tens[N div 10];
      if (N mod 10) > 0 then
        Res := Res + '-' + Units[N mod 10];
    end
    else if N > 0 then
      Res := Res + Units[N];

    Result := Res;
  end;

var
  Millions, Thousands, Remainder: Integer;
begin
  if Number = 0 then
    Exit('ZERO');

  Result := '';
  Millions := Number div 1000000;
  Thousands := (Number div 1000) mod 1000;
  Remainder := Number mod 1000;

  if Millions > 0 then
  begin
    Result := Result + ConvertHundreds(Millions) + ' MILLION';
    if (Thousands > 0) or (Remainder > 0) then
      Result := Result + ' ';
  end;

  if Thousands > 0 then
  begin
    Result := Result + ConvertHundreds(Thousands) + ' THOUSAND';
    if Remainder > 0 then
      Result := Result + ' ';
  end;

  if Remainder > 0 then
    Result := Result + ConvertHundreds(Remainder);
end;


{ Contract Preview }
procedure TfCreateContract.sbPreviewClick(Sender: TObject);
var
  AmountValue: Integer;
  AmountInWords, FormattedAmount: string;
begin
  lytContractDetails.Visible := False;
  fPDFCreation1.Visible := True;

  fPDFCreation1.slClientName.Words.Items[1].Text := qName;
  fPDFCreation1.slAddressH.Words.Items[1].Text := qAddress;
  fPDFCreation1.slDateH.Text := dContractDate.Text;
  fPDFCreation1.slClientNameSig.Words.Items[0].Text := UpperCase(qName);

  // Convert numeric amount to words and assign to a label or slide
  if TryStrToInt(ePartialAmount.Text, AmountValue) then
  begin
    AmountInWords := NumberToWords(AmountValue) + ' PESOS';
    FormattedAmount := FormatFloat('#,##0', AmountValue); // This adds the comma separator

    fPDFCreation1.SkLabel12.Words.Items[2].Text := AmountInWords + ' ';
    fPDFCreation1.SkLabel12.Words.Items[3].Text := '(PHP ' + FormattedAmount + ')';
  end
  else
  begin
    fPDFCreation1.SkLabel12.Words.Items[2].Text := 'INVALID AMOUNT';
    fPDFCreation1.SkLabel12.Words.Items[3].Text := ' ()';
  end;
end;

{ Save contract }
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

  // Prevent saving the record if newly created & treatment phase has no check
  if RecordsStatus = 'Create' then
  begin
    if cbFirstTreatment.IsChecked = False then
    begin
      lTreatmentPhaseW.Visible := True;
      cbFirstTreatment.Margins.Top := 10;
      gbTreatmentPhases.Height := 140;
      Exit;
    end
    else
    begin
      lTreatmentPhaseW.Visible := False;
      cbFirstTreatment.Margins.Top := 30;
      gbTreatmentPhases.Height := 125;
    end;
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

  // Data to store
  dm.qContracts.FieldByName('client_name').AsString := qName;
  dm.qContracts.FieldByName('address').AsString := qAddress;
  dm.qContracts.FieldByName('treatment_inclusion').AsString := mTreatmentInclusion.Text;
  dm.qContracts.FieldByName('created_at').AsDateTime := dContractDate.Date;
  dm.qContracts.FieldByName('payment_status').AsString := cbPaymentStatus.Text;
  dm.qContracts.FieldByName('partial_amount').AsString := ePartialAmount.Text;

  // Trigger for checkbox
  if firstT = True then
  begin
    dm.qContracts.FieldByName('first_treatment').AsString := 'Done';
  end;

  if secondT = True then
  begin
    dm.qContracts.FieldByName('second_treatment').AsString := 'Done';
  end;

  if thirdT = True then
  begin
    dm.qContracts.FieldByName('third_treatment').AsString := 'Done';
  end;

  dm.qContracts.Post;

  dm.qContracts.Refresh;
  dm.qContracts.Close;
  ClearItems;

  // Record Message
  frmMain.RecordMessage('contract');
end;

{ Client Selection on Close }
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
  dm.qTemp.SQL.Text := 'SELECT name, address, contract_date FROM clients WHERE name = ' +
  QuotedStr(cbClientSelection.Text);
  dm.qTemp.Open;

  // Populate variables from extracted query
  if not dm.qTemp.IsEmpty then
  begin
    qName := dm.qTemp.FieldByName('name').AsString;
    qAddress := dm.qTemp.FieldByName('address').AsString;
    qDate := dm.qTemp.FieldByName('contract_date').AsString;
  end
  else
  begin
    qName := '';
    qAddress := '';
    qDate := '';
  end;

  // Close query
  dm.qTemp.Close;

  // Display the values
  lName.Text := 'Name: ' + qName;
  lAddress.Text := 'Address: ' + qAddress;
end;

{ Client Selection on Enter }
procedure TfCreateContract.cbClientSelectionEnter(Sender: TObject);
begin
  // Ensure dataset is refreshed before LiveBindings display
  if dm.qClientSelection.Active then
    dm.qClientSelection.Refresh
  else
    dm.qClientSelection.Active := True;
end;

{ Second Treatment Checkbox }
procedure TfCreateContract.cbSecondTreatmentChange(Sender: TObject);
begin
  if cbSecondTreatment.IsChecked = True then
  begin
    secondT := True;
  end
  else
  begin
    secondT := False;
  end;
end;

{ Third Treatment Checkbox }
procedure TfCreateContract.cbThirdTreatmentChange(Sender: TObject);
begin
  if cbSecondTreatment.IsChecked = True then
  begin
    thirdT := True;
  end
  else
  begin
    thirdT := False;
  end;
end;

{ Payment status change }
procedure TfCreateContract.cbPaymentStatusChange(Sender: TObject);
begin
  if cbPaymentStatus.Text = 'Initially Paid' then
  begin
    lLabelPartialAmount.Text := 'Partial Amount';
  end
  else
  begin
    lLabelPartialAmount.Text := 'Amount';
  end;
end;

end.
