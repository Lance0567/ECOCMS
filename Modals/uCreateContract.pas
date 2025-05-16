unit uCreateContract;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ComboEdit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls, FMX.ListBox,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, uContracts;

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
    mServiceDescription: TMemo;
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
    procedure btnSaveContractClick(Sender: TObject);
    procedure cbClientSelectionClosePopup(Sender: TObject);
    procedure cbClientSelectionClick(Sender: TObject);
  private
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

  end;
end;

procedure TfCreateContract.cbClientSelectionClick(Sender: TObject);
begin
  cbClientSelection.Items.Clear;
  dm.qClientsSelection.Active := true;
end;

procedure TfCreateContract.cbClientSelectionClosePopup(Sender: TObject);
begin
  // Safety check
  if rClientData.Visible = False then
  begin
    rClientSelection.Height := 240;  // extend
    rClientData.Visible := true;  // show
  end;

  // Use query qTemp
  dm.qTemp.Close;
  dm.qTemp.SQL.Text := 'SELECT name, address FROM clients WHERE name = ' +
  QuotedStr(cbClientSelection.Text);

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
end;

end.
