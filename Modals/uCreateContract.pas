unit uCreateContract;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ComboEdit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls, FMX.ListBox;

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
    procedure btnSaveContractClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uDm;

procedure TfCreateContract.btnSaveContractClick(Sender: TObject);
var
  HasError: Boolean;
  FirstInvalidPOS: Single;
begin
  HasError := False;
  FirstInvalidPOS := -1;

  if cbClientSelection.Text = '' then
  begin

  end;
end;

end.
