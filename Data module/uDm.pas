unit uDm;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, System.ImageList,
  FMX.ImgList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tdm = class(TDataModule)
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    cData: TFDConnection;
    qClients: TFDQuery;
    qActiveClients: TFDQuery;
    qClientsid: TFDAutoIncField;
    qClientsname: TStringField;
    qClientsaddress: TStringField;
    qClientscontract_price: TBCDField;
    qClientscontract_date: TDateField;
    qClientsfirst_treatment: TDateField;
    qClientssecond_treatment: TDateField;
    qClientsthird_treatment: TDateField;
    qContracts: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
