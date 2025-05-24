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
  // Dashboard details
  TDashboard = class(TObject)
    totalContracts: integer;
    fullyPaid: integer;
    partiallyPaid: integer;
  end;

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
    qClientSelection: TFDQuery;
    qTemp: TFDQuery;
    qFullyPaid: TFDQuery;
    qPartiallyPaid: TFDQuery;
    qTotalContracts: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDashboard: TDashboard;
  public
    { Public declarations }
    property Dashboard: TDashboard read FDashboard write FDashboard;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

// TODO -oLance -cImportant: Create a procedure for relative path of DBbtnTrigger
procedure Tdm.DataModuleCreate(Sender: TObject);
var
  DBPath: String;
begin
  // Class
  FDashboard := TDashboard.Create;

  // Connection clearing
  cData.Connected := False;
  cData.Params.Values['Database'] := '';

  // Get the directory of the executable relative path
  DBPath := ExtractFilePath(ParamStr(0)) + 'database\ecopro.db';
  cData.Params.Values['DriverID'] := 'SQLite';
  cData.Params.Values['Database'] := DBPath;

  // Deactivate queries
  qActiveClients.Close;
  qTotalContracts.Close;
  qFullyPaid.Close;
  qPartiallyPaid.Close;
  qClients.Close;
  qContracts.Close;
  qClientSelection.Close;

  // activate connection
  cData.Connected := True;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  FDashboard.Free;
end;

end.
