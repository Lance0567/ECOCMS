unit uCreateContract;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ComboEdit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls;

type
  TfCreateContract = class(TFrame)
    lTitle: TLabel;
    lTitleC: TLayout;
    ScrollBox1: TScrollBox;
    rClientSelection: TRectangle;
    lClientSelection: TLabel;
    lDescription1: TLabel;
    ceClientSelection: TComboEdit;
    rContractDetails: TRectangle;
    lbContractDetails: TLabel;
    lDescription2: TLabel;
    gbRadioQuestion: TGroupBox;
    rbTypeA: TRadioButton;
    rbTypeB: TRadioButton;
    rbTypeC: TRadioButton;
    lServiceDescription: TLabel;
    Memo1: TMemo;
    FlowLayout1: TFlowLayout;
    lStartDate: TLabel;
    lytStartDate: TLayout;
    dStartDate: TDateEdit;
    Layout1: TLayout;
    lEndDate: TLabel;
    DateEdit1: TDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
