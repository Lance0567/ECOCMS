unit uCreateContract;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ComboEdit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, uContracts,
  uCompile, Data.DB;

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
    Layout1: TLayout;
    btnCancel: TCornerButton;
    btnSaveContract: TCornerButton;
    lPaymentStatus: TLabel;
    cbPaymentStatus: TComboBox;
    cbClientSelection: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    lClientSelectionR: TLabel;
    Label2: TLabel;
    procedure btnSaveContractClick(Sender: TObject);
    procedure cbClientSelectionClosePopup(Sender: TObject);
    procedure cbClientSelectionEnter(Sender: TObject);
  private
    procedure ClearItems;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uDm;

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

procedure TfCreateContract.btnSaveContractClick(Sender: TObject);
var
  HasError: Boolean;
  FirstInvalidPOS: Single;
begin
  HasError := False;
  FirstInvalidPOS := -1;

  // Client name selection
  if cbClientSelection.Text = '' then
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
    ScrollBox1.ViewportPosition := PointF(0, FirstInvalidPOS - 50);
    Exit;
  end;

  // Open query
  dm.qContracts.Open;

  // Proceed to save
  dm.qContracts.Append;
  dm.qContracts.FieldByName('client_name').AsString := qName;
  dm.qContracts.FieldByName('address').AsString := qAddress;
  dm.qContracts.FieldByName('treatment_inclusion').AsString := mTreatmentInclusion.Text;
  dm.qContracts.FieldByName('date').AsDateTime := dDate.Date;
  dm.qContracts.FieldByName('status').AsString := cbPaymentStatus.Text;
  dm.qContracts.Post;

  dm.qContracts.Refresh;
  dm.qContracts.Close;
  ClearItems;
end;

procedure TfCreateContract.cbClientSelectionClosePopup(Sender: TObject);
begin
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

end.
